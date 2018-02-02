var express = require('express');
var sanitizer = require('sanitizer');
var fs = require('fs');
var formidable = require('formidable');
var mysql = require('./mysql');
var router = express.Router();

var resMessage = [
	"pass", 
	"分類重複！", 
	"分類不能超過10個中文、英文、數字組成的字符！", 
	"标题太长", 
	"关键字太长", 
	"摘要太长", 
	"上传文件大小超过限制！", 
	"请上传png、jpg、gif等图片文件！",
	"网络异常！"
];
var resMessageIndex;

/* GET home page. */
router.get('/', function (req, res) {
	var categoryJ = 0;
	var category_id = req.query.category_id;
	mysql.getPost("%", category_id, "%", function (result) {
		mysql.getCategory(function (category) {
			for (var i = 0; i < category.length; i++) {
				categoryJ = categoryJ + category[i].cname;
			}
			res.render('index', { 
				title: '网站主页', 
				data: result, 
				category: category,  
				categoryJ: categoryJ 
			});
		});
	});
});

/* GET post page */
router.get('/post/:uri([0-9a-zA-Z]{10})', function (req, res) {
	var uri = req.params.uri;
	var category_id;
	var post_id;
	mysql.gettotal(uri, function (total) {
		mysql.getPost(uri, "%", "%", function (result) {
			for (var key in result) {
				result[key].content = sanitizer.unescapeEntities(result[key].content);
				post_id = result[key].post_id;
			}
			category_id = result[0].category_id;
			mysql.getCategory(function (category) {
				mysql.getComments(post_id, function (comments) {
					mysql.getPost("%", category_id, "%", function (recommends) {
						res.render('post', { 
							title: '文章页',
							data: result, 
							category: category, 
							total: total, 
							comments: comments, 
							recommends: recommends
						});
					});
				});
			});
		});
	});
});

/* 提交文章评论响应 */
router.post('/post/:uri([0-9a-zA-Z]{10})', function (req, res) {
	var post_id = req.body.post_id;
	if(req.body.url != "") {
		var url = sanitizer.escape(req.body.url);
	}else{
		var url = "#";
	}
	var nickname = sanitizer.escape(req.body.nickname);
	var content = sanitizer.escape(req.body.content);
	var date = new Date();
	var ip = req.ip.substr(7);
	var disable = true;
	var data = [post_id, url, nickname, content, date, ip, disable];
	mysql.addComments(data, function(category) {
		resMessageIndex = 0;
		res.send(200, resMessage[resMessageIndex]);
	});
});

/* 获取登录页 */
router.get('/login', function (req, res) {
	res.render('login', { title: '登录' });
});

/* 获取管理员首页 */
router.get('/admin-index', function (req, res) {
	res.render('admin-index', { title: '管理员首页' });
});

/* 获取管理员创建分类页 */
router.get('/admin-category', function (req, res) {
	mysql.getCategory(function (result) {
		res.render('admin-category', { title: '创建分类页', data: result });
	});
});

/* 管理员创建分类页请求响应 */
router.post('/admin-category', function (req, res) {
	var category = req.body.category;
	var reg = /^[a-zA-Z0-9\u4e00-\u9af5]{1,10}$/;
	if(!reg.test(category)) {
		resMessageIndex = 2;
		return res.send(resMessage[resMessageIndex]);
	}
	mysql.checkCategory(category, function (result) {
		if(result == 0) {
			resMessageIndex = 1;
			res.send(resMessage[resMessageIndex]);
		}else {
			mysql.addCategory(category, function (result) {
				resMessageIndex = 0;
				res.send(resMessage[resMessageIndex]);
			});
		}
	});
});

/* 获取管理员发布文章页 */
router.get('/admin-push-post', function (req, res) {
	mysql.getCategory(function (result) {
		res.render('admin-push-post', { title: '发布文章页', data: result });
	});
});

/* 管理员发布文章页请求响应 */
router.post('/admin-push-post', function (req, res) {
	var title = sanitizer.escape(req.body.title);
	var keyWords = sanitizer.escape(req.body.keyWords);
	var summary = sanitizer.escape(req.body.summary);
	var category_id = req.body.category_id;
	var image_url = sanitizer.escape(req.body.image_url);
	var content = sanitizer.escape(req.body.content);
	var date = new Date();
	var post_uri = sanitizer.escape(req.body.post_uri);
	var array = [post_uri, title, keyWords, summary, image_url, content, date, category_id];
	if(title.length > 40) {
		resMessageIndex = 3;
		return res.send(resMessage[resMessageIndex]);
	}
	if(keyWords.length > 20) {
		resMessageIndex = 4;
		return res.send(resMessage[resMessageIndex]);
	}
	if(summary.length > 100) {
		resMessageIndex = 5;
		return res.send(resMessage[resMessageIndex]);
	}
	mysql.insertPost(array, function (result) {
		resMessageIndex = 0;
		return res.send(resMessage[resMessageIndex]);
	});
});

/* 管理员发布文章页图片请求响应 */
router.post('/admin-upload-file/:uri([0-9a-zA-Z]{10})', function (req, res) {
	var form = new formidable.IncomingForm();
	var flag = true;
	var postUriDirectory = req.params.uri;
	form.uploadDir = __dirname + '/../tmp';
	form.maxFieldsSize = 4 * 1024 * 1024;
	form.on('progress', function (bytesReceived, bytesExpected) {
		if(bytesReceived > form.maxFieldsSize) 
			resMessageIndex = 6, flag = false;
	})
	.on('fileBegin', function (name, file) {
		if(file.type != "image/png" && file.type != "image/jpeg" && file.type != "image/gif") 
			resMessageIndex = 7, flag = false;
	})
	.on('file', function (name, file) {
		if(flag == true) {
			var extName = ""; 
			switch(file.type) {
				case "image/png": 
					extName = "png"; 
					break; 
				case "image/gif": 
					extName = "gif"; 
					break; 
				default: 
					extName = "jpg"; 
			}
			var date = new Date(),
				dateDirectory = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2),
				dateDay = ("0" + date.getDate()).slice(-2),
				imgPath = __dirname + "/../public/images/charImg";
			if(!fs.existsSync(imgPath + "/" + dateDirectory)) 
				fs.mkdirSync(imgPath + "/" + dateDirectory);
			if(!fs.existsSync(imgPath + "/" + dateDirectory + "/" + dateDay)) 
				fs.mkdirSync(imgPath + "/" + dateDirectory + "/" + dateDay);
			fs.renameSync(file.path, imgPath + "/" + dateDirectory + "/" + dateDay + "/" + 
				postUriDirectory + date.getTime() + "." + extName);
			var tmps = "/images/charImg" + "/" + dateDirectory + "/" + dateDay  + "/" + 
				postUriDirectory + date.getTime() + "." + extName;
			return res.send({resCode: 0, resMsg: 'success', data: tmps});
		}else {
			res.header('Connection', 'close');
			return res.send({resCode: 500, resMsg: resMessage[resMessageIndex]});
		}
	})
	.on('error', function (err) {
		resMessageIndex = 8, flag = false;
	});
	form.parse(req);
});

/* 获取管理员编辑文章页 */
router.get('/admin-edit-post', function (req, res) {
	var category_id = req.query.category_id;
	var title = req.query.title;
	mysql.getPost("%", category_id, title, function (result) {
		mysql.getCategory(function (category) {
			res.render('admin-edit-post', { 
				title: '编辑文章页', 
				data: result, 
				category: category 
			});
		})
	});
});

/* 管理员编辑文章页删除文章响应 */
router.post('/admin-delete-post', function (req, res) {
	var post_id = req.body.post_id;
	mysql.deletePost(post_id, function (result) {
		resMessageIndex = 0;
		res.send(200, resMessage[resMessageIndex]);
	})
})

/* 获取管理员审核评论页 */
router.get('/admin-comment', function (req, res) {
	mysql.getComments("%", function (comments) {
		res.render('admin-comment', { title: '审核评论页', comments: comments });
	});
});

/* 管理员审核评论页删除评论响应 */
router.post('/admin-verify-comment', function (req, res) {
	var comment_id = req.body.comment_id;
	mysql.VerifyComment(comment_id, function (result) {
		resMessageIndex = 0;
		res.send(200, resMessage[resMessageIndex]);
	});
})

/* 获取管理员退出页 */
router.get('/admin-logout', function (req, res) {
	res.render('admin-logout', { title: '退出登录页' });
});

module.exports = router;

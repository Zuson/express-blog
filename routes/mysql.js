var mysql = require('mysql');
var connection = mysql.createConnection({
	host     : 'localhost',
	user     : 'root',
	password : '123456',
	database : 'blog'
});

connection.connect();
 
var getCategory = function(callback) {
	connection.query('select category.category_id,category.name,COUNT(post.post_id) as cname from category left join post on category.category_id = post.category_id group by name order by category_id asc', function(error, results, fields) {
		if (error) console.log(error);
		var resultArray = [];
		for (var i = 0; i < results.length; i++) {
			resultArray.push(results[i]);
		}
		callback(resultArray);
	});
}

var addCategory = function(category, callback) {
	var pars = [category];
	connection.query('insert into category (name) values (?)', pars, function(error, results) {
		if (error) console.log(error);
		callback(1);
	});
}

var deleteCategory = function(category, callback) {
	var pars = category;
	connection.query('delete from category where category_id = ?', pars, function(err, result) {
		if (err) console.log(err);
		connection.query('select * from post where category_id = ?', pars, function(err, rows, fields) {
			var tmp;
			if(rows.length != 0) {
				for (var i = 0; i < rows.length; i++) {
					tmp = rows[i].post_id;
					deletePost(tmp, i, rows.length, callback);
				}
			}else {
				callback(1);
			}
		})
	});
}

var checkCategory = function(category, callback) {
	var pars = [category];
	connection.query('select * from category where name = ?', pars, function(error, results) {
		if (error) console.log(error);
		if(results.length == 0) {
			callback(1);
		}else {
			callback(0);
		}
	});
}

var insertPost = function(array, callback) {
	var pars = array;
	var post_id;
	connection.query('insert into post (uri, title, keyWords, summary, image_url, content, date, category_id) values (?, ?, ?, ?, ?, ?, ?, ?)', pars, function(error, results) {
		if (error) return console.log(error);
		callback(1);
	});
	connection.query('select max(post_id) as "post_id" from post',  function(err, rows, result) {
		if (err) console.log(err);
		for (var i = 0; i < rows.length; i++) {
			post_id = rows[i].post_id;
		}
		connection.query('insert into total (post_id, views, comments) values (?, 0, 0)', post_id,  function(err, result) {
			if (err) console.log(err);
		});
	});
}

var deletePost = function(post_id, index, rows, callback) {
	console.log('step = '+2);
	var  pars = post_id;
	connection.query('delete from post where post_id = ?', pars, function(err, result) {
		if (err) console.log(err);
		connection.query('delete from total where post_id = ?', pars, function(err, result) {
			if (err) console.log(err);
			connection.query('update comment set disable = (2) where post_id = ?', pars, function(err, result) {
				if (err) console.log(err);
				if(index == rows - 1) {
					callback(1);
					console.log('step = ' + 3);
				}
			});
		});
	});
}

var getPost = function(uri, category_id, title, callback) {
	if(!category_id) {
		var category_id = "%";
	}
	if(!title) {
		var title = "%";
	}else{
		title = "%" + title + "%";
	}
	var pars = [uri, category_id, title];
	connection.query('select * from blog.category left join blog.post on category.category_id = post.category_id left join blog.total on post.post_id = total.post_id where uri like ? and post.category_id like ? and post.title like ? order by post.post_id asc', pars, function(error, rows, fields) {
		if (error) console.log(error);
		var results = [];
		for (var i = 0; i < rows.length; i++) {
			rows[i].date = rows[i].date.getFullYear() + "-" + ("0" + (rows[i].date.getMonth() + 1)).slice(-2) + "-" + ("0" + (rows[i].date.getDay() + 1)).slice(-2);
			results.push(rows[i]);
		}
		callback(results);
	});
}

var gettotal = function(uri, callback) {
	var pars = uri;
	var total;
	if(!category_id) {
		var category_id = "%";
	}
	connection.query('select * from blog.post left join blog.total on post.post_id = total.post_id where uri = ?', pars, function(err, rows, fields) {
		if (err) console.log(err);
		for (var i = 0; i < rows.length; i++) {
			total = rows[i].post_id;
		}
		connection.query('update total set views = (views + 1) where post_id = ?', total,  function(err, result) {
			if (err) console.log(err);
			callback(result);
		});
	});
}

var getComments = function(post_id, callback) {
	var pars = post_id;
	connection.query('select * from blog.post left join blog.comment on post.post_id = comment.post_id where comment.post_id like ? order by comment_id asc', pars, function(err, rows, fields) {
		if (err) console.log(err);
		var result = [];
		for (var i = 0; i < rows.length; i++) {
			rows[i].date = rows[i].date.getFullYear() + "-" + ("0" + (rows[i].date.getMonth() + 1)).slice(-2) + "-" + ("0" + (rows[i].date.getDay() + 1)).slice(-2);
			if(rows[i].disable == 0) {
				rows[i].content = "该评论已被管理员禁止！"
			}
			if(rows[i].url != "#") {
				rows[i].url = "//" + rows[i].url;
			}
			result.push(rows[i]);
		}
		callback(result);
	});
}

var addComments = function(data, callback) {
	var pars = data;
	connection.query('insert into comment (post_id, url, nickname, content, date, ip, disable) values (?, ?, ?, ?, ?, ?, ?)', pars, function(err, result) {
		if (err) console.log(err);
		var total = pars[0];
		connection.query('update total set comments = (comments + 1) where post_id = ?', total, function(err, result) {
			if (err) console.log(err);
			callback(1);
		});
	});
}

var VerifyComment = function(comment_id, callback) {
	var pars = comment_id;
	connection.query('update comment set disable = (0) where comment_id = ?', pars, function(err, result) {
		if (err) console.log(err);
		callback(1);
	})
}

var checkLogin = function(user, pwd, callback) {
	var pars = [user, pwd];
	connection.query('select * from user where name = ? and password = PASSWORD (?)', pars, function(err, rows, fields) {
		if(rows.length == 0) {
			return callback(0);
		}else {
			return callback(rows[0].name);
		}
	});
}

module.exports.getCategory = getCategory;
module.exports.addCategory = addCategory;
module.exports.checkCategory = checkCategory;
module.exports.insertPost = insertPost;
module.exports.getPost = getPost;
module.exports.gettotal = gettotal;
module.exports.addComments = addComments;
module.exports.getComments = getComments;
module.exports.deletePost = deletePost;
module.exports.VerifyComment = VerifyComment;
module.exports.checkLogin = checkLogin;
module.exports.deleteCategory = deleteCategory;

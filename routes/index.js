var express = require('express');
var controller = require('./controller');
var router = express.Router();

router.map = function(obj, route) {
	route = route || '';
	for (var key in obj) {
		if(obj.hasOwnProperty(key)) {
			switch(typeof(obj[key])) {
				case "object":
					router.map(obj[key], route + key);
					break;
				case "function":
					router[key](route, obj[key]);
					break;
			}
		}
	}
}

router.map({
	'/': {
		get: controller.homePage
	},
	'/post': {
		'/:uri([0-9a-zA-Z]{10})': {
			get: controller.postPage,
			post: controller.addComments
		}
	},
	'/login': {
		get: controller.loginPage,
		post: controller.checkLogin
	},
	'/admin': {
		'/': {
			get: controller.adminHomePage
		},
		'/category': {
			get: controller.adminCategoryPage,
			post: controller.adminAddCategory
		},
		'/delete-category': {
			post: controller.adminDeleteCategory
		},
		'/push-post': {
			get: controller.adminPushPostPage,
			post: controller.adminAddPost
		},
		'/upload-file': {
			'/:uri([0-9a-zA-Z]{10})': {
				post: controller.adminUploadFile
			}
		},
		'/edit-post': {
			get: controller.adminEditPostPage
		},
		'/delete-post': {
			post: controller.adminDeletePost
		},
		'/comment': {
			get: controller.adminCommentPage,
			post: controller.adminVerifyComment
		},
		'/logout': {
			get: controller.adminLogoutPage
		}
	}
})

module.exports = router;

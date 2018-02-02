/* 
* @Author: sublime text
* @Date:   2017-04-08 16:47:35
* @Last Modified by:   sublime text
* @Last Modified time: 2017-08-28 14:28:25
*/
create database if not exists blog;
use blog;

/*user table*/
drop table if exists user;
create table user(
	name char(10) not null default '',
	password char(41) not null default '',
	primary key(name)
)engine myisam default character set utf8;


/*post table*/
drop table if exists post;
create table post(
	post_id int(11) unsigned not null auto_increment,
	uri varchar(255) unique not null default '',
	title varchar(100) not null default '',
	keywords varchar(100) not null default '',
	summary varchar(255) not null default '',
	image_url varchar(255) not null default '',
	content text not null,
	date datetime not null default '0000-00-00 00:00:00',
	category_id tinyint(3) unsigned not null default 0,
	primary key (post_id)
)engine myisam default character set utf8;

/*comment table*/
drop table if exists comment;
create table comment(
	comment_id int(11) unsigned not null auto_increment,
	post_id int(11) unsigned not null default 0,
	url varchar(100) not null default '',
	nickname char(10) not null default '',
	content text not null,
	date datetime not null default '0000-00-00 00:00:00',
	ip varchar(100) not null default '',
	disable tinyint(1) unsigned not null default 1,
	primary key(comment_id),
	index(post_id)
)engine myisam default character set utf8;

/*total table*/
drop table if exists total;
create table total(
	post_id int(11) unsigned not null,
	views int(11) unsigned not null default 0,
	comments smallint(6) unsigned not null default 0,
	primary key(post_id)
)engine myisam default character set utf8;

/*category table*/
drop table if exists category;
create table category(
	category_id tinyint(3) unsigned not null auto_increment,
	name char(10) not null default '',
	primary key(category_id)
)engine myisam default character set utf8;
-- insert into category (name) values ("未分类");



insert into user (name, password) values ('admin', PASSWORD(123456));
INSERT INTO `category` (`category_id`, `name`) VALUES
	(1, '未分类'),
	(2, '系统'),
	(3, 'css'),
	(4, 'C#');
INSERT INTO `post` (`post_id`, `uri`, `title`, `keywords`, `summary`, `image_url`, `content`, `date`, `category_id`) VALUES
	(1, 'fAjbkOvRFr', '开始菜单运行输入的命令集锦 ', '运行,命令', '开始菜单运行输入的命令集锦 ', '/images/201506/fAjbkOvRFr/1434322103575.jpg', '&lt;p&gt;&lt;img src=&#34;../images/201506/fAjbkOvRFr/1434322103576.jpg&#34; alt=&#34;&#34; width=&#34;100%&#34; height=&#34;100%&#34; /&gt;&lt;/p&gt;&lt;p&gt;winver---------检查Windows版本 &lt;br /&gt;wmimgmt.msc----打开windows管理体系结构(WMI) &lt;br /&gt;wupdmgr--------windows更新程序 &lt;br /&gt;wscript--------windows脚本宿主设置 &lt;br /&gt;write----------写字板 &lt;br /&gt;&lt;br /&gt;&lt;br /&gt;mplayer2-------简易widnows media player &lt;br /&gt;mspaint--------画图板 &lt;br /&gt;mstsc----------远程桌面连接 &lt;br /&gt;mplayer2-------媒体播放机 &lt;br /&gt;magnify--------放大镜实用程序 &lt;br /&gt;mmc------------打开控制台 &lt;br /&gt;mobsync--------同步命令 &lt;br /&gt;dxdiag---------检查DirectX信息 &lt;br /&gt;drwtsn32------ 系统医生 &lt;br /&gt;devmgmt.msc--- 设备管理器 &lt;br /&gt;dfrg.msc-------磁盘碎片整理程序 &lt;br /&gt;diskmgmt.msc---磁盘管理实用程序 &lt;br /&gt;dcomcnfg-------打开系统组件服务 &lt;br /&gt;ddeshare-------打开DDE共享设置 &lt;br /&gt;dvdplay--------DVD播放器 &lt;br /&gt;net stop messenger-----停止信使服务 &lt;br /&gt;net start messenger----开始信使服务 &lt;br /&gt;notepad--------打开记事本 &lt;br /&gt;nslookup-------网络管理的工具向导 &lt;br /&gt;ntbackup-------系统备份和还原 &lt;br /&gt;narrator-------屏幕&amp;ldquo;讲述人&amp;rdquo; &lt;br /&gt;ntmsmgr.msc----移动存储管理器 &lt;br /&gt;ntmsoprq.msc---移动存储管理员操作请求 &lt;br /&gt;netstat -an----(TC)命令检查接口 &lt;br /&gt;syncapp--------创建一个公文包 &lt;br /&gt;sysedit--------系统配置编辑器 &lt;br /&gt;sigverif-------文件签名验证程序 &lt;br /&gt;sndrec32-------录音机 &lt;br /&gt;shrpubw--------创建共享文件夹 &lt;br /&gt;secpol.msc-----本地安全策略 &lt;br /&gt;syskey---------系统加密，一旦加密就不能解开，保护windows xp系统的双重密码 &lt;br /&gt;services.msc---本地服务设置 &lt;br /&gt;Sndvol32-------音量控制程序 &lt;br /&gt;sfc.exe--------系统文件检查器 &lt;br /&gt;sfc /scannow---windows文件保护 &lt;br /&gt;tsshutdn-------60秒倒计时关机命令 &lt;br /&gt;tourstart------xp简介（安装完成后出现的漫游xp程序） &lt;br /&gt;taskmgr--------任务管理器 &lt;br /&gt;eventvwr-------事件查看器 &lt;br /&gt;eudcedit-------造字程序 &lt;br /&gt;explorer-------打开资源管理器 &lt;br /&gt;packager-------对象包装程序 &lt;br /&gt;perfmon.msc----计算机性能监测程序 &lt;br /&gt;progman--------程序管理器 &lt;br /&gt;regedit.exe----注册表 &lt;br /&gt;rsop.msc-------组策略结果集 &lt;br /&gt;regedt32-------注册表编辑器 &lt;br /&gt;rononce -p ----15秒关机 &lt;br /&gt;regsvr32 /u *.dll----停止dll文件运行 &lt;br /&gt;regsvr32 /u zipfldr.dll------取消ZIP支持 &lt;br /&gt;cmd.exe--------CMD命令提示符 &lt;br /&gt;chkdsk.exe-----Chkdsk磁盘检查 &lt;br /&gt;certmgr.msc----证书管理实用程序 &lt;br /&gt;calc-----------启动计算器 &lt;br /&gt;charmap--------启动字符映射表 &lt;br /&gt;cliconfg-------SQL SERVER 客户端网络实用程序 &lt;br /&gt;Clipbrd--------剪贴板查看器 &lt;br /&gt;conf-----------启动netmeeting &lt;br /&gt;compmgmt.msc---计算机管理 &lt;br /&gt;cleanmgr-------垃圾整理 &lt;br /&gt;ciadv.msc------索引服务程序 &lt;br /&gt;osk------------打开屏幕键盘 &lt;br /&gt;odbcad32-------ODBC数据源管理器 &lt;br /&gt;oobe/msoobe /a----检查XP是否激活 &lt;br /&gt;lusrmgr.msc----本机用户和组 &lt;br /&gt;logoff---------注销命令 &lt;br /&gt;iexpress-------木马捆绑工具，系统自带 &lt;br /&gt;Nslookup-------IP地址侦测器 &lt;br /&gt;fsmgmt.msc-----共享文件夹管理器 &lt;br /&gt;utilman--------辅助工具管理器 &lt;br /&gt;gpedit.msc-----组策略&lt;/p&gt;', '2015-06-02 06:48:36', 2),
	(2, 'iLIsTwmHZc', 'CSS属性大全 ', 'CSS,CSS属性', 'CSS属性大全 ', '/images/201506/iLIsTwmHZc/1434322103575.jpg', '&lt;p&gt;&lt;img src=&#34;../images/201506/iLIsTwmHZc/1434322103576.jpg&#34; alt=&#34;&#34; width=&#34;100%&#34; height=&#34;100%&#34; /&gt;&lt;/p&gt;&lt;h3&gt;一 CSS文字属性：&lt;/h3&gt;
&lt;p&gt;color : #999999; /*文字颜色*/&lt;br /&gt;font-family : 宋体,sans-serif; /*文字字体*/ &lt;br /&gt;font-size : 9pt; /*文字大小*/ &lt;br /&gt;font-style:itelic; /*文字斜体*/ &lt;br /&gt;font-variant:small-caps; /*小字体*/ &lt;br /&gt;letter-spacing : 1pt; /*字间距离*/ &lt;br /&gt;line-height : 200%; /*设置行高*/ &lt;br /&gt;font-weight:bold; /*文字粗体*/ &lt;br /&gt;vertical-align:sub; /*下标字*/ &lt;br /&gt;vertical-align:super; /*上标字*/ &lt;br /&gt;text-decoration:line-through; /*加删除线*/ &lt;br /&gt;text-decoration: overline; /*加顶线*/ &lt;br /&gt;text-decoration:underline; /*加下划线*/ &lt;br /&gt;text-decoration:none; /*删除链接下划线*/ &lt;br /&gt;text-transform : capitalize; /*首字大写*/ &lt;br /&gt;text-transform : uppercase; /*英文大写*/ &lt;br /&gt;text-transform : lowercase; /*英文小写*/ &lt;br /&gt;text-align:right; /*文字右对齐*/ &lt;br /&gt;text-align:left; /*文字左对齐*/ &lt;br /&gt;text-align:center; /*文字居中对齐*/ &lt;br /&gt;text-align:justify; /*文字分散对齐*/ &lt;br /&gt;vertical-align属性&lt;br /&gt;vertical-align:top; /*垂直向上对齐*/ &lt;br /&gt;vertical-align:bottom; /*垂直向下对齐*/ &lt;br /&gt;vertical-align:middle; /*垂直居中对齐*/ &lt;br /&gt;vertical-align:text-top; /*文字垂直向上对齐*/ &lt;br /&gt;vertical-align:text-bottom; /*文字垂直向下对齐*/&lt;/p&gt;
&lt;h3&gt;二、CSS边框空白&lt;/h3&gt;
&lt;p&gt;padding-top:10px; /*上内边距*/ &lt;br /&gt;padding-right:10px; /*右内边距*/ &lt;br /&gt;padding-bottom:10px; /*下内边距*/ &lt;br /&gt;padding-left:10px; /*左边边距&lt;/p&gt;
&lt;h3&gt;三、CSS符号属性：&lt;/h3&gt;
&lt;p&gt;list-style-type:none; /*不编号*/ &lt;br /&gt;list-style-type:decimal; /*阿拉伯数字*/ &lt;br /&gt;list-style-type:lower-roman; /*小写罗马数字*/ &lt;br /&gt;list-style-type:upper-roman; /*大写罗马数字*/ &lt;br /&gt;list-style-type:lower-alpha; /*小写英文字母*/ &lt;br /&gt;list-style-type:upper-alpha; /*大写英文字母*/ &lt;br /&gt;list-style-type:disc; /*实心圆形符号*/ &lt;br /&gt;list-style-type:circle; /*空心圆形符号*/ &lt;br /&gt;list-style-type:square; /*实心方形符号*/ &lt;br /&gt;list-style-image:url(/dot.gif); /*图片式符号*/ &lt;br /&gt;list-style-position: outside; /*凸排*/ &lt;br /&gt;list-style-position:inside; /*缩进*/&lt;/p&gt;
&lt;h3&gt;四、CSS背景样式：&lt;/h3&gt;
&lt;p&gt;background-color:#F5E2EC; /*背景颜色*/ &lt;br /&gt;background:transparent; /*透视背景*/ &lt;br /&gt;background-image : url(/image/bg.gif); /*背景图片*/ &lt;br /&gt;background-attachment : fixed; /*浮水印固定背景*/ &lt;br /&gt;background-repeat : repeat; /*重复排列-网页默认*/ &lt;br /&gt;background-repeat : no-repeat; /*不重复排列*/ &lt;br /&gt;background-repeat : repeat-x; /*在x轴重复排列*/ &lt;br /&gt;background-repeat : repeat-y; /*在y轴重复排列*/ &lt;br /&gt;指定背景位置&lt;br /&gt;background-position : 90% 90%; /*背景图片x与y轴的位置*/ &lt;br /&gt;background-position : top; /*向上对齐*/ &lt;br /&gt;background-position : buttom; /*向下对齐*/ &lt;br /&gt;background-position : left; /*向左对齐*/ &lt;br /&gt;background-position : right; /*向右对齐*/ &lt;br /&gt;background-position : center; /*居中对齐*/&lt;/p&gt;
&lt;h3&gt;&lt;br /&gt;五、CSS连接属性：&lt;/h3&gt;
&lt;p&gt;&lt;br /&gt;a /*所有超链接*/ &lt;br /&gt;a:link /*超链接文字格式*/ &lt;br /&gt;a:visited /*浏览过的链接文字格式*/ &lt;br /&gt;a:active /*按下链接的格式*/ &lt;br /&gt;a:hover /*鼠标转到链接*/ &lt;br /&gt;鼠标光标样式：&lt;br /&gt;链接手指 CURSOR: hand &lt;br /&gt;十字体 cursor:crosshair &lt;br /&gt;箭头朝下 cursor:s-resize &lt;br /&gt;十字箭头 cursor:move &lt;br /&gt;箭头朝右 cursor:move &lt;br /&gt;加一问号 cursor:help &lt;br /&gt;箭头朝左 cursor:w-resize &lt;br /&gt;箭头朝上 cursor:n-resize &lt;br /&gt;箭头朝右上 cursor:ne-resize &lt;br /&gt;箭头朝左上 cursor:nw-resize &lt;br /&gt;文字I型 cursor:text &lt;br /&gt;箭头斜右下 cursor:se-resize &lt;br /&gt;箭头斜左下 cursor:sw-resize &lt;br /&gt;漏斗 cursor:wait &lt;br /&gt;光标图案(IE6)&amp;nbsp;&amp;nbsp; p {cursor:url(&#34;光标文件名.cur&#34;),text;}&lt;/p&gt;
&lt;h3&gt;六、CSS框线一览表：&lt;/h3&gt;
&lt;p&gt;border-top : 1px solid #6699cc; /*上框线*/ &lt;br /&gt;border-bottom : 1px solid #6699cc; /*下框线*/ &lt;br /&gt;border-left : 1px solid #6699cc; /*左框线*/ &lt;br /&gt;border-right : 1px solid #6699cc; /*右框线*/ &lt;br /&gt;以上是建议书写方式,但也可以使用常规的方式 如下:&lt;br /&gt;border-top-color : #369 /*设置上框线top颜色*/ &lt;br /&gt;border-top-width :1px /*设置上框线top宽度*/ &lt;br /&gt;border-top-style : solid/*设置上框线top样式*/&lt;/p&gt;
&lt;h3&gt;七、其他框线样式&lt;/h3&gt;
&lt;p&gt;solid /*实线框*/ &lt;br /&gt;dotted /*虚线框*/ &lt;br /&gt;double /*双线框*/ &lt;br /&gt;groove /*立体内凸框*/ &lt;br /&gt;ridge /*立体浮雕框*/ &lt;br /&gt;inset /*凹框*/ &lt;br /&gt;outset /*凸框*/&lt;/p&gt;
&lt;h3&gt;八、CSS边界样式：&lt;/h3&gt;
&lt;p&gt;margin-top:10px; /*上外边距*/ &lt;br /&gt;margin-right:10px; /*右外边距*/ &lt;br /&gt;margin-bottom:10px; /*下外边距*/ &lt;br /&gt;margin-left:10px; /*左外边距*/&lt;/p&gt;
&lt;h3&gt;CSS 属性： 字体样式(Font Style)&lt;/h3&gt;
&lt;p&gt;1 字体样式&lt;br /&gt;&amp;nbsp;{font:font-style font-variant font-weight font-size font-family} &lt;br /&gt;2 字体类型 &lt;br /&gt;{font-family:&#34;字体1&#34;,&#34;字体2&#34;,&#34;字体3&#34;,...} &lt;br /&gt;3 字体大小 &lt;br /&gt;{font-size:数值|inherit| medium| large| larger| x-large| xx-large| small| smaller| x-small| xx-small} &lt;br /&gt;4 字体风格 &lt;br /&gt;{font-style:inherit|italic|normal|oblique} &lt;br /&gt;5 字体粗细&amp;nbsp; &lt;br /&gt;&amp;nbsp;{font-weight:100-900|bold|bolder|lighter|normal;} &lt;br /&gt;6 字体颜色&amp;nbsp;&amp;nbsp; &lt;br /&gt;{color:数值;} &lt;br /&gt;7 阴影颜色 {&lt;br /&gt;text-shadow:16位色值} &lt;br /&gt;8 字体行高&amp;nbsp;&amp;nbsp; &lt;br /&gt;{line-height:数值|inherit|normal;} &lt;br /&gt;9 字 间 距&amp;nbsp;&amp;nbsp; &lt;br /&gt;{letter-spacing:数值|inherit|normal} &lt;br /&gt;10 单词间距 &lt;br /&gt;{word-spacing:数值|inherit|normal} &lt;br /&gt;11 字体变形 &lt;br /&gt;{font-variant:inherit|normal|small-cps } &lt;br /&gt;12 英文转换&lt;br /&gt;{text-transform:inherit|none|capitalize|uppercase|lowercase} &lt;br /&gt;13 字体变形 &lt;br /&gt;{font-size-adjust:inherit|none} &lt;br /&gt;14字体&lt;br /&gt;{font-stretch:condensed|expanded|extra-condensed|extra-expanded|inherit|narrower|normal| semi-condensed|semi-expanded|ultra-condensed|ultra-expanded|wider} &lt;br /&gt;文本样式(Text Style) &lt;br /&gt;序号 中文说明 标记语法 &lt;br /&gt;1 行 间 距 &lt;br /&gt;{line-height:数值|inherit|normal;} &lt;br /&gt;2 文本修饰&lt;br /&gt;{text-decoration:inherit|none|underline|overline|line-through|blink} &lt;br /&gt;3 段首空格 &lt;br /&gt;{text-indent:数值|inherit} &lt;br /&gt;4 水平对齐 &lt;br /&gt;{text-align:left|right|center|justify} &lt;br /&gt;5 垂直对齐&lt;br /&gt;{vertical-align:inherit|top|bottom|text-top|text-bottom|baseline|middle|sub|super} &lt;br /&gt;6 书写方式 &lt;br /&gt;{writing-mode:lr-tb|tb-rl} &lt;br /&gt;背景样式 &lt;br /&gt;序号 中文说明 标记语法 &lt;br /&gt;1 背景颜色 &lt;br /&gt;{background-color:数值} &lt;br /&gt;2 背景图片 &lt;br /&gt;{background-image: url(URL)|none} &lt;br /&gt;3 背景重复&lt;br /&gt;{background-repeat:inherit|no-repeat|repeat|repeat-x|repeat-y} &lt;br /&gt;4 背景固定 &lt;br /&gt;{background-attachment:fixed|scroll} &lt;br /&gt;5 背景定位 &lt;br /&gt;{background-position:数值|top|bottom|left|right|center} &lt;br /&gt;6 背影样式 &lt;br /&gt;{background:背景颜色|背景图象|背景重复|背景附件|背景位置} &lt;br /&gt;框架样式(Box Style) &lt;br /&gt;序号 中文说明 标记语法 &lt;br /&gt;1 边界留白&lt;br /&gt;&amp;nbsp;{margin:margin-top margin-right margin-bottom margin-left} &lt;br /&gt;2 补　　白 &lt;br /&gt;{padding:padding-top padding-right padding-bottom padding-left} &lt;br /&gt;3 边框宽度 &lt;br /&gt;{border-width:border-top-width border-right-width border-bottom-width border-left-width}　　&lt;br /&gt;宽度值： thin|medium|thick|数值 &lt;br /&gt;4 边框颜色 &lt;br /&gt;{border-color:数值 数值 数值 数值}　　数值：分别代表top、right、bottom、left颜色值 &lt;br /&gt;5 边框风格&lt;br /&gt;{border-style:none|hidden|inherit|dashed|solid|double|inset|outset|ridge|groove} &lt;br /&gt;6 边　　框&lt;br /&gt;&amp;nbsp;{border:border-width border-style color} &lt;br /&gt;&amp;nbsp; 上 边 框 &lt;br /&gt;{border-top:border-top-width border-style color} &lt;br /&gt;&amp;nbsp;右 边 框 &lt;br /&gt;{border-right:border-right-width border-style color} &lt;br /&gt;&amp;nbsp;下 边 框 &lt;br /&gt;{border-bottom:border-bottom-width border-style color} &lt;br /&gt;&amp;nbsp;左 边 框 &lt;br /&gt;{border-left:border-left-width border-style color} &lt;br /&gt;7 宽　　度 &lt;br /&gt;{width:长度|百分比| auto} &lt;br /&gt;8 高　　度&lt;br /&gt;&amp;nbsp;{height:数值|auto} &lt;br /&gt;9 漂　　浮 &lt;br /&gt;{float:left|right|none} &lt;br /&gt;10 清　　除 &lt;br /&gt;{clear:none|left|right|both} &lt;br /&gt;分类列表 &lt;br /&gt;序号 中文说明 标记语法 &lt;br /&gt;1 控制显示 {display:none|block|inline|list-item} &lt;br /&gt;2 控制空白 {white-space:normal|pre|nowarp} &lt;br /&gt;3 符号列表&lt;br /&gt;{list-style-type:disc|circle|square|decimal|lower-roman|upper-roman|lower-alpha|upper-alpha|none} &lt;br /&gt;4 图形列表 &lt;br /&gt;{list-style-image:URL} &lt;br /&gt;5 位置列表 &lt;br /&gt;{list-style-position:inside|outside} &lt;br /&gt;6 目录列表 &lt;br /&gt;{list-style:目录样式类型|目录样式位置|url} &lt;br /&gt;7鼠标形状&lt;br /&gt;{cursor:hand|crosshair|text|wait|move|help|e-resize|nw-resize|w-resize|s-resize|se-resize|sw-resize}&lt;/p&gt;', '2015-06-15 06:48:36', 3),
(3, 'qruQnSicCh', 'C#介绍 ', 'C#', 'C#是微软公司发布的一种面向对象的、运行于.NET Framework之上的高级程序设计语言。 ', '/images/201506/qruQnSicCh/1434322103575.jpg', '&lt;p&gt;&lt;img src=&#34;../images/201506/iLIsTwmHZc/1434322103576.jpg&#34; alt=&#34;&#34; width=&#34;100%&#34; height=&#34;100%&#34; /&gt;&lt;/p&gt;&lt;p&gt;C#是微软公司发布的一种面向对象的、运行于.NET Framework之 上的高级程序设计语言。并定于在微软职业开发者论坛(PDC)上登台亮相。C#是微软公司研究员Anders Hejlsberg的最新成果。C#看起来与Java有着惊人的相似；它包括了诸如单一继承、接口、与Java几乎同样的语法和编译成中间代码再运行的过 程。但是C#与Java有着明显的不同，它借鉴了Delphi的一个特点，与COM（组件对象模型）是直接集成的，而且它是微软公司 .NET windows网络框架的主角。&lt;br /&gt;&lt;br /&gt;C#是一种安全的、稳定的、简单的、优雅的，由C和C++衍生出来的面向对象的编程语言。它在继承C和C++强大功能的同时去掉了一些它们的复杂特性（例如没有宏以及不允许多重继承）。C#综合了VB简单的可视化操作和C++的高运行效率，以其强大的操作能力、优雅的语法风格、创新的语言特性和便捷的面向组件编程的支持成为.NET开发的首选语言。[1] &lt;br /&gt;C#是面向对象的编程语言。它使得程序员可以快速地编写各种基于MICROSOFT .NET平台的应用程序，MICROSOFT .NET提供了一系列的工具和服务来最大程度地开发利用计算与通讯领域。&lt;br /&gt;&amp;nbsp;&lt;br /&gt;C#使得C++程序员可以高效的开发程序，且因可调用由 C/C++ 编写的本机原生函数，因此绝不损失C/C++原有的强大的功能。因为这种继承关系，C#与C/C++具有极大的相似性，熟悉类似语言的开发者可以很快的转向C#。&lt;/p&gt;', '2015-06-25 16:26:31', 4),
(4, 'AThtfGEXbV', '色彩搭配原理与技巧 ', '色彩,色彩搭配', '色彩搭配原理与技巧', '/images/201506/AThtfGEXbV/1435222240847.jpg', '&lt;p&gt;&lt;img src=&#34;../images/201506/AThtfGEXbV/1435222240848.jpg&#34; alt=&#34;&#34; width=&#34;100%&#34; height=&#34;100%&#34; /&gt;&lt;/p&gt;&lt;p&gt;我们所说的色彩搭配一般为绘画中的色彩，三原色为红黄蓝。随着进入21世纪，科技的发展，色彩不再仅仅局限绘画上，所以下面所说的色彩搭配以光的三原色为基础制作的色相环。&lt;br /&gt;原色 色盘上延伸最长的几段表示出了三种原色----红黄蓝。它们之所以称为原色。是因为其他的颜色都可以通过这三种颜色的组合而成。&lt;br /&gt;色彩搭配原理与技巧 祺馨色彩色彩搭配原理与技巧 祺馨色彩&lt;br /&gt;第二色（间色） 将任何俩种原色混合起来，你就可以得到间&lt;br /&gt;色：橙（红加黄）紫（红加蓝）绿（蓝加黄）&lt;br /&gt;第三色（混合色）色盘上另外6种颜色称为混合色。它们是原色和一种临近的间接色混合而成的：桔黄（黄加橙） 青（黄加绿）深绿（绿加蓝）绛（红加橙）。&lt;br /&gt;颜色三要素：色相，以区别各种颜色，如红绿蓝等；纯度，以示色彩深浅；明度，以示彩色明暗。&lt;br /&gt;1、色相配色&lt;br /&gt;以色相为基础的配色是以色相环为基础进行思考的，用色相环上类似的颜色进行配色，可以得到稳定而统一的感觉。用距离远的颜色进行配色，可以达到一定的对比效果。&lt;br /&gt;类似色相的配色，能表现共同的配色印象。这种配色在色相上既有共性又有变化，是很容易取得配色平衡的手法。例如：黄色、橙黄色、橙色的组合；群青色、青紫色、紫罗兰色的组合都是类似色相配色。与同一色相的配色一样，类似色相的配色容易产生单调的感觉，所以可使用对比色调的配色手法。 　中差配色的对比效果既明快又不冲突，是深受人们喜爱的配色。&lt;br /&gt;对比色相配色，是指在色相环中，位于色相环圆心直径两端的色彩或较远位置的色彩组合。它包含了中差色相配色、对照色相配色、补色色相配色。对比色相的色彩性质比较青，所以经常在色调上或面积上用以取得色彩的平衡。&lt;br /&gt;色相配色在16色相环中，角度为0&amp;deg;或接近的配色，称为同一色相配色。&lt;br /&gt;角度为22.5&amp;deg;的两色间，色相差为1的配色，称为邻近色相配色。&lt;br /&gt;角度为45&amp;deg;的两色间，色相差为2的配色，称为类似色相配色。&lt;br /&gt;角度为67.5&amp;deg;~112.5&amp;deg;，色相差为6~7的配色，称为对照色相配色。&lt;br /&gt;角度为180&amp;deg;左右，色相差为8的配色，称为补色色相配色。&lt;br /&gt;2、色调配色&lt;br /&gt;a.同一色调配色&lt;br /&gt;同一色调配色是将相同色调的不同颜色搭配在一起形成的一种配色关系。同一色调的颜色、色彩的纯度和明度具有共同性、明度按照色相略有所变化。不同色调会产生不同的色彩印象，将纯色调全部放在一起，或产生活泼感；而婴儿服饰和玩具都以淡色调为主。在对比色相和中差色相配色中，一般采用同一色调的配色手法，更容易进行色彩调和。&lt;br /&gt;b、类似色调配色&lt;br /&gt;类似色调配色即将色调图中相邻或接近的两个或两个以上色调搭配在一起的配色。类似色调配色的特征在于色调与色调之间有微妙的差异，较同一色调有变化，不会产生呆滞感。将深色调和暗色调搭配在一起，能产生一种既深又暗的昏暗之感，鲜艳色调和强烈色调再加明亮色调，便能产生鲜艳活泼的色彩印象。&lt;br /&gt;c、对照色配色&lt;br /&gt;对照色调配色是相隔较远的两个或两个以上的色调搭配在一起的配色。对比色调因色彩的特征差异，能造成鲜明的视觉对比，有一种&amp;ldquo;相映&amp;rdquo;或&amp;ldquo;相拒&amp;rdquo;的力量使之平衡，因而能产生对比调和感。对比色调配色在配色选择时，会因横向或纵向而有明度和纯度上的差异。例如：浅色调与深色调配色，即为深与浅的明暗对比；而鲜艳色调与灰浊色调搭配，会形成纯度上的差异配色。&lt;br /&gt;采用同一色调的配色手法，更容易进行色彩调和。&lt;br /&gt;3.明度配色&lt;/p&gt;', '2015-06-25 16:36:31', 3),
(5, 'EG412DYbLD', '购买电脑时应注意七点事项 ', '购买电脑', '购买电脑时应注意七点事项', '/images/201506/EG412DYbLD/1435223238296.jpg', '&lt;p&gt;&lt;img src=&#34;../images/201506/EG412DYbLD/1435223238295.jpg&#34; alt=&#34;&#34; width=&#34;100%&#34; height=&#34;100%&#34; /&gt;&lt;p&gt;1、检查电脑包装箱是否为原包装，箱体是否完整无破损，其封口胶带是否为第一次拆封。&lt;/p&gt;
&lt;p&gt;&lt;br /&gt;2、电脑包装箱上是否有生产许可证号，是否有生产厂家名称、地址及电话号码。因为微型计算机、显示器、打印机产品是国家实行生产许可证管理的产品。在国内生产微型计算机、显示器及打印机必须申请生产许可证。&lt;/p&gt;
&lt;p&gt;&lt;br /&gt;3、开箱检查箱内是否有产品合格证、中文说明书、使用手册、保修卡及产品配置清单等。&lt;/p&gt;
&lt;p&gt;&lt;br /&gt;4、检查随机提供的原驱动程序（比如：光驱驱动程序、显示卡驱动程序、主板驱动程序等）以及操作系统和应用软件光盘或软盘是否齐全，是否和配置单上的相符合。&lt;/p&gt;
&lt;p&gt;&lt;br /&gt;5、取出电脑，检查其外表面是否有油渍、污垢或起泡、划痕、破损等。&lt;/p&gt;
&lt;p&gt;&amp;nbsp;&lt;/p&gt;
&lt;p&gt;6、在销售商处加电检查购买的电脑系统是否正常工作，刚开机时电脑画面显示的CPU、内存、显示卡及硬盘等的配置是否和配置单上的内容相符合。&lt;/p&gt;
&lt;p&gt;&lt;br /&gt;7、要求销售商开具发票加盖印章，询问保修期限和保修期后的收费标准并索要相关证据。如果你对购买电脑没有把握，最好购买维修技术实力强，售后服务好的名牌产品。&lt;/p&gt;', '2015-06-25 17:07:21', 2),
(6, '0ICpOdQdLM', 'vs2008升级成为正式版 ', 'vs2008', '现在大多数下载的vs.net2008是90天试用版的，90天试用版的只是一个cd-key的问题，只要将这个改为正式的就ok了 ', '/images/201506/0ICpOdQdLM/1435224110127.jpg', '&lt;p&gt;&lt;img src=&#34;../images/201506/0ICpOdQdLM/1435224110128.jpg&#34; alt=&#34;&#34; width=&#34;100%&#34; height=&#34;100%&#34; /&gt;&lt;p&gt;现在大多数下载的vs.net2008是90天试用版的，90天试用版的只是一个cd-key的问题，只要将这个改为正式的就ok了 &lt;br /&gt;在网上搜索很多的方法，下面共享给大家： &lt;br /&gt;&lt;br /&gt;&lt;br /&gt;1.把Setup/setup.sdb文件中的[Product Key]，由&amp;ldquo;T2CRQGDKBVW7KJR8C6CKXMW3D&amp;rdquo;修改为&amp;ldquo;***&amp;rdquo;&lt;br /&gt;&lt;br /&gt;&lt;br /&gt;2.在卸载试用版的地方，输入上面的key，然后更新，就可以成为正式版&lt;br /&gt;&amp;nbsp; 操作步骤：控制面版&amp;gt;添加或删除程序&amp;gt;卸载vs.net2008＞出现卸载界面＞点击Next＞输入下面CD-key -&amp;gt;点击升级-&amp;gt;出现成功画面即可完美将试用版升级成为正式版。&lt;br /&gt;&amp;nbsp; CDKEY：PYHYP-WXB3B-B2CCM-V9DX9-VDY8T&lt;/p&gt;', '2015-06-25 17:07:21', 4);
	INSERT INTO `total` (`post_id`, `views`, `comments`) VALUES
	(1, 2, 2),
	(2, 3, 3),
	(3, 2, 2),
	(4, 1, 1),
	(5, 0, 0),
	(6, 0, 0);
	INSERT INTO `comment` (`comment_id`, `post_id`, `url`, `nickname`, `content`, `date`, `ip`, `disable`) VALUES
	(1, 1, "www.baidu.com", "小男孩", "不错不错，支持一下！", "2015-06-5 14:05:35", "127.0.0.1", 1),
	(2, 1, "www.baidu.com", "老男孩", "正好需要。", "2015-06-8 14:05:35", "127.0.0.1", 1),
	(3, 2, "www.baidu.com", "小男孩", "挺全的。", "2015-06-11 14:05:35", "127.0.0.1", 1),
	(4, 2, "www.baidu.com", "阿斯达", "这是什么代码，看不懂。", "2015-06-12 14:05:35", "127.0.0.1", 1),
	(5, 2, "www.baidu.com", "大米", "回2楼，网页css样式。", "2015-06-15 14:05:35", "127.0.0.1", 1),
	(6, 3, "www.baidu.com", "阿斯顿", "C#,什么东西？", "2015-06-25 07:05:35", "127.0.0.1", 1),
	(7, 3, "www.baidu.com", "手指", "额，不知道", "2015-06-25 14:05:35", "127.0.0.1", 1),
	(8, 4, "www.baidu.com", "喜欢你哦", "抢沙发！", "2015-06-25 15:05:35", "127.0.0.1", 1),
	(9, 5, "www.baidu.com", "喜欢你哦", "抢沙发！", "2015-06-25 15:05:35", "127.0.0.1", 1),
	(10, 6, "www.baidu.com", "喜欢你哦", "抢沙发！", "2015-06-25 15:05:35", "127.0.0.1", 1);
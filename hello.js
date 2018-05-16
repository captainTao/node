'use strict';

s = "1214141";
s.endsWith('4');
false

/^[0-9]{3,10}/.test(s); // 正则匹配
true

/[^\s]{3,10}/.test(s);
true
// 面向对象编程


//类名的第一个字母要大写，以便区分普通函数：

/************************************************/
// 1.通过现成对象创建：
// obj.__proto__在低版本中的IE不支持
var robot = {
    name: 'Robot',
    height: 1.6,
    run: function () {
        console.log(this.name + ' is running...');
    }
};

var Student = {
    name: 'Robot',
    height: 1.2,
    run: function () {
        console.log(this.name + ' is running...');
    }
};

var xiaoming = {
    name: '小明'
};

xiaoming.__proto__ = Student; // 小明从student中继承下来
// obj.__proto__在低版本中的IE不支持

xiaoming.name; // '小明'
xiaoming.run(); // 小明 is running...


/************************************************/

// 2.Object.create()
// 方法可以传入一个原型对象，并创建一个基于该原型的新对象，但是新对象什么属性都没有
// 原型对象:
var Student = {
    name: 'Robot',
    height: 1.2,
    run: function () {
        console.log(this.name + ' is running...');
    }
};

function createStudent(name) {
    // 基于Student原型创建一个新对象:
    var s = Object.create(Student);
    // 初始化新对象:
    s.name = name;
    return s;
}

var xiaoming = createStudent('小明');
xiaoming.run(); // 小明 is running...
xiaoming.__proto__ === Student; // true

/************************************************/

// 3.构造函数：new, 不需要return this

function Student(name) {
    this.name = name;
    this.hello = function () {
        alert('Hello, ' + this.name + '!');
    }
}

var xiaoming = new Student('小明');
xiaoming.name; // '小明'
xiaoming.hello(); // Hello, 小明!

// 用new Student()创建的对象还从原型上获得了一个constructor属性，它指向函数Student本身：跟oc中的isa指针是一样的

/*
xiaoming.constructor === Student.prototype.constructor; // true
Student.prototype.constructor === Student; // true

Object.getPrototypeOf(xiaoming) === Student.prototype; // true
xiaoming instanceof Student; // true
*/


// 对象上共同的东西，就写在原型上就可以了，能节省内存空间
function Student(name) {
    this.name = name;
}

Student.prototype.hello = function () {
    alert('Hello, ' + this.name + '!');
};

// 按照约定，构造函数首字母应当大写，而普通函数首字母应当小写，这样，一些语法检查工具如jslint将可以帮你检测到漏写的new。


// 一般常用的编程模式像这样：
function Student(props) {
    this.name = props.name || '匿名'; // 默认值为'匿名'
    this.grade = props.grade || 1; // 默认值为1
}

Student.prototype.hello = function () {
    alert('Hello, ' + this.name + '!');
};

function createStudent(props) {
    return new Student(props || {})
}

/************************************************/


// class 继承：ES6才支持

/*class不能普及用，现在用还早了点，因为不是所有的主流浏览器都支持ES6的class。如果一定要现在就用上，就需要一个工具把class代码转换为传统的prototype代码，可以试试Babel这个工具。*/
class Student {
    constructor(name) {
        this.name = name;
    }

    hello() {
        alert('Hello, ' + this.name + '!');
    }
}

var xiaoming = new Student('小明');
xiaoming.hello();


class PrimaryStudent extends Student {  //继承用extend
    constructor(name, grade) {
        super(name); // 记得用super调用父类的构造方法!
        this.grade = grade;
    }

    myGrade() {
        alert('I am at grade ' + this.grade);
    }
}


////////////////////////////////////////////////////////////
浏览器对象：
/************************************************/
// 获取浏览器窗口的大小：（除去工具栏，菜单栏，状态栏）
'use strict';
// 可以调整浏览器窗口大小试试:
console.log('window inner size: ' + window.innerWidth + ' x ' + window.innerHeight);

window对象有innerWidth和innerHeight属性，可以获取浏览器窗口的内部宽度和高度。
还有一个outerWidth和outerHeight属性，可以获取浏览器窗口的整个宽高。



navigator对象表示浏览器的信息，最常用的属性包括：

navigator.appName：浏览器名称；  // chrome为：appName = Netscape
navigator.appVersion：浏览器版本；
navigator.language：浏览器设置的语言；
navigator.platform：操作系统类型；
navigator.userAgent：浏览器设定的User-Agent字符串。

// navigator的信息可以很容易地被用户修改
// 针对不同的浏览器正确的方法是充分利用JavaScript对不存在属性返回undefined的特性，直接用短路运算符||计算：
var width = window.innerWidth || document.body.clientWidth;


screen
screen对象表示屏幕的信息，常用的属性有：

screen.width：屏幕宽度，以像素为单位；
screen.height：屏幕高度，以像素为单位；
screen.colorDepth：返回颜色位数，如8、16、24。


location
location对象表示当前页面的URL信息。例如，一个完整的URL：

//------http://www.example.com:8080/path/index.html?a=1&b=2#TOP

可以用location.href获取。


要获得URL各个部分的值，可以这么写：
location.protocol; // 'http'
location.host; // 'www.example.com'
location.port; // '8080'
location.pathname; // '/path/index.html'
location.search; // '?a=1&b=2'
location.hash; // 'TOP'
要加载一个新页面，可以调用location.assign()。如果要重新加载当前页面，调用location.reload()方法非常方便。

'use strict'
if (confirm('重新加载当前页' + location.href + '?')) {
    location.reload();
} else {
    location.assign('/'); // 设置一个新的URL地址
}



document
document对象表示当前页面。
document的title属性是从HTML文档中的<title>xxx</title>读取的，但是可以动态改变
document.title = '努力学习JavaScript!';  // 这是title
document.getElementByID, ByTagName
document.cookie; //读取当前页面的cookie
为了确保安全，服务器端在设置Cookie时，应该始终坚持使用httpOnly



history
back()
forward()
新手开始设计Web页面时喜欢在登录页登录成功时调用history.back()，试图回到登录前的页面。这是一种错误的方法。
任何情况，你都不应该使用history这个对象了。


////////////////////////////////////////////////////////////
DOM方法操作：
/************************************************/

选择方法一：
document.getElementById()
document.getElementsByTagName()
document.getElementsByClassName()

document.getElementById()可以直接定位唯一的一个DOM节点。
document.getElementsByTagName()和document.getElementsByClassName()总是返回一组DOM节点。



// 先定位ID为'test-div'的节点，再返回其内部所有class包含red的节点：
var reds = document.getElementById('test-div').getElementsByClassName('red');

// 获取节点test下的所有直属子节点:
var cs = test.children;

// 获取节点test下第一个、最后一个子节点：
var first = test.firstElementChild;
var last = test.lastElementChild;


选择方法二：
使用querySelector()和querySelectorAll()
注意：低版本的IE<8不支持querySelector和querySelectorAll。IE8仅有限支持：

// 通过querySelector获取ID为q1的节点：
var q1 = document.querySelector('#q1');
// 通过querySelectorAll获取q1节点内的符合条件的所有节点：
var ps = q1.querySelectorAll('div.highlighted > p')


/*
严格地讲，我们这里的DOM节点是指Element，但是DOM节点实际上是Node，
在HTML中，Node包括Element、Comment、CDATA_SECTION等很多种，以及根节点Document类型，
但是，绝大多数时候我们只关心Element，也就是实际控制页面结构的Node，其他类型的Node忽略即可。
根节点Document已经自动绑定为全局变量document。
*/

///***********************************更新：
1.innerHTML
用innerHTML时要注意，是否需要写入HTML。如果写入的字符串是通过网络拿到了，要注意对字符编码来避免XSS攻击；

2.innerText或textContent
两者的区别在于读取属性时，innerText不返回隐藏元素的文本，而textContent返回所有文本。另外注意IE<9不支持textContent
innerText 打印标签之间的纯文本信息，会将标签过滤掉，低版本的火狐浏览器不支持，而是支持textContent

function getText(element) {  
    if(element.innerText) {  
        return element.innerText;   //IE8及之前的浏览器支持，现在两者都支持  
    }else {  
        return element.textContent; //低版本的火狐支持  
    }  
}  


3.修改css：
// 获取<p id="p-id">...</p>
var p = document.getElementById('p-id');
// 设置CSS:
p.style.color = '#ff0000';
p.style.fontSize = '20px';  //js不能识别font-size,这儿用驼峰命名法
p.style.paddingTop = '2em';


///***********************************插入：
1.appendChild
// 相当于移动了
<!-- HTML结构 -->
<p id="js">JavaScript</p>
<div id="list">
    <p id="java">Java</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
</div>

/// 命令：
var
    js = document.getElementById('js'),
    list = document.getElementById('list');
list.appendChild(js);


<!-- HTML结构 -->
<div id="list">
    <p id="java">Java</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
    <p id="js">JavaScript</p>
</div>




2. createElement + appendChild:

// 0创建：
var
    list = document.getElementById('list'),
    haskell = document.createElement('p');
haskell.id = 'haskell';
haskell.innerText = 'Haskell';
list.appendChild(haskell);

<!-- HTML结构 -->
<div id="list">
    <p id="java">Java</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
    <p id="haskell">Haskell</p>
</div>


// 举个例子，下面的代码动态创建了一个<style>节点，然后把它添加到<head>节点的末尾，这样就动态地给文档添加了新的CSS定义：

var d = document.createElement('style');
d.setAttribute('type', 'text/css');
d.innerHTML = 'p { color: red }';
document.getElementsByTagName('head')[0].appendChild(d);


3.insertBefore
parentElement.insertBefore(newElement, referenceElement);，子节点会插入到referenceElement之前。


// 假定我们要把Haskell插入到Python之前：
<!-- HTML结构 -->
<div id="list">
    <p id="java">Java</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
</div>
可以这么写：

var
    list = document.getElementById('list'),
    ref = document.getElementById('python'),
    haskell = document.createElement('p');
haskell.id = 'haskell';
haskell.innerText = 'Haskell';
list.insertBefore(haskell, ref);


新的HTML结构如下：

<!-- HTML结构 -->
<div id="list">
    <p id="java">Java</p>
    <p id="haskell">Haskell</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
</div>


// 拿到所有的children:
var
    i, c,
    list = document.getElementById('list');
for (i = 0; i < list.children.length; i++) {
    c = list.children[i]; // 拿到第i个子节点
}


///***********************************删除：

1.removeChild
// 删除后还在内存中，可以随时添加到别的位置

// 拿到待删除节点:
var self = document.getElementById('to-be-removed');
// 拿到父节点:
var parent = self.parentElement;
// 删除:
var removed = parent.removeChild(self);
removed === self; // true

// 注意: children属性是一个只读属性，并且它在子节点变化时会实时更新。



////////////////////////////////////////////////////////////
操作表单：
/************************************************/

获取值：
// <input type="text" id="email">
var input = document.getElementById('email');
input.value; // '用户输入的值'

// <label><input type="radio" name="weekday" id="monday" value="1"> Monday</label>
// <label><input type="radio" name="weekday" id="tuesday" value="2"> Tuesday</label>
var mon = document.getElementById('monday');
var tue = document.getElementById('tuesday');
mon.value; // '1'
tue.value; // '2'
mon.checked; // true或者false，  获取用户是否勾选的值
tue.checked; // true或者false


设置值：
设置值和获取值类似，对于text、password、hidden以及select，直接设置value就可以：

// <input type="text" id="email">
var input = document.getElementById('email');
input.value = 'test@example.com'; // 文本框的内容已更新
对于单选框和复选框，设置checked为true或false即可。


HTML5控件：
HTML5新增了大量标准控件，常用的包括date、datetime、datetime-local、color等，它们都使用<input>标签：
<input type="date" value="2015-07-01">
<input type="datetime-local" value="2015-07-01T02:03:04">
<input type="color" value="#ff0000">
不支持HTML5的浏览器无法识别新的控件，会把它们当做type="text"来显示。



提交表单：
/************************************************/
方式一：
通过<form>元素的submit()方法提交一个表单，例如，响应一个<button>的click事件，在JavaScript代码中提交表单：

<!-- HTML -->
<form id="test-form">
    <input type="text" name="test">
    <button type="button" onclick="doSubmitForm()">Submit</button>
</form>

<script>
function doSubmitForm() {
    var form = document.getElementById('test-form');
    // 可以在此修改form的input...
    // 提交form:
    form.submit();
}
</script>



方式二：
是响应<form>本身的onsubmit事件，在提交form时作修改：

<!-- HTML -->
<form id="test-form" onsubmit="return checkForm()">
    <input type="text" name="test">
    <button type="submit">Submit</button>
</form>

<script>
function checkForm() {
    var form = document.getElementById('test-form');
    // 可以在此修改form的input...
    // 继续下一步:
    return true;
}
</script>

注意要return true来告诉浏览器继续提交，
如果return false，浏览器将不会继续提交form，这种情况通常对应用户输入有误，提示用户错误信息后终止提交form。



////////----<input type="hidden">的用法：

// 
<!-- HTML -->
<form id="login-form" method="post" onsubmit="return checkForm()">
    <input type="text" id="username" name="username">
    <input type="password" id="input-password">   //这个没有name属性
    <input type="hidden" id="md5-password" name="password">
    <button type="submit">Submit</button>
</form>

<script>
function checkForm() {
    var input_pwd = document.getElementById('input-password');
    var md5_pwd = document.getElementById('md5-password');
    // 把用户输入的明文变为MD5:
    md5_pwd.value = toMD5(input_pwd.value);
    // 继续下一步:
    return true;
}
</script>

note:
注意到id为md5-password的<input>标记了name="password"，而用户输入的id为input-password的<input>没有name属性。

没有name属性的<input>的数据不会被提交。


操作文件：
/************************************************/
注意：
当一个表单包含<input type="file">时，表单的enctype必须指定为multipart/form-data，method必须指定为post，
浏览器才能正确编码并以multipart/form-data格式发送表单的数据。

出于安全考虑，浏览器只允许用户点击<input type="file">来选择本地文件，用JavaScript对<input type="file">的value赋值是没有任何效果的。
当用户选择了上传某个文件后，JavaScript也无法获得该文件的真实路径：

当上传文件的时候，可以对文件的扩展名进行检查，防止无效的文件上传；
var f = document.getElementById('test-file-upload');
var filename = f.value; // 'C:\fakepath\test.png'
if (!filename || !(filename.endsWith('.jpg') || filename.endsWith('.png') || filename.endsWith('.gif'))) {
    alert('Can only upload image file.');
    return false;
}


File API
/************************************************/
随着HTML5的普及，新增的File API允许JavaScript读取文件内容，获得更多的文件信息。

HTML5的File API提供了File和FileReader两个主要对象，可以获得文件信息并读取文件。


var
    fileInput = document.getElementById('test-image-file'),
    info = document.getElementById('test-file-info'),
    preview = document.getElementById('test-image-preview');
// 监听change事件:
fileInput.addEventListener('change', function () {
    // 清除背景图片:
    preview.style.backgroundImage = '';
    // 检查文件是否选择:
    if (!fileInput.value) {
        info.innerHTML = '没有选择文件';
        return;
    }
    // 获取File引用:
    var file = fileInput.files[0];
    // 获取File信息:
    info.innerHTML = '文件: ' + file.name + '<br>' +
                     '大小: ' + file.size + '<br>' +
                     '修改: ' + file.lastModifiedDate;
    if (file.type !== 'image/jpeg' && file.type !== 'image/png' && file.type !== 'image/gif') {
        alert('不是有效的图片文件!');
        return;
    }
    // 读取文件:
    var reader = new FileReader();
    reader.onload = function(e) {
        var
            data = e.target.result; // 'data:image/jpeg;base64,/9j/4AAQSk...(base64编码)...'            
        preview.style.backgroundImage = 'url(' + data + ')';
    };
    // 以DataURL的形式读取文件:
    reader.readAsDataURL(file);
});

回调：
JavaScript中，执行多任务实际上都是异步调用：

reader.readAsDataURL(file);
就会发起一个异步操作来读取文件内容。因为是异步操作，
所以我们在JavaScript代码中就不知道什么时候操作结束，因此需要先设置一个回调函数：

reader.onload = function(e) {
    // 当文件读取完成后，自动调用此函数:
};





DOM  AJAX:
/************************************************/

'use strict';
function success(text) {
    var textarea = document.getElementById('test-response-text');
    textarea.value = text;
}

function fail(code) {
    var textarea = document.getElementById('test-response-text');
    textarea.value = 'Error code: ' + code;
}

var request;
if (window.XMLHttpRequest) {
    request = new XMLHttpRequest();// 新建XMLHttpRequest对象，现代浏览器
} else {
    request = new ActiveXObject('Microsoft.XMLHTTP'); // 新建Microsoft.XMLHTTP对象，对于低版本的IE;
}

request.onreadystatechange = function () { // 状态发生变化时，函数被回调
    if (request.readyState === 4) { // 请求是否成功完成
        // 判断响应结果:
        if (request.status === 200) {  // 是否有成功的响应
            // 成功，通过responseText拿到响应的文本:
            return success(request.responseText);
        } else {
            // 失败，根据响应码判断失败原因:
            return fail(request.status);
        }
    } else {
        // HTTP请求还在继续...
    }
}

// 发送请求:
request.open('GET', '/api/categories');
request.send();

alert('请求已发送，请等待响应...');

//注意：
XMLHttpRequest对象的open()方法有3个参数，第一个参数指定是GET还是POST，第二个参数指定URL地址，第三个参数指定是否使用异步，默认是true，所以不用写。
注意，千万不要把第三个参数指定为false，否则浏览器将停止响应，直到AJAX请求完成。如果这个请求耗时10秒，那么10秒内你会发现浏览器处于“假死”状态。
最后调用send()方法才真正发送请求。GET请求不需要参数，POST请求需要把body部分以字符串或者FormData对象传进去。




安全限制(跨域):
/************************************************/

默认情况下，JavaScript在发送AJAX请求时，URL的域名必须和当前页面完全一致。

// 跨域：
用JavaScript无法请求外域（就是其他网站）的URL方法：
一是通过Flash插件发送HTTP请求；
二是通过在同源域名下架设一个代理服务器来转发，JavaScript负责把请求发送到代理服务器：
'/proxy?url=http://www.sina.com.cn'
方式三：JSONP，它有个限制，只能用GET请求，并且要求返回JavaScript
JSONP通常以函数调用的形式返回，例如，返回JavaScript内容如下：
foo('data');

方式四：CORS
如果浏览器支持HTML5，那么就可以一劳永逸地使用新的跨域策略：CORS了。
CORS全称Cross-Origin Resource Sharing，是HTML5规范定义的如何跨域访问资源。

成功与否：Access-Control-Allow-Origin是否包含本域;

跨域能否成功，取决于对方服务器是否愿意给你设置一个正确的Access-Control-Allow-Origin
这种跨域请求，称之为“简单请求”。
简单请求包括GET、HEAD和POST（POST的Content-Type类型
仅限application/x-www-form-urlencoded、multipart/form-data和text/plain），并且不能出现任何自定义头（例如，X-Custom: 12345），通常能满足90%的需求。
由于以POST、PUT方式传送JSON格式的数据在REST中很常见，所以要跨域正确处理POST和PUT请求，服务器端必须正确响应OPTIONS请求。



Promise:（ES6）
/************************************************/

Promise有各种开源实现，在ES6中被统一规范，由浏览器直接支持。先测试一下你的浏览器是否支持Promise：

'use strict';
new Promise(function () {});
console.log('支持Promise!');


canvas:
/************************************************/
var canvas = document.getElementById('test-canvas');
if (canvas.getContext) {  // 在使用Canvas前，用canvas.getContext来测试浏览器是否支持Canvas：
    console.log('你的浏览器支持Canvas!');
} else {
    console.log('你的浏览器不支持Canvas!');
}


'use strict';

var
    canvas = document.getElementById('test-shape-canvas'),
    ctx = canvas.getContext('2d');
// 绘图；
ctx.clearRect(0, 0, 200, 200); // 擦除(0,0)位置大小为200x200的矩形，擦除的意思是把该区域变为透明
ctx.fillStyle = '#dddddd'; // 设置颜色
ctx.fillRect(10, 10, 130, 130); // 把(10,10)位置大小为130x130的矩形涂色
// 利用Path绘制复杂路径:
var path=new Path2D();
path.arc(75, 75, 50, 0, Math.PI*2, true);
path.moveTo(110,75);
path.arc(75, 75, 35, 0, Math.PI, false);
path.moveTo(65, 65);
path.arc(60, 65, 5, 0, Math.PI*2, true);
path.moveTo(95, 65);
path.arc(90, 65, 5, 0, Math.PI*2, true);
ctx.strokeStyle = '#0000ff';
ctx.stroke(path);

// 绘制文本：
ctx.clearRect(0, 0, canvas.width, canvas.height);
ctx.shadowOffsetX = 2;
ctx.shadowOffsetY = 2;
ctx.shadowBlur = 2;
ctx.shadowColor = '#666666';
ctx.font = '24px Arial';
ctx.fillStyle = '#333333';
ctx.fillText('带阴影的文字', 20, 40);

/////////////////////////////////////// JQuery----start ////////////////////////////////////

JQuery:
/************************************************/

$(function () {
    // init...
});

JQ 过滤器（Filter）
过滤器一般不单独使用，它通常附加在选择器上，帮助我们更精确地定位元素。观察过滤器的效果：
/*
<!-- HTML结构 -->
<div class="testing">
    <ul class="lang">
        <li class="lang-javascript">JavaScript</li>
        <li class="lang-python">Python</li>
        <li class="lang-lua">Lua</li>
    </ul>
</div>
*/
$('ul.lang li'); // 选出JavaScript、Python和Lua 3个节点
$('ul.lang li:first-child'); // 仅选出JavaScript
$('ul.lang li:last-child'); // 仅选出Lua
$('ul.lang li:nth-child(2)'); // 选出第N个元素，N从1开始
$('ul.lang li:nth-child(even)'); // 选出序号为偶数的元素
$('ul.lang li:nth-child(odd)'); // 选出序号为奇数的元素

$("li").css("color","#afafaf"); 
$("li:first").css("color","red"); 
$("li:last").css("color","green");
$("li:odd").css("color","blue");
$("li:eq(3)").css("color","red");
$("tr:odd").css("background-color","#7f7f7f");
$("tr:even").css("background-color","#afafaf"); 

// contains包含文本内容
$("div:contains('学习')").css("border","1px solid red");
// has 是否包含另外 jQuery包装集
$("div:has('p')").css("color","red");


/*
<!-- HTML结构 -->
<ul class="lang">
    <li class="js dy">JavaScript</li>
    <li class="dy">Python</li>
    <li id="swift">Swift</li>
    <li class="dy">Scheme</li>
    <li name="haskell">Haskell</li>
</ul>

*/

// 查找
find()
var ul = $('ul.lang'); // 获得<ul>
var dy = ul.find('.dy'); // 获得JavaScript, Python, Scheme
var swf = ul.find('#swift'); // 获得Swift
var hsk = ul.find('[name=haskell]'); // 获得Haskell

// 父节点
.parent()
var a = $('#swift').parent('.red'); // 获得Swift的上层节点<ul>，同时传入过滤条件。如果ul不符合条件，返回空jQuery对象


// 同级节点
.next()
.pre()

swift.prev(); // Python
swift.prev('.dy'); // Python


// 过滤
// 和函数式编程的map、filter类似，jQuery对象也有类似的方法。
filter():
var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
var a = langs.filter('.dy'); // 拿到JavaScript, Python, Scheme

var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
langs.filter(function () {
    return this.innerHTML.indexOf('S') === 0; // 返回S开头的节点 特别注意函数内部的this被绑定为DOM对象，不是jQuery对象
}); // 拿到Swift, Scheme


map():
map().get()
var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
var arr = langs.map(function () {
    return this.innerHTML;
}).get(); // 用get()拿到包含string的Array：['JavaScript', 'Python', 'Swift', 'Scheme', 'Haskell']

如果一个jQuery对象如果包含了不止一个DOM节点，first()、last()和slice()方法可以返回一个新的jQuery对象，把不需要的DOM节点去掉：

var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
var js = langs.first(); // JavaScript，相当于$('ul.lang li:first-child')
var haskell = langs.last(); // Haskell, 相当于$('ul.lang li:last-child')
var sub = langs.slice(2, 4); // Swift, Scheme, 参数和数组的slice()方法一致


// 获取表单，变成key-value,然后序列化；
var elts = {};
form=$('#test-form :text, #test-form :password, #test-form input:checked, #test-form select')

for(var i=0;i<form.length;i++){
    elts[form[i].name]=form[i].value
}
json=JSON.stringify(elts)

或者：
var elts = {};
$('#test-form :text, #test-form :password, #test-form input:checked, #test-form select').map(function () {
    elts[this.name] = this.value;
});
json = JSON.stringify(elts);


// ----------------------------JQ修改DOM:
修改Text和HTML:
/*
<ul id="test-ul">
    <li class="js">JavaScript</li>
    <li name="book">Java &amp; JavaScript</li>
</ul>
*/

// 有的浏览器只有innerHTML，有的浏览器支持innerText，有了jQuery对象，不需要考虑浏览器差异了，全部统一操作！
$('#test-ul li[name=book]').text(); // 'Java & JavaScript'  // text()参数为空就是获取，有参数就是设置；
$('#test-ul li[name=book]').html(); // 'Java &amp; JavaScript'


JQ修改css：
/************************************************/
$('#test-css li.dy>span').css('background-color', '#ffd351').css('color', 'red');

var div = $('#test-div');
div.css('color'); // '#000033', 获取CSS属性
div.css('color', '#336699'); // 设置CSS属性
div.css('color', ''); // 清除CSS属性

$("div").css({"width":"50px",
             "height":"50px"});  //设置两个属性


为了和JavaScript保持一致，CSS属性可以用'background-color'和'backgroundColor'两种格式。


css()方法将作用于DOM节点的style属性，具有最高优先级。如果要修改class属性，可以用jQuery提供的下列方法：

var div = $('#test-div');
div.hasClass('highlight'); // false， class是否包含highlight
div.addClass('highlight'); // 添加highlight这个class
div.removeClass('highlight'); // 删除highlight这个class



显示和隐藏DOM:
要隐藏一个DOM，我们可以设置CSS的display属性为none，利用css()方法就可以实现。
不过，要显示这个DOM就需要恢复原有的display属性，这就得先记下来原有的display属性到底是block还是inline还是别的值。


jQuery直接提供show()和hide()方法:
var a = $('a[target=_blank]');
a.hide(); // 隐藏
a.show(); // 显示


JQ和DOM互转：
/************************************************/
// 详细见JQ文件夹
$("#bt03").click(
    function()
    {//DOM对象转为JQuery
       var nowp=document.getElementById("p2"); 
       var jq_nowp=$(nowp);//$(DOM对象)
       jq_nowp.html("哈哈哈");
    }
    );   
$("#bt04").click(function(){
    var nowp=$("#p2")[0];//对象[0] 从JQ对象中获取DOM对象
    nowp.innerHTML="我是DOM改的!!!!";
})  ;   



JQ获取DOM信息：
// 无需要针对浏览器做适配
/***********************************/
// 浏览器可视窗口大小:
$(window).width(); // 800
$(window).height(); // 600

// HTML文档大小:
$(document).width(); // 800
$(document).height(); // 3500

// 某个div的大小:
var div = $('#test-div');
div.width(); // 600
div.height(); // 300
div.width(400); // 设置CSS属性 width: 400px，是否生效要看CSS是否有效
div.height('200px'); // 设置CSS属性 height: 200px，是否生效要看CSS是否有效


attr()和removeAttr()
方法用于操作DOM节点的属性：

// <div id="test-div" name="Test" start="1">...</div>
var div = $('#test-div');
div.attr('data'); // undefined, 属性不存在
div.attr('name'); // 'Test'
div.attr('name', 'Hello'); // div的name属性变为'Hello'
div.removeAttr('name'); // 删除name属性
div.attr('name'); // undefined



prop()方法和attr()类似，
但是HTML5规定有一种属性在DOM节点中可以没有值，只有出现与不出现两种，例如：

<input id="test-radio" type="radio" name="test" checked value="1">
等价于：
<input id="test-radio" type="radio" name="test" checked="checked" value="1">

attr()和prop()对于属性checked处理有所不同：
var radio = $('#test-radio');
radio.attr('checked'); // 'checked'
radio.prop('checked'); // true

prop()返回值更合理一些。不过，用is()方法判断更好：
var radio = $('#test-radio');
radio.is(':checked'); // true

类似的属性还有selected，处理时最好用is(':selected')。


JQ操作表单:
/***********************************/
对于表单元素，jQuery对象统一提供val()方法获取和设置对应的value属性：

/*
    <input id="test-input" name="email" value="">
    <select id="test-select" name="city">
        <option value="BJ" selected>Beijing</option>
        <option value="SH">Shanghai</option>
        <option value="SZ">Shenzhen</option>
    </select>
    <textarea id="test-textarea">Hello</textarea>
*/
var
    input = $('#test-input'),
    select = $('#test-select'),
    textarea = $('#test-textarea');

input.val(); // 'test'
input.val('abc@example.com'); // 文本框的内容已变为abc@example.com

select.val(); // 'BJ'
select.val('SH'); // 选择框已变为Shanghai

textarea.val(); // 'Hello'
textarea.val('Hi'); // 文本区域已更新为'Hi'
可见，一个val()就统一了各种输入框的取值和赋值的问题。


JQ修改DOM:
/***********************************/
// append()
//增加（节点不在文章当中）或者移动（节点已经存在文章当中）：

<div id="test-div">
    <ul>
        <li><span>JavaScript</span></li>
        <li><span>Python</span></li>
        <li><span>Swift</span></li>
    </ul>
</div>

var ul = $('#test-div>ul');
ul.append('<li><span>Haskell</span></li>');  // 除此之外可以用jq html,DOM的方法为appendChild();



// append()还可以传入原始的DOM对象，jQuery对象和函数对象：

// 创建DOM对象:
var ps = document.createElement('li');
ps.innerHTML = '<span>Pascal</span>';
// 添加DOM对象:
ul.append(ps);

// 添加jQuery对象:
ul.append($('#scheme'));

// 添加函数对象:
ul.append(function (index, html) {
    return '<li><span>Language - ' + index + '</span></li>';
});


// append()把DOM添加到最后，prepend()则把DOM添加到最前。

// 同级节点可以用after()或者before()方法。
var js = $('#test-div>ul>li:first-child');
js.after('<li><span>Lua</span></li>');

// 删除节点；（一个或者多个）
var li = $('#test-div>ul>li');
li.remove(); // 所有<li>全被删除


//-------------------------------实践：

<!--需求：请再添加Pascal、Lua和Ruby，然后按字母顺序排序节点：-->
<!DOCTYPE html>
<html>  
    <head>  
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
    <title>JQ添加内容和排序</title>  
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery/jquery-3.1.1.min.js"></script>
    </head>   
<body>   
<div id="test-div">
    <ul>
        <li><span>JavaScript</span></li>
        <li><span>Python</span></li>
        <li><span>Swift</span></li>
    </ul>
</div>

</body> 
<script language="JavaScript" type="text/javascript">   
var ul = $("#test-div>ul");
ul.append("<li><span>Pascal</span></li>","<li><span>Lua</span></li>","<li><span>Ruby</span></li>");
var li = $('#test-div>ul li'); //取出来的每个元素是DOM对象
// var arr = obj.find("li");
//此处用JavaScript的innerText来取值是说明JQ.find之后获得是JavaScript对象？用text()或html()会报错。
li.sort((x,y) => {return (x.innerText>y.innerText)? 1:-1}); 
ul.append(li);

/*
var ul = $('#test-div>ul');
ul.append('<li><span>Pascal</span></li>');
ul.append('<li><span>Lua</span></li>');
ul.append('<li><span>Ruby</span></li>');

var arr = [];
var span = $('#test-div>ul span');
for (var i = 0; i<span.length; i++){
arr.push(span[i].innerText); //这儿不能用html()，因为是一个dom对象，可以用innerHtml,innerText
}
arr.sort();
for (var i = 0; i<span.length; i++){
 span[i].innerText = arr[i];
}
*/
</script>   
</html>


JQ事件:
/***********************************/
// 不需要对不同的浏览器的差异，Jq已经帮忙给适配了；
/* HTML:
 *
 * <a id="test-link" href="#0">点我试试</a>
 *
 */

// 获取超链接的jQuery对象:
var a = $('#test-link');
a.on('click', function () {  // on方法用来绑定一个事件，我们需要传入事件名称和对应的处理函数。
    alert('Hello!');
});

// 简写：
a.click(function () {
    alert('Hello!');
});


jQuery能够绑定的事件主要包括：

鼠标事件
click: 鼠标单击时触发；
dblclick：鼠标双击时触发；
mouseenter：鼠标进入时触发；
mouseleave：鼠标移出时触发；
mousemove：鼠标在DOM内部移动时触发；
hover：鼠标进入和退出时触发两个函数，相当于mouseenter加上mouseleave。

键盘事件
键盘事件仅作用在当前焦点的DOM上，通常是<input>和<textarea>。

keydown：键盘按下时触发；
keyup：键盘松开时触发；
keypress：按一次键后触发。

其他事件
focus：当DOM获得焦点时触发；
blur：当DOM失去焦点时触发；
change：当<input>、<select>或<textarea>的内容改变时触发；
submit：当<form>提交时触发；
ready：当页面被载入并且DOM树完成初始化后触发。

文档就绪事件：
/*
$(document).on('ready', function () {
    $('#testForm).on('submit', function () {
        alert('submit!');
    });
});

//进化：
$(document).ready(function () {
// on('submit', function)也可以简化:
$('#testForm).submit(function () {
    alert('submit!');
});
});
*/

// 进化：
$(function () {
    // init...
});


可以反复绑定事件处理函数，它们会依次执行：

$(function () {
    console.log('init A...');
});
$(function () {
    console.log('init B...');
});
$(function () {
    console.log('init C...');
});


// 事件参数：

$(function () {
    $('#testMouseMoveDiv').mousemove(function (e) {  // e是事件；
        $('#testMouseMoveSpan').text('pageX = ' + e.pageX + ', pageY = ' + e.pageY);
    });
});

JQ bind函数用法：
/***********************************/
$(document).ready(function(){
    $("#bt01").bind("click",function(){
        $("#divmsg").hide();
    });
    //也可以如下写
    // $("#bt01").click(function(){
    //     $("#divmsg").hide();
    // });
    $("#bt02").bind("click",function(){
        $("#divmsg").show();
    })
    $("#bt03").bind("click",function(){
        $("#divmsg").html("你好 baidu"); 
    });
});



取消绑定：
/***********************************/
一个已被绑定的事件可以解除绑定，通过off('click', function)实现：

function hello() {
    alert('hello!');
}

a.click(hello); // 绑定事件

// 10秒钟后解除绑定:
setTimeout(function () {
    a.off('click', hello);
}, 10000);



// note:需要特别注意的是，下面这种写法是无效的：

// 绑定事件:
a.click(function () {
    alert('hello!');
});

// 解除绑定:
a.off('click', function () {
    alert('hello!');
});
这是因为两个匿名函数虽然长得一模一样，但是它们是两个不同的函数对象，off('click', function () {...})无法移除已绑定的第一个匿名函数。

为了实现移除效果，可以使用off('click')一次性移除已绑定的click事件的所有处理函数。

同理，无参数调用off()一次性移除已绑定的所有类型的事件处理函数。


事件触发条件：
/***********************************/
// 监控文本框的内容改动：

var input = $('#test-input');
input.change(function () {
    console.log('changed...');
});

// 但是，如果用JavaScript代码去改动文本框的值，将不会触发change事件：

var input = $('#test-input');
input.val('change it!'); // 无法触发change事件
input.change(); // 直接调用无参数的change(),手动来触发
// input.change()相当于input.trigger('change')，它是trigger()方法的简写。

浏览器安全限制:
/***********************************/
在浏览器中，有些JavaScript代码只有在用户触发下才能执行，例如，window.open()函数：

// 无法弹出新窗口，将被浏览器屏蔽:
$(function () {
    window.open('/');
});


// 作业：

选项：全选，全不选，反选：



JQ动画:
/***********************************/
//括号中的参数为：毫秒，或者slow ,fast
show() / hide() / toggle()
slideUp() / slideDown() / slidetoggle()
fadeIn() / fadeOut()  /fadeToggle()


// 自定义动画：
animate()  // 接受三个参数：动画，时间，回调

var div = $('#test-animate');
div.animate({
    opacity: 0.25,
    width: '256px',
    height: '256px'
}, 3000, function () {
    console.log('动画已结束');
    // 恢复至初始状态:
    $(this).css('opacity', '1.0').css('width', '128px').css('height', '128px');
});


// 串行动画：
var div = $('#test-animates');
// 动画效果：slideDown - 暂停 - 放大 - 暂停 - 缩小
div.slideDown(2000)
   .delay(1000)  //暂停
   .animate({
       width: '256px',
       height: '256px'
   }, 2000)
   .delay(1000)
   .animate({
       width: '128px',
       height: '128px'
   }, 2000);
}

为什么有的动画没有效果
你可能会遇到，有的动画如slideUp()根本没有效果。这是因为jQuery动画的原理是逐渐改变CSS的值，如height从100px逐渐变为0。
但是很多不是block性质的DOM元素，对它们设置height根本就不起作用，所以动画也就没有效果。

此外，jQuery也没有实现对background-color的动画效果，用animate()设置background-color也没有效果。这种情况下可以使用CSS3的transition实现动画效果。



JQ  AJAX:
/************************************************/

jQuery在全局对象jQuery（也就是$）绑定了ajax()函数，可以处理AJAX请求。ajax(url, settings)函数需要接收一个URL和一个可选的settings对象，常用的选项如下：

async：是否异步执行AJAX请求，默认为true，千万不要指定为false；

method：发送的Method，缺省为'GET'，可指定为'POST'、'PUT'等；

contentType：发送POST请求的格式，默认值为'application/x-www-form-urlencoded; charset=UTF-8'，也可以指定为text/plain、application/json；

data：发送的数据，可以是字符串、数组或object。如果是GET请求，data将被转换成query附加到URL上，如果是POST请求，根据contentType把data序列化成合适的格式；

headers：发送的额外的HTTP头，必须是一个object；

dataType：接收的数据格式，可以指定为'html'、'xml'、'json'、'text'等，缺省情况下根据响应的Content-Type猜测



var jqxhr = $.ajax('/api/categories', {
    dataType: 'json'
}).done(function (data) {
    ajaxLog('成功, 收到的数据: ' + JSON.stringify(data));
}).fail(function (xhr, status) {
    ajaxLog('失败: ' + xhr.status + ', 原因: ' + status);
}).always(function () {
    ajaxLog('请求完成: 无论成功或失败都会调用');
});


//get: jq会自动拼接url
var jqxhr = $.get('/path/to/resource', {
    name: 'Bob Lee',
    check: 1
});

//post:
var jqxhr = $.post('/path/to/resource', {
    name: 'Bob Lee',
    check: 1
});

//getJSON:
由于JSON用得越来越普遍，所以jQuery也提供了getJSON()方法来快速通过GET获取一个JSON对象：

var jqxhr = $.getJSON('/path/to/resource', {
    name: 'Bob Lee',
    check: 1
}).done(function (data) {
    // data已经被解析为JSON对象了
});

//安全限制:
jQuery的AJAX完全封装的是JavaScript的AJAX操作，所以它的安全限制和前面讲的用JavaScript写AJAX完全一样。

如果需要使用JSONP，可以在ajax()中设置jsonp: 'callback'，让jQuery实现JSONP跨域加载数据。


编写jQ插件：
/************************************************/
//通过扩展$.fn对象实现的
// highlight插件：
$.fn.highlight1 = function () {
    // this已绑定为当前jQuery对象:
    this.css('backgroundColor', '#fffceb').css('color', '#d85030');
    return this; //为什么最后要return this;？因为jQuery对象支持链式操作，我们自己写的扩展方法也要能继续链式下去
}

$('span.hl').highlight1().slideDown(); //链式传递

//--------------------------------------------
// 方法名中要自己传递参数；options为传入对象
$.fn.highlight2 = function (options) {
    // 要考虑到各种情况:
    // options为undefined
    // options只有部分key
    var bgcolor = options && options.backgroundColor || '#fffceb';   // a||b = a;
    var color = options && options.color || '#d85030';
    this.css('backgroundColor', bgcolor).css('color', color);
    return this;
}
// 调用：
$('#test-highlight2 span').highlight2({
    backgroundColor: '#00f8e6',
    color: '#ffffff'
});
//--------------------------------------------


jQuery提供的辅助方法$.extend(target, obj1, obj2, ...)，它把多个object对象的属性合并到第一个target对象中，遇到同名属性，总是使用靠后的对象的值，也就是越往后优先级越高：

// 把默认值和用户传入的options合并到对象{}中并返回:
var opts = $.extend({}, {
    backgroundColor: '#00a8e6',
    color: '#ffffff'
}, options);

//--------------------------------------------
// highlight最终版：
$.fn.highlight = function (options) {
    // 合并默认值和用户设定值:
    var opts = $.extend({}, $.fn.highlight.defaults, options);
    this.css('backgroundColor', opts.backgroundColor).css('color', opts.color);
    return this;
}

// 程序设定默认值:
$.fn.highlight.defaults = {
    color: '#d85030',
    backgroundColor: '#fff8de'
}
// 用户设定默认值：或者缺省处理；
$.fn.highlight.defaults.color = '#fff';
$.fn.highlight.defaults.backgroundColor = '#000';
// 调用：
$('xx').highlight({
    color: '#d85037'
});
//--------------------------------------------
最终，我们得出编写一个jQuery插件的原则：

给$.fn绑定函数，实现插件的代码逻辑；
插件函数最后要return this;以支持链式调用；
插件函数要有默认值，绑定在$.fn.<pluginName>.defaults上；
用户在调用时可传入设定值以便覆盖默认值。
/////////////////////////////////////// JQuery----end ////////////////////////////////////


// 异常：
try {
    ...
} catch (e) {
    ...
} finally {
    ...
}

错误类型:
JavaScript有一个标准的Error对象表示错误，还有从Error派生的TypeError、ReferenceError等错误对象。我们在处理错误时，可以通过catch(e)捕获的变量e访问错误对象：

try {
    ...
} catch (e) {
    if (e instanceof TypeError) {
        alert('Type error!');
    } else if (e instanceof Error) {
        alert(e.message);
    } else {
        alert('Error: ' + e);
    }
}
使用变量e是一个习惯用法，也可以以其他变量名命名，如catch(ex)。



抛出错误:
抛出错误使用throw语句。
JavaScript允许抛出任意对象，包括数字、字符串。但是，最好还是抛出一个Error对象。
var r, n, s;
try {
    s = prompt('请输入一个数字');
    n = parseInt(s);
    if (isNaN(n)) {
        throw new Error('输入错误');
    }
    // 计算平方:
    r = n * n;
    console.log(n + ' * ' + n + ' = ' + r);
} catch (e) {
    console.log('出错了：' + e);
}


当我们用catch捕获错误时，一定要编写错误处理语句：不然捕获错误没有意义；
var n = 0, s;
try {
    n = s.length;
} catch (e) {
    console.log(e);
}
console.log(n);


错误传播：
如果在一个函数内部发生了错误，它自身没有捕获，错误就会被抛到外层调用函数，如果外层函数也没有捕获，
该错误会一直沿着函数调用链向上抛出，直到被JavaScript引擎捕获，代码终止执行。


涉及到异步代码，无法在调用时捕获，原因就是在捕获的当时，回调函数并未执行；

// 如下： 调用setTimeout()的时候，没有抛出异常，要不哭哦printTime()的错误，需要在外层捕获；
function printTime() {
    throw new Error();
}

try {
    setTimeout(printTime, 1000);
    console.log('done');
} catch (e) {
    console.log('error');
}


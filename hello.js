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
DOM操作：
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





AJAX:
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








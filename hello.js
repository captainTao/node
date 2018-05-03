'use strict';

// 面向对象编程

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
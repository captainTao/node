'use strict';

// 面向对象编程

/************************************************/
// 1.通过现成对象创建：

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


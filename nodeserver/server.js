const Koa = require('koa')
const path = require('path')
const staticFiles = require('koa-static')
// 定义一个内核
const app = new Koa()
// 读取本地文件的目录
let main = staticFiles(path.resolve(__dirname, "./tools"))
// 内核读取哪些文件，这里为html
app.use(main, {extensions: ['html']})
// 启动服务 监听
app.listen(80, () =>{
    console.log('server is running at http://localhost:80')
})
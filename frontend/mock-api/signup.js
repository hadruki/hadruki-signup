var jsonServer = require('json-server')
var server = jsonServer.create()
var router = jsonServer.router('signup.json')
var middlewares = jsonServer.defaults()

server.use(middlewares)
server.use(jsonServer.bodyParser)

server.post('/signup', function (req, res) {
  console.log(req.method, " ", req.url, " with ", req.headers, ". Body: ")
  console.log(req.body)
  console.log(req.body.username)
  var db = router.db // lowdb instance
  var matchedUsers = db
    .get('users')
    .filter(user => user.username === req.body.username)
    .value()
  if(matchedUsers.length == 0){
    res.status(404).jsonp()
  } else {
    var testuser = matchedUsers[0]
    console.log("testuser: " + testuser)
    if(testuser.username == "500"){
      res.status(500).jsonp({
        error: "Something bad happened... :-("
      })
    } else {
      res.jsonp(testuser)
    }
  }
})

server.use(router)
server.listen(3000, function () {
  console.log('JSON Server is running')
})
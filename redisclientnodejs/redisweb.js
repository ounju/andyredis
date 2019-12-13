const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');

  var redis = require('redis'), client = redis.createClient(6379,'127.0.0.1');
  client.auth('redispasswoed');
  // aaa = client.set("ddd", "444444444", redis.print)
  // aaa = client.set("ddd", "444444444")
  // client.expire("ddd", 10, redis.print);
  // bbb = client.get("ddd", redis.print)
  bbb = client.get("ddd")

  // res.end('Hello World' + aaa + ' ' + bbb);
  res.end('Hello World ' + bbb);
  client.quit();

});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});


// client.set("string key", "string val", redis.print);
// client.hset("hash key", "hashtest 1", "some value", redis.print);
// client.hset(["hash key", "hashtest 2", "some other value"], redis.print);
// client.hkeys("hash key", function (err, replies) {
//     console.log(replies.length + " replies:");
//     replies.forEach(function (reply, i) {
//         console.log("    " + i + ": " + reply);
//     });
//     client.quit();
// });

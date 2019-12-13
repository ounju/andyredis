var Redis = require("ioredis");
var client = new Redis({
      sentinels: [
        { host: "10.1.3.", port: 26379 }  //서비스 andyredis 의 아이피를 설정
      ],
      sentinelPassword: "redispassword",
      name: "mymaster",
      password: "redispassword"
});
client.set("ddd", "4444444445555", function (err, reply) {
      console.log(reply);
})
client.get("ddd", function (err, reply) {
      console.log(reply);
})
client.quit();

var Redis = require("ioredis");
var client = new Redis({
      sentinels: [
        { host: "a9c51f164208f11ea906b06b9971f375-1360734662.ap-northeast-2.elb.amazonaws.com", port: 26379 }  //서비스 andyredis 의 IP 또는 도메인를 설정
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

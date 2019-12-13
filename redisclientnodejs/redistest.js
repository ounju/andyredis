// npm install redis
// redis example
var redis = require('redis'), client = redis.createClient(6379,'andyredis');
client.auth('redispasswoed');

// if you'd like to select database 3, instead of 0 (default), call
// client.select(3, function() { /* ... */ });

// client.on("error", function (err) {
//     console.log("Error " + err);
// });

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

// client.set("ddd", "444444444", redis.print)
client.set("ddd", "444444444", function (err, reply) {
    if (err) {
        console.log(err);
    } else {
        console.log(reply);
    }
})

// client.expire("ddd", 10, redis.print);
// client.get("ddd", redis.print)
client.get("ddd", function (err, reply) {
    if (err) {
        console.log(err);
    } else {
        console.log(reply);
    }
})

client.quit();
// client.end(true); // No further commands will be processed

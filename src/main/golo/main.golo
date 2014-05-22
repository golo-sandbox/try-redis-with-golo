module tryredis

import redis.clients.jedis.Jedis

function main = |args| {

  let jedis = Jedis("localhost", 6379)

  let bob = map[["firstName", "Bob"], ["lastName", "Morane"]]
  let john = map[["firstName", "John"], ["lastName", "Doe"]]
  let jane = map[["firstName", "Jane"], ["lastName", "Doe"]]

  # === save all humans to the redis server ===

  jedis: hmset("bob:male", bob)
  jedis: hmset("john:male", john)
  jedis: hmset("jane:female", jane)

  # === get Jane ===

  println(jedis: hgetAll("jane:female"))

  # === get All Humans keys ===

  jedis: keys("*"): each(|key| -> println(key))

  # === get All Humans ===

  jedis: keys("*"): each(|key| -> println(jedis: hgetAll(key)))

  # === get only males ===

  jedis: keys("*:male"): each(|key| -> println(jedis: hgetAll(key)))

}

module.exports = (robot) ->
  robot.hear /hello/i, (msg) ->
    msg.send "Hello, there!"

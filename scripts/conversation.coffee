module.exports = (robot) ->

  prefix = [
    "恩...",
    "就決定是你了 ",
    "有沒有聽過傳說中的 ",
  ]

  robot.hear /hello/i, (msg) ->
    msg.send "Hello, there!"

  robot.respond /what to eat/i, (msg) ->
    robot.http("http://beta.foodudes.co/grape_api/v1/restaurants/random")
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        if err
          msg.send "Server is died."
          return
        if res.statusCode isnt 200
          msg.send "198, 199, 201, 202..."
          return

        data = JSON.parse(body)
        msg.send "#{msg.random prefix} #{data.name}"


  robot.router.post '/m-hubot/:room', (req, res) ->
    room = req.params.room
    content = req.params.content

    robot.messageRoom room, req
    res.send req







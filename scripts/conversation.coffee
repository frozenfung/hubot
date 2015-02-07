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

    robot.messageRoom room, "#{content}"

    res.send 'OK'

  robot.router.get "/hubot/version", (req, res) ->
    res.end robot.version

  robot.router.post "/hubot/ping", (req, res) ->
    res.end "PONG"

  robot.router.get "/hubot/time", (req, res) ->
    res.end "Server time is: #{new Date()}"

  robot.router.get "/hubot/info", (req, res) ->
    child = spawn('/bin/sh', ['-c', "echo I\\'m $LOGNAME@$(hostname):$(pwd) \\($(git rev-parse HEAD)\\)"])

    child.stdout.on 'data', (data) ->
      res.end "#{data.toString().trim()} running node #{process.version} [pid: #{process.pid}]"
      child.stdin.end()

  robot.router.get "/hubot/ip", (req, res) ->
    robot.http('http://ifconfig.me/ip').get() (err, r, body) ->
      res.end body







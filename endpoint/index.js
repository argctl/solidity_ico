const http = require('node:http')

const server = http.createServer()

server.on('request', (req, res) => {
  req.on('error', console.error) 
  let data = ''
  req.on('data', chunk => {
    data += chunk
  })
  req.on('end', () => {
    console.log({ data })
  })
  res.end()
})

server.listen(8080, console.log('listening...'))

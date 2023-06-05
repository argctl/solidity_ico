const http = require('node:http')
const { scryptSync } = require('node:crypto')

const server = http.createServer((req, res) => {
  const { url } = req
  let data = ''
  req.on('data', chunk => {
    data += chunk
  })
  req.on('end', () => {
    console.log({ data })
    const hash = scryptSync(data, 'secondkeyexample', 64)
    // 
    res.writeHead(200, { 'Content-Type': 'application/json' })
    res.end(JSON.stringify({
      url,
      data,
      hash
    }))
  })
  req.on('error', e => {
    throw Error(e)
  })
  
})

server.listen(8000)
const { spawn } = require('node:child_process')
const fs = require('node:fs')

const ganache = spawn('ganache')

console.log(`argv: ${process.argv[2]}`)
let log = ''
ganache.stdout.on('data', data => {
  if (process.argv[2] === 'log') log += data
  if (data.includes('RPC Listening on 127.0.0.1:8545')) {
    const truffle = spawn('./runner.sh')
    truffle.stdout.on('data', data => {
      console.log(`${data}`)
      if (data.includes('passing')) ganache.kill()
      if (process.argv[2] === 'log') fs.writeFileSync('ganache.log', log)
    })
  }
})


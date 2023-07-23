const fs = require('node:fs')
const code = require('./code.json')


code[process.argv[2]] = process.argv[3]
fs.writeFileSync('./code.json', JSON.stringify(code, null, 2))

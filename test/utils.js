const wait = async ms => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve() 
    }, ms)
  })
}

const logs = ({ receipt }) =>  receipt.logs.flatMap(log => log.args.map(arg => arg))

module.exports = {
  wait,
  logs
}

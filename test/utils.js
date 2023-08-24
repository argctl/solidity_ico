const wait = async ms => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve() 
    }, ms)
  })
}

module.exports = {
  wait
}

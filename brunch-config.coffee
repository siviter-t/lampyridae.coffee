pkg    = require './package.json'
name   = pkg.name.replace(/\.[^/.]+$/, "")
output = pkg.directories.build
src    = pkg.directories.src
test   = pkg.directories.test

module.exports = config:
  paths:
    public: output
    watched: [src, test, '']
  
  files:
    javascripts:
      joinTo: "#{name}.js"
  
  modules:
    autoRequire: "#{name}.js": ["#{name}"]
    nameCleaner: (path) => path.replace(/^src\//, '')
  
  plugins:
    coffeescript:
      bare: false
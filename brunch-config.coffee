pkg = require './package.json'
name = pkg.name.replace(/\.[^/.]+$/, "")
version = pkg.version
output = 'lib'
src = 'src'
test = 'test'

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
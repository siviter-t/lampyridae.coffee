# Todo: Add version number to built lib files e.g. lampyridae-0.3-min.js

## Cakefile requirements
fs            = require 'fs'
{exec, spawn} = require 'child_process'

##  Application settings
appName    = 'lampyridae'
appVersion = '0.1'
src        = 'src'              # Source directory - relative to Cakefile
build      = 'build'            # Where to mirror the source directory for std builds
lib        = 'lib'              # Where to put joined and minified versions of the app
coffeeExt  = '.coffee'          # Extension used for CoffeeScripts files
minSuffix  = '-min'             # Notation used to indicated a minified .js file

## ANSI Terminal Colours
unless process.env.NODE_DISABLE_COLORS
  bold       = '\x1B[0;1m'
  underline  = '\x1B[0;4m'
  black      = '\x1b[0;30m'
  red        = '\x1B[0;31m'
  green      = '\x1B[0;32m'
  yellow     = '\x1B[0;33m'
  blue       = '\x1B[0;34m'
  magenta    = '\x1B[0;35m'
  cyan       = '\x1B[0;36m'
  white      = '\x1B[0;37m'
  reset      = '\x1B[0m'

## Echo a message with formatting
echo = (message, format = '', extra = '') ->
  console.log "#{format}#{message}#{reset} #{extra}"

## CoffeeScript compilation
compile = (args, type = '', callback) ->
  echo 'Executing CoffeeScript compiler:', yellow, type 
  coffee = spawn 'coffee', args
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    echo data.toString(), bold
  coffee.on 'exit', (code) ->
    callback?() if code is 0
    echo 'Compilation successful.', green, 'Exiting.'

## Source file concatenation (.coffee)
joinFiles = (srcFiles, callback) ->
  echo 'Source files to join:', magenta, srcFiles
  catFile = "#{build}/#{appName}#{coffeeExt}"
  srcFiles = ("#{src}/" + file for file in srcFiles when file.match(/\.(lit)?coffee$/))
  echo 'Joining source files...', yellow 
  cat = spawn 'cat', srcFiles
  cat.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  cat.stdout.on 'data', (data) ->
    fs.writeFileSync(catFile, data.toString(), 'utf8');
  cat.on 'exit', (code) ->
    callback?() if code is 0
    echo 'Concatenation successful ->', green, catFile
  return catFile

## Compilation additional options
option '-b', '--bare', 'Compile without a top-level function wrapper'
option '-w', '--watch', 'Watch the source files and rebuild if changed'

compileOptions = (options) ->
  args = []
  if options.watch then args.push '--watch'
  if options.bare then args.push '--bare'
  if args.length > 0
    echo 'Additional compilation flags:', cyan, args
  return args

## Standard build - Transcompile all files in #{src}/*#{coffeeExt} to #{build}/*l.js
task 'build', "Transcompile all files in #{src}/*#{coffeeExt} to #{build}/*.js", (options) ->
  defaultArgs = ['--compile', '--output', "#{build}", "#{src}"]
  compile compileOptions(options).concat(defaultArgs), 'Standard'

# Joined build - Transcompile and join all files in #{src}/*#{coffeeExt} to #{lib}/#{appName}.js
task 'join', "Transcompile and join all files in #{src}/*#{coffeeExt} to #{lib}/#{appName}.js", (options) ->
  srcFiles = fs.readdirSync "#{src}"
  catFile = joinFiles(srcFiles)
  defaultArgs = ['--compile', '--output', "#{lib}", catFile]
  compile compileOptions(options).concat(defaultArgs), 'Joined'
  
# Minify the unified #{lib}/#{appName}.js file to #{lib}/#{appName}#{minSuffix}.js
task 'minify', "Minify the unified #{lib}/#{appName}.js file to #{lib}/#{appName}#{minSuffix}.js", ->
  exec "uglifyjs #{lib}/#{appName}.js -c -m --output #{lib}/#{appName}#{minSuffix}.js", (err, stdout, stderr) ->
    throw err if err
    echo stdout + stderr, red
  echo "Minified #{lib}/#{appName}.js into #{lib}/#{appName}#{minSuffix}.js", green, "\nExiting."
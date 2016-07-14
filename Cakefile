# @file Cakefile
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

## Cakefile requirements
fs      = require 'fs'
{spawn} = require 'child_process'
pkg     = require './package.json'

##  Application settings
appName   = pkg.name.replace(/\.[^/.]+$/, "")
src       = 'src'              # Source directory - relative to Cakefile
build     = 'build'            # Where to mirror the source directory for std builds
lib       = 'lib'              # Where to put joined and minified versions of the app
coffeeExt = '.coffee'          # Extension used for CoffeeScripts files
minSuffix = 'min'             # Notation used to indicated a minified .js file

## ANSI Terminal Colours
unless process.env.NODE_DISABLE_COLORS
  bold      = '\x1B[0;1m'
  underline = '\x1B[0;4m'
  black     = '\x1b[0;30m'
  red       = '\x1B[0;31m'
  green     = '\x1B[0;32m'
  yellow    = '\x1B[0;33m'
  blue      = '\x1B[0;34m'
  magenta   = '\x1B[0;35m'
  cyan      = '\x1B[0;36m'
  white     = '\x1B[0;37m'
  reset     = '\x1B[0m'

## Message format
msgFormat = (message, format = '', extra = '') -> "#{format}#{message}#{reset} #{extra}"

## Echo a message with formatting
echo = (message, format = '', extra = '') -> console.log msgFormat(message, format, extra)

## Cakefile options
# option '-b', '--bare', 'Compile without a top-level function wrapper'
option '-o', '--output [DIR]', 'Where to output the compiled files (compile)'
option '-s', '--source [DIR]', 'Where to read the target files (compile)'
option '-v', '--versioned', 'Append package version to the minified file (minify)'
option '-w', '--watch', 'Watch the source files and rebuild if changed (compile|build)'

processOptions = (options) ->
  args = {}
  if options.output then args.output = options.output
  if options.source then args.source = options.source
  if options.versioned then args.versioned = "-#{pkg.version}-"
  if options.watch then args.watch = 'watch'
  if Object.keys(args).length > 0
    echo '[cake] Flags:', cyan, Object.keys(args)
  return args

## Compile - Transpile all files in the present working directory
task 'compile', "Transpile all files in the present working directory: #{process.env.PWD}", (options) ->
  args = processOptions(options)
  pwd = process.env.PWD
  echo '[cake]', magenta, 'Starting the CoffeeScript compiler'
  child = spawn 'coffee', ['-c', '-o', args.output ? '.', args.source ? '.'], { cwd: pwd }
  child.stderr.on 'data', (data) ->
    process.stderr.write msgFormat('[stderr]', red, data.toString())
  child.stdout.on 'data', (data) ->
    process.stdout.write msgFormat('[coffee]', bold, data.toString())
  child.on 'error', (err) -> throw err
  child.on 'close', (code, signal) ->
    if code is 0 then echo '[cake]', green, 'Compilation successful'
    else echo '[cake]', yellow, 'Compilation unsuccessful'
    
## Standard build - Transpile all files in project_root/src/*coffeeExt to project_root/lib/appName.js with brunch
task 'build', "Transpile all files in #{process.cwd()}/#{src}/*#{coffeeExt} to #{process.cwd()}/#{lib}/#{appName}.js with brunch", (options) ->
  args = processOptions(options)
  echo '[cake]', magenta, 'Starting the brunch build system'
  child = spawn 'brunch', [args.watch ? 'build'], { detatched: false }
  child.stderr.on 'data', (data) ->
    process.stderr.write msgFormat('[stderr]', red, data.toString())
  child.stdout.on 'data', (data) ->
    process.stdout.write msgFormat('[brunch]', bold, data.toString())
  child.on 'error', (err) -> throw err
  child.on 'close', (code, signal) ->
    if code is 0 then echo '[cake]', green, 'Compilation successful'
    else echo '[cake]', yellow, 'Compilation unsuccessful'

# Minify project_root/lib/appName.js to project_root/lib/appName-minSuffix.js
task 'minify', "Minify #{process.cwd()}/#{lib}/#{appName}.js to #{process.cwd()}/#{lib}/#{appName}-#{minSuffix}.js", (options) ->
  args = processOptions(options)
  echo '[cake]', magenta, 'Starting uglifyjs'
  child = spawn 'uglifyjs', ["#{lib}/#{appName}.js", '-c', '-m']
  child.stderr.on 'data', (data) ->
    process.stderr.write msgFormat('[stderr]', red, data.toString())
  child.stdout.on 'data', (data) ->
    fs.writeFileSync("#{lib}/#{appName}#{args.versioned ? '-'}#{minSuffix}.js", data.toString(), 'utf8');
  child.on 'error', (err) -> throw err
  child.on 'close', (code, signal) ->
    if code is 0
      echo '[cake]', green, "Minified #{lib}/#{appName}.js into #{lib}/#{appName}#{args.versioned ? '-'}#{minSuffix}.js"
    else echo '[cake]', yellow, 'Minification unsuccessful'
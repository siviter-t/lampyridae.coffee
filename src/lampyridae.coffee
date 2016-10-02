# @file lampyridae.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

# Header information for the concatenated master file
### @file lampyridae.js
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.
###

# Create the Lampyridae 'namespace' if possible; throw an error if not.
#
# @example Create a class in the namespace with global access
#   class Lampyridae.Foo
#      ...
#   
#   foo = new Lampyridae.Foo
#
do () ->
  if not window.Lampyridae? then window.Lampyridae = {}
  else
    err = new Error 'Lampyridae namespace could not be assigned. Is there a conflict?'
    err.name = 'FatalError'
    throw err

### Default Requirements ###
require 'config'
require 'util/log'
require 'util/checkSupport'

### Conditional Debugging Mode ###
# To activate, use `var DEBUG = true` before loading this library!
if DEBUG? then if DEBUG
  "use strict"
  Lampyridae.Log.isLogging = true
  Lampyridae.Log.info "Debugging on"
  Lampyridae.Log.info "Version #{Lampyridae.version}"

### Default Requirements - if everything else checks out! ###
require 'core/canvas'
require 'core/draw'
require 'particle/particle'
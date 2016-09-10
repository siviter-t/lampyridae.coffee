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

"use strict"

### Default Requirements ###
require 'config'
require 'core/canvas'
require 'core/draw'
require 'particle/particle'
# @file checkSupport.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'lampyridae'

### Whether the Browser or environment supports the canvas drawing api.
#
# @return [Bool] True if it does, false if it does not
###
Lampyridae.checkSupport = () ->
  return Boolean document.createElement('canvas').getContext
# end function Lampyridae.checkSupport

module.exports = Lampyridae.checkSupport
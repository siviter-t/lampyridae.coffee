# @file mediaMinWidth.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'lampyridae'

### Whether the current screen has a specified minimum width
#
# @param width [String] The width to check as a string - with a unit, e.g. px
# @return [Bool] True if it does, false if it does not
###
Lampyridae.mediaMinWidth = (width = '600px') ->
  return window.matchMedia("screen and (min-width: #{width})").matches
# end function Lampyridae.mediaMinWidth

module.exports = Lampyridae.mediaMinWidth
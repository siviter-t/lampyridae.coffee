# @file rand.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

### Generates a random float from the given interval [l, u) where u > l
#
# @param l [Number] The lower bound of the interval
# @param u [Number] The upper bound of the interval
# @return [Number] Random number from the interval [l, u)
###
Lampyridae.rand = (l, u) ->
   if arguments.length == 0 then return Math.random()
   return (u - l) * Math.random() + l
# end function Lampyridae.rand
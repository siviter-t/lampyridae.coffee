# @file _init_.coffee
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

### Global application settings ###
window.Lampyridae.enableSimpleGlow = true
window.Lampyridae.timestep = 1

### Common variables ###
window.Lampyridae.PI2 = 2.0 * Math.PI

### 'Lightning' Bug specific variables ###
window.Lampyridae.bugHueMax = 102.72 # Green
window.Lampyridae.bugHueMin = 65.28 # Yellow
window.Lampyridae.bugSaturation = '100%'
window.Lampyridae.bugLightness = '50%'
window.Lampyridae.bugOpacity = 0.8
window.Lampyridae.bugRadiusMax = 3.0
window.Lampyridae.bugRadiusMin = 0.5
window.Lampyridae.bugSpeedMin = 1
window.Lampyridae.bugSpeedMax = 7
window.Lampyridae.bugTurningAngle = 0.1 * Math.PI

### Available classes ###
window.Lampyridae.Bug
window.Lampyridae.Canvas
window.Lampyridae.Particle

### Available functions ###
window.Lampyridae.hslToRgb
window.Lampyridae.rand
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
initL = do ->
   if not window.Lampyridae? then window.Lampyridae = {}
   else
      err = new Error 'Lampyridae namespace could not be assigned. Is there a conflict?'
      err.name = 'FatalError'
      throw err

### Global application settings
###

window.Lampyridae.bugDefaultColour = "#FAFF0A"
window.Lampyridae.bugHueMax = 102.72 # Green
window.Lampyridae.bugHueMin = 65.28 # Yellow
window.Lampyridae.bugSaturation = '100%'
window.Lampyridae.bugLightness = '50%'
window.Lampyridae.bugRadiusMax = 2.0
window.Lampyridae.bugRadiusMin = 0.25
window.Lampyridae.bugTurningAngle = 0.25 * Math.PI
window.Lampyridae.timestep = 1
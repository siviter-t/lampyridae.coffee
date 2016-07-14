# @file config.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

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
# @file config.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

### Global application settings ###
Lampyridae.enableSimpleGlow = true
Lampyridae.timestep = 1

### Common variables ###
Lampyridae.PI2 = 2.0 * Math.PI

### 'Lightning' Bug specific variables ###
Lampyridae.bugHueMax = 102.72 # Green
Lampyridae.bugHueMin = 65.28 # Yellow
Lampyridae.bugSaturation = '100%'
Lampyridae.bugLightness = '50%'
Lampyridae.bugOpacity = 0.8
Lampyridae.bugRadiusMax = 3.0
Lampyridae.bugRadiusMin = 0.5
Lampyridae.bugSpeedMin = 1
Lampyridae.bugSpeedMax = 7
Lampyridae.bugTurningAngle = 0.1 * Math.PI
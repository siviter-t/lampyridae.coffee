# @file logging.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

Lampyridae.Log = {}
Lampyridae.Log.prefix = "#{window.Lampyridae.name}: "

### Log out a message.
#
# @param message [String] Message to log out!
# @param type [String] Type of output [""|error|info|warn]
###
Lampyridae.Log.out = (message, type = "") ->
  if arguments.length < 1
    msg = "Nothing to log!"
    type = "warn"
  msg = @prefix + msg
  if window.Lampyridae.logging
    switch type
      when "error" then return console.error msg
      when "info" then return console.info msg
      when "warn" then return console.warn msg
      else return console.log msg 

module.exports = Lampyridae.Log
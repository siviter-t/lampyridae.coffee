# @file logging.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

Lampyridae.Log = {}

Lampyridae.Log.default = () -> Lampyridae.Log.warn "Nothing to log!"

Lampyridae.Log.error = (message) ->
  if arguments.length < 1 then @default() else console.error @wrap(message) 

Lampyridae.Log.info = (message) ->
  if arguments.length < 1 then @default() else console.info @wrap(message) 

Lampyridae.Log.out = (message) ->
  if arguments.length < 1 then @default() else console.log @wrap(message) 

Lampyridae.Log.prefix = "#{Lampyridae.name}: "

Lampyridae.Log.warn = (message) ->
  if arguments.length < 1 then @default() else console.warn @wrap(message)

Lampyridae.Log.wrap = (message) -> @prefix + message

module.exports = Lampyridae.Log
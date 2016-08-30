# @file tests.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

# Helpful dom element creation and removal functions
window.createElementById = (id = '', tag = 'div', parent = 'body') ->
  element = document.createElement tag
  if id != '' then element.id = id
  if parent == 'body' then document.body.appendChild element
  else document.getElementById(parent).appendChild element
  return element

window.removeElementById = (id) ->
  element = document.getElementById id
  element.parentNode.removeChild element

# Introductory tests to check that a dom of some kind exists and that a version of the
# Lampyridae development library is loaded etc...
describe 'Lampyridae introductory tests', ->
  it 'A DOM should exist', -> should.exist(document)
  it 'and it should have a body tag', -> should.exist(document.body)
  it 'Lampyridae should be loaded and accessible', -> should.exist(window.Lampyridae)
  it 'jQuery shouldn\'t be loaded or needed', -> should.not.exist(window.jQuery)

# Once the document is ready, execute the unit tests...
$(document).ready ->
  require './testCanvas'
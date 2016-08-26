# @file tests.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

# Introductory tests to check that a dom of some kind exists...
describe 'Lampyridae Tests', ->
  it 'A DOM should exist', -> should.exist(document)
  it 'and it should have a body tag', -> should.exist(document.body)

# Once the document is ready, execute the unit tests...
$(document).ready ->
  require './testCanvas'
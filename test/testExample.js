/* @file testExample.js
 * @Copyright (c) 2016 Taylor Siviter
 * This source code is licensed under the MIT License.
 * For full information, see the LICENSE file in the project root.
 */

// $(document).ready(function() {
  require('particle/bug');
  
  var animate, bugs, canvas, createBugs, numOfBugs, update;
  canvas = new Lampyridae.Canvas('world');
  Lampyridae.bugSpeedMax = 5;
  numOfBugs = 25;
  bugs = [];
  
  createBugs = function() {
    var bug, i, j, ref;
    for (i = j = 0, ref = numOfBugs; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      bug = new Lampyridae.Bug(canvas);
      bugs.push(bug);
    }
  };
  
  animate = function() {
    canvas.draw.clear();
    update();
    requestAnimationFrame(animate);
  };
  
  update = function() {
    var i, j, ref;
    for (i = j = 0, ref = numOfBugs; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      bugs[i].update();
    }
  };
  
  createBugs();
  animate();
  
// });
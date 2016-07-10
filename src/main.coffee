
###
# Example usage
###
$(document).ready ->
   canvas = new Lampyridae.Canvas 'world'
   
   numOfBugs = 50
   bugs = []
   
   createBugs = () ->
      for i in [0...numOfBugs]
         bug = new Lampyridae.Bug canvas
         bugs.push bug
      return
      
   animate = () ->
      canvas.draw.clear()
      update()
      requestAnimationFrame animate
      return
   
   update = () ->
      bugs[i].update() for i in [0...numOfBugs]
      return
   
   createBugs()
   animate()
   
   return
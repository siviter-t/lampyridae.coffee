
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
      canvas.clear()
      update()
      # requestAnimationFrame animate # Undo for animation
      return
   
   update = () ->
      bugs[i].update() for i in [0...numOfBugs]
      return
   
   createBugs()
   animate()
   
   return
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class CanvasClass
  constructor: (@name) ->
    console.log('CanvasClass constructor was called')
    # @resize_canvas_and_draw()

  resize_canvas_and_draw: =>
    canvas = $(document).getElementById('main_canvas')
    context = canvas.getContext('2d')

    # resize the canvas to fill browser window dynamically
    window.addEventListener('resize', @resizeCanvas, false);

  resizeCanvas: =>
    canvas = $('#canvas')[0] # $(document)[0].getElementById('canvas') # $('#canvas')[0]
    console.log('resizeCanvas. document: ' + document)
    console.log('resizeCanvas. canvas: ' + canvas)
    context = canvas.getContext('2d');
    alert "3"
    alert "window was resized!";

  test_fn: =>
    alert "test!"

ready = ->
  animal = new CanvasClass("canvas name!")
  console.log('ready\'s document: ' + document)
  console.log(document.getElementById('canvas'))
  animal.resizeCanvas()



$(document).ready(ready)
# $(document).on('page:load', ready)
# ###### http://www.ibm.com/developerworks/library/wa-coffee3/
# alert "Animal is a #{animal.name}"


# (function() {
#         var canvas = document.getElementById('canvas'),
#                 context = canvas.getContext('2d');

#         // resize the canvas to fill browser window dynamically
#         window.addEventListener('resize', resizeCanvas, false);
        
#         function resizeCanvas() {
#                 canvas.width = window.innerWidth;
#                 canvas.height = window.innerHeight;
                
#                 /**
#                  * Your drawings need to be inside this function otherwise they will be reset when 
#                  * you resize the browser window and the canvas goes will be cleared.
#                  */
#                 drawStuff(); 
#         }
#         resizeCanvas();
        
#         function drawStuff() {
#                 // do your drawing stuff here
#         }
# })();

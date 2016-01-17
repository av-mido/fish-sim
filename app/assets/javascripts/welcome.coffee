# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Creature
  constructor: (@x, @y) ->
    zzz = 2+2

class Food
  constructor: (@x, @y) ->
    zzz = 3+3

class DrawStateClass
  constructor: (@name) ->
    console.log('DrawStateClass constructor was called')
    @canvas = $('#canvas')[0]
    @context = @canvas.getContext('2d');
    console.log('constructor. document: ' + document)
    console.log('constructor. canvas: ' + @canvas)
    $(window).resize(@resizeCanvas)

    @creatures = [new Creature(3,3), new Creature(7,7)]
    @foods = [new Food(100, 100)]

  # resize_canvas_and_draw: =>
  #   canvas = $(document).getElementById('main_canvas')
  #   context = canvas.getContext('2d')
  #   # resize the canvas to fill browser window dynamically
  #   window.addEventListener('resize', @resizeCanvas, false);

  outer_initializer: =>
    # canvas = $('#canvas')[0] # $(document)[0].getElementById('canvas')
    console.log('outer_initializer')
    @resizeCanvas()
    
    

  resizeCanvas: =>
    console.log('resizeCanvas was called!')
    @canvas.width = window.innerWidth;
    @canvas.height = window.innerHeight;
    @drawStuff()

  drawStuff: =>
    @context.clearRect(0, 0, @canvas.width, @canvas.height)
    



ready_fn = ->
  console.log('entered ready_fn')
  animal = new DrawStateClass("canvas name!")
  console.log(document.getElementById('canvas'))
  animal.outer_initializer()

$(document).ready(ready_fn)
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

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# @app is based on https://stackoverflow.com/questions/6150455/structuring-coffeescript-code
@app = window.app ? {}

class DrawStateClass
  constructor: (@name) ->
    console.log('DrawStateClass constructor was called')
    @canvas = $('#canvas')[0]
    @context = @canvas.getContext('2d');
    console.log('constructor. document: ' + document)
    console.log('constructor. canvas: ' + @canvas)
    $(window).resize(@resizeCanvas)

    @creatures = [new app.Creature(0, 3,3,'red'), new app.Creature(1, 70,70,'green')]
    @foods = [new app.Food(100, 100, 100, 'yellow')]
    @cur_creature_idx = 0

  outer_initializer: =>
    # canvas = $('#canvas')[0] # $(document)[0].getElementById('canvas')
    console.log('outer_initializer')
    @resizeCanvas()
    
    

  resizeCanvas: =>
    console.log('resizeCanvas was called!')
    @canvas.width = window.innerWidth;
    @canvas.height = window.innerHeight;
    @drawStuff()

  drawStuff: () =>
    # Calculations for one creature at a time.
    # console.log(@cur_creature_idx)
    calc_creature = @creatures[@cur_creature_idx]
    calc_creature.doAntiGravityCalculations(@foods, @creatures)
    @spawn_delete_food()
    # Drawing
    @context.clearRect(0, 0, @canvas.width, @canvas.height) 
    for draw_creature in @creatures
      @context.beginPath(); 
      @context.arc(draw_creature.x, draw_creature.y, 10, 0, 2 * Math.PI, false)
      @context.fillStyle = draw_creature.color
      @context.closePath()
      @context.fill()
    for food in @foods
      @context.beginPath()
      @context.arc(food.x, food.y, 10, 0, 2 * Math.PI, false)
      @context.fillStyle = food.color
      @context.closePath()
      @context.fill()
    # Recursive loop
    @cur_creature_idx = (@cur_creature_idx + 1) % @creatures.length
    window.requestAnimationFrame(@drawStuff)

  spawn_delete_food: () =>
    for creature in @creatures
      for food in @foods
        if creature.getRange(creature.x, creature.y, food.x, food.y) < 5
          @foods = @foods.filter (f) -> f.id != food.id
    if @foods.length == 0
      rand_id = @rand_int(999999)
      rand_x = @rand_int(@canvas.width)
      rand_y = @rand_int(@canvas.height)
      console.log(rand_id, rand_x, rand_y)
      @foods.push(new app.Food(rand_id, rand_x, rand_y, 'yellow'))

  rand_int: (max) ->
    rand_x = Math.floor(Math.random() * (max - 0 + 1)) + 0


ready_fn = ->
  console.log('entered ready_fn')
  animal = new DrawStateClass("canvas name!")
  console.log(document.getElementById('canvas'))
  animal.outer_initializer()

$(document).ready(ready_fn)
# $(document).on('page:load', ready)
# ###### http://www.ibm.com/developerworks/library/wa-coffee3/
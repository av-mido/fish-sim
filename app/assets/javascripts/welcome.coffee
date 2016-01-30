# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Creature
  constructor: (@id, @x, @y, @color) ->
    @power = 50
    @power_exp = 3

  doAntiGravityCalculations: (foods, creatures) =>
    # https://stackoverflow.com/questions/874875/basic-pathfinding-with-obstacle-avoidance-in-a-continuous-2d-space
    # http://www.ibm.com/developerworks/java/library/j-antigrav/
    # @x = @x + 1
    # @y = @y + 1
    xforce = 0
    yforce = 0
    for food in foods
      [xf, yf] = @calcForces(food)
      xforce += xf
      yforce += yf
    for creature in creatures
      # Dont apply forces to yourself
      if creature.id != @id
        [xf, yf] = @calcForces(creature)
        xforce -= xf
        yforce -= yf
    @move(xforce, yforce)

  move: (xforce, yforce) =>
    # console.log("sum forces: ", @id, @color, xforce, yforce)
    # if Math.abs(xforce) < 0.0001
    @x = @x - (xforce && xforce / Math.abs(xforce)) 
    @y = @y - (yforce && yforce / Math.abs(yforce))

  calcForces: (obj) =>
    force = obj.power/Math.pow(@getRange(@x,@y,obj.x,obj.y),obj.power_exp);
    ang = Math.PI/2 - Math.atan2(@y - obj.y, @x - obj.x)
    # console.log(@x, @y, ang)
    xforce = Math.sin(ang) * force;
    yforce = Math.cos(ang) * force;
    # console.log(@id, obj.color, xforce, yforce)
    if isNaN(xforce)
      xforce = 0
    if isNaN(yforce)
      yforce = 0
    return [xforce, yforce]

  # Returns the distance between two points**/
  getRange: (x1, y1,  x2, y2) =>
    x = x2-x1;
    y = y2-y1;
    range = Math.sqrt(x*x + y*y);
    # console.log(range)
    return range; 

class Food
  constructor: (@id, @x, @y, @color) ->
    @power = 10
    @power_exp = 2

class DrawStateClass
  constructor: (@name) ->
    console.log('DrawStateClass constructor was called')
    @canvas = $('#canvas')[0]
    @context = @canvas.getContext('2d');
    console.log('constructor. document: ' + document)
    console.log('constructor. canvas: ' + @canvas)
    $(window).resize(@resizeCanvas)

    @creatures = [new Creature(0, 3,3,'red'), new Creature(1, 70,70,'green')]
    @foods = [new Food(100, 100, 100, 'yellow')]
    @cur_creature_idx = 0

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
      @foods.push(new Food(rand_id, rand_x, rand_y, 'yellow'))

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
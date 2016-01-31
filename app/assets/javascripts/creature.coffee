# @app is based on https://stackoverflow.com/questions/6150455/structuring-coffeescript-code
@app = window.app ? {}

class app.Creature
  constructor: (@id, @x, @y, @color) ->
    @power = 5000 # 50
    @power_exp = 6 # 3
    @movement_magnitude = 5.0
    @previous_move = [5,0]

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
    # x_sign = (xforce && xforce / Math.abs(xforce)) 
    # y_sign = (yforce && yforce / Math.abs(yforce))
    # scaler comes from the formula: sqrt((ax)^2 + (ay)^2) = c
    #      where 'c' is a constant length vector.
    [scaled_x, scaled_y] = @getScaledVector(xforce, yforce)
    avg_x = (@previous_move[0] + scaled_x) / 2.0
    avg_y = (@previous_move[1] + scaled_y) / 2.0
    [avg_x, avg_y] = @getScaledVector(avg_x, avg_y)
    @x = @x - avg_x
    @y = @y - avg_y
    @previous_move = [avg_x, avg_y]

  getScaledVector: (x, y) =>
    scaler = @movement_magnitude / (Math.sqrt(x*x + y*y))
    return [scaler*x, scaler*y]

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
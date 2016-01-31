# @app is based on https://stackoverflow.com/questions/6150455/structuring-coffeescript-code
@app = window.app ? {}

class app.Food
  constructor: (@id, @x, @y, @color) ->
    @power = 10
    @power_exp = 2
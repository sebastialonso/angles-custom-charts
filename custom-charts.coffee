# Notice now we're extending the particular Line chart type, rather than the base class.
Chart.types.Line.extend
  name: 'ManyLines'
  initialize: (data) ->
    Chart.types.Line::initialize.apply this, arguments
    return
  draw: ->    
    Chart.types.Line::draw.apply this, arguments
    if @options.lines.length > 0 
      for line in @options.lines
        if line.lineAtIndex  > 0 and line.lineAtChart != undefined

          # Get the required x coordinate at the correct dataset
          point = @datasets[line.lineAtChart].points[line.lineAtIndex]
          scale = @scale

          # Draw the line
          @chart.ctx.beginPath()
          @chart.ctx.moveTo point.x, scale.startPoint + 24
          @chart.ctx.strokeStyle = line.lineColor
          @chart.ctx.lineTo point.x, scale.endPoint
          @chart.ctx.stroke()

          # Write text on top of line
          @chart.ctx.textAlign = 'center'  
          @chart.ctx.fillText line.lineText, point.x, scale.startPoint + 12
      return
    return

angles = angular.module 'angles'
angles.directive 'manylineschart', ->
  angles.chart 'ManyLines'
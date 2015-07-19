# Notice now we're extending the particular Line chart type, rather than the base class.
Chart.types.Line.extend
  name: 'ManyLines'
  initialize: (data) ->
    Chart.types.Line::initialize.apply this, arguments
    return
  draw: ->    
    Chart.types.Line::draw.apply this, arguments
    if @options.vlines.length > 0 

      #Vertical lines
      for line in @options.vlines
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
    
    #Horizontal lines
    if @options.hlines.length > 0
      for line in @options.hvlines
        if @scale.min < line.lineAt and @scale.max > line.lineAt
          scale = @scale 

          delta = (scale.endPoint - scale.startPoint) / (scale.max - scale.min)
          console.log delta
          @chart.ctx.beginPath()
          @chart.ctx.moveTo scale.xScalePaddingLeft, scale.endPoint - delta * line.lineAt
          @chart.ctx.lineTo scale.width - scale.xScalePaddingRight, scale.endPoint - delta * line.lineAt
          @chart.ctx.lineWidth = line.lineWidth
          @chart.ctx.strokeStyle = line.lineColor
          @chart.ctx.stroke()
    return
    

angles = angular.module 'angles'
angles.directive 'manylineschart', ->
  angles.chart 'ManyLines'
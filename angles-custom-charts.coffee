
# LineChart extension -- ManyLines
Chart.types.Line.extend
  name: 'ManyLines'
  initialize: (data) ->
    Chart.types.Line::initialize.apply this, arguments
    return
  draw: ->    
    Chart.types.Line::draw.apply this, arguments
    if @options.vlines != undefined and @options.vlines.length > 0 

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
          @chart.ctx.fillStyle = line.lineColor || '#666'
          @chart.ctx.fillText line.lineText, point.x, scale.startPoint + 12
    
    #Horizontal lines
    if @options.hlines != undefined and @options.hlines.length > 0
      for line in @options.hlines
        if @scale.min < line.lineAt and @scale.max > line.lineAt
          scale = @scale 

          delta = (scale.endPoint - scale.startPoint) / (scale.max - scale.min)
          @chart.ctx.beginPath()
          @chart.ctx.moveTo scale.xScalePaddingLeft, scale.endPoint - delta * line.lineAt
          @chart.ctx.lineTo scale.width - scale.xScalePaddingRight, scale.endPoint - delta * line.lineAt
          @chart.ctx.lineWidth = line.lineWidth || 1
          @chart.ctx.strokeStyle = line.lineColor || '#666'
          @chart.ctx.stroke()
    return

# LineChart extension -- Overlays
Chart.types.Line.extend
  name: 'Overlay'
  initialize: (data) ->
    Chart.types.Line::initialize.apply this, arguments
    return
  draw: ->    
    Chart.types.Line::draw.apply this, arguments
    if @options.overlays != undefined and @options.overlays.length > 0
      for overlay in @options.overlays
        scale = @scale
        delta = (scale.endPoint - scale.startPoint) / (scale.max - scale.min)
        bottomPoint = scale.endPoint - delta*overlay.bottomLeft
        topPoint = scale.endPoint - delta*overlay.topLeft
        @chart.ctx.beginPath()
        @chart.ctx.rect scale.xScalePaddingLeft, bottomPoint , scale.width - scale.xScalePaddingLeft, topPoint - bottomPoint
        @chart.ctx.fillStyle = overlay.color || 'rgba(52,152,219, 0.3)'
        @chart.ctx.fill();
    return

# Directives  
angles = angular.module 'angles'

# ManyLines directive
angles.directive 'manylineschart', ->
  angles.chart 'ManyLines'

# Overlay directive
angles.directive 'overlaychart', ->
  angles.chart 'Overlay'
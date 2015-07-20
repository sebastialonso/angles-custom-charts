var angles;

Chart.types.Line.extend({
  name: 'ManyLines',
  initialize: function(data) {
    Chart.types.Line.prototype.initialize.apply(this, arguments);
  },
  draw: function() {
    var delta, i, j, len, len1, line, point, ref, ref1, scale;
    Chart.types.Line.prototype.draw.apply(this, arguments);
    if (this.options.vlines !== void 0 && this.options.vlines.length > 0) {
      ref = this.options.vlines;
      for (i = 0, len = ref.length; i < len; i++) {
        line = ref[i];
        if (line.lineAtIndex > 0 && line.lineAtChart !== void 0) {
          point = this.datasets[line.lineAtChart].points[line.lineAtIndex];
          scale = this.scale;
          this.chart.ctx.beginPath();
          this.chart.ctx.moveTo(point.x, scale.startPoint + 24);
          this.chart.ctx.strokeStyle = line.lineColor;
          this.chart.ctx.lineTo(point.x, scale.endPoint);
          this.chart.ctx.stroke();
          this.chart.ctx.textAlign = 'center';
          this.chart.ctx.fillStyle = line.lineColor || '#666';
          this.chart.ctx.fillText(line.lineText, point.x, scale.startPoint + 12);
        }
      }
    }
    if (this.options.hlines !== void 0 && this.options.hlines.length > 0) {
      ref1 = this.options.hlines;
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        line = ref1[j];
        if (this.scale.min < line.lineAt && this.scale.max > line.lineAt) {
          scale = this.scale;
          delta = (scale.endPoint - scale.startPoint) / (scale.max - scale.min);
          this.chart.ctx.beginPath();
          this.chart.ctx.moveTo(scale.xScalePaddingLeft, scale.endPoint - delta * line.lineAt);
          this.chart.ctx.lineTo(scale.width - scale.xScalePaddingRight, scale.endPoint - delta * line.lineAt);
          this.chart.ctx.lineWidth = line.lineWidth || 1;
          this.chart.ctx.strokeStyle = line.lineColor || '#666';
          this.chart.ctx.stroke();
        }
      }
    }
  }
});

Chart.types.Line.extend({
  name: 'Overlay',
  initialize: function(data) {
    Chart.types.Line.prototype.initialize.apply(this, arguments);
  },
  draw: function() {
    var bottomPoint, delta, i, len, overlay, ref, scale, topPoint;
    Chart.types.Line.prototype.draw.apply(this, arguments);
    if (this.options.overlays !== void 0 && this.options.overlays.length > 0) {
      ref = this.options.overlays;
      for (i = 0, len = ref.length; i < len; i++) {
        overlay = ref[i];
        scale = this.scale;
        delta = (scale.endPoint - scale.startPoint) / (scale.max - scale.min);
        bottomPoint = scale.endPoint - delta * overlay.bottomLeft;
        topPoint = scale.endPoint - delta * overlay.topLeft;
        this.chart.ctx.beginPath();
        this.chart.ctx.rect(scale.xScalePaddingLeft, bottomPoint, scale.width - scale.xScalePaddingLeft, topPoint - bottomPoint);
        this.chart.ctx.fillStyle = overlay.color || 'rgba(52,152,219, 0.3)';
        this.chart.ctx.fill();
      }
    }
  }
});

angles = angular.module('angles');

angles.directive('manylineschart', function() {
  return angles.chart('ManyLines');
});

angles.directive('overlaychart', function() {
  return angles.chart('Overlay');
});
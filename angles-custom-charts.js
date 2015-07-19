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

angles = angular.module('angles');

angles.directive('manylineschart', function() {
  return angles.chart('ManyLines');
});
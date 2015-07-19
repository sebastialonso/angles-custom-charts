# Extra Charts for Angles, Charts.js in Angular

Extra Charts contains some feature-specific extensions for some of the standard charts.

So far it contains support for adding vertical and horizontal lines in a Line Chart.

## Install

`bower install --save angular-custom-charts`
## Examples

### Vertical lines

You must specify all of these in the options object as a sub-object `vlines`:

~~~ coffeescript
$scope.myChartOptions.vlines = [
  {
    lineAtChart: 0 # Dataset number (indexed by zero) (required)
    lineAtIndex: 1 # Index for datapoint the line must cross (required)
    lineText: 'Today' # Text shown on top of the line (required)
    lineColor: '#b64a8c' # Color of the line (required)
    lineWidth: 1 # Width of the line (optional)
  } 
]
~~~

Negatives values for `lineAtIndex` or absence of `lineAtChart` will result in a regular LineChart.

### Horizontal lines

You must specify all of these in the options object as a sub-object `vlines`:

~~~ coffeescript
$scope.myChartOptions.hlines = [
  {
    lineAt: 1 # Y scale value for the line to be drawn (required)
    lineText: 'Today' # Text shown on top of the line (required)
    lineColor: '#b64a8c' # Color of the line (required)
    lineWidth: 1 # Width of the line (required)
  } 
]
~~~

`lineAt` must be a value between `max` and `min`, boundary values for the Y axis. Otherwise, the line will not be drawn.

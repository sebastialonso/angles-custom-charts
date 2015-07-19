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
    lineColor: '#b64a8c' # Color of the line (optional). Default is '#666'
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
    lineColor: '#b64a8c' # Color of the line (optional). Defaults is '#666'
    lineWidth: 1 # Width of the line (optional). Default is 1
  } 
]
~~~

`lineAt` must be a value between `max` and `min`, boundary values for the Y axis. Otherwise, the line will not be drawn.


### Directive

For the `ManyLines' chart, use the `manylineschart` directive, just as any other Angles directive.
If you don't supply the lines object in the options, a regular Line Chart will be displayed.

~~~
<canvas manylineschart options="options" data="data" width="900" height="300"></canvas>
~~~
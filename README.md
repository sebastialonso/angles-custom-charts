# Extra Charts for Angles, Charts.js in Angular

Custom Charts contains some feature-specific extensions for some of the standard charts.

So far it contains support for adding vertical lines in a Line Chart, where you can also specify the dataset the line is to appear, its color, width and text.

You must specify all of these in the options object as a sub object `lines`:

~~~
$scope.myChartOptions.lines = [
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

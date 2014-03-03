var width = 180
    barHeight = 20

var linearScale = d3.scale.linear()
                    .range([0, width])

var chart = d3.select(".census")
              .append("svg")
              .attr("width", width)

d3.csv("data/cells.csv", type,  function(error, data){
linearScale.domain([0, d3.max(data, function(d) { return d.frequency; })]);

  chart.attr("height", barHeight * data.length);
  var barOffset = function(d){return width - (linearScale(d.frequency)+20);};

  var textOffset = function(d){if (barOffset(d) > 0){return barOffset(d);}else{return 0;}};

  var bar = chart.selectAll("g")
      .data(data)
    .enter().append("g")
      .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

  bar.append("rect")
      .attr("x", barOffset)
      .attr("width", function(d) { return linearScale(d.frequency); })
      .attr("height", barHeight - 1)
      .attr("fill", "white");

  bar.append("text")
      .attr("x", textOffset)
      .attr("y", (barHeight / 2)+5)
      .attr("fill", "black")
      .text(function(d){return d.frequency;});

  bar.append("text")
      .attr("x", function(){return width -15;})
      .attr("y", barHeight / 2)
      .attr("dy", ".35em")
      .attr("fill", "teal")
      .text(function(d) { return d.age; });
});

function type(d){
  return {
    frequency: +d.frequency,
    age: +d.age
  };
}
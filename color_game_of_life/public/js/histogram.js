var width = 100
    barHeight = 20

var linearScale = d3.scale.linear()
                    .range([0, width])

var chart = d3.select(".histogram")
              .append("svg")
              .attr("width", width)

d3.csv("data/histogram.csv", type,  function(error, data){
linearScale.domain([0, d3.max(data, function(d) { return d.frequency; })]);

  chart.attr("height", barHeight * data.length);

  var bar = chart.selectAll("g")
      .data(data)
    .enter().append("g")
      .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

  bar.append("rect")
      .attr("width", function(d) { return -1*linearScale(d.frequency); })
      .attr("height", barHeight - 1)
      .attr("fill", "white");

  bar.append("text")
      .attr("x", function(d) { return -1 * linearScale(d.frequency); })
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


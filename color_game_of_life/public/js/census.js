var width = 400
    barHeight = 200

var linearScale = d3.scale.linear()
                    .range([0, width])

var chart = d3.select(".census")
              .attr("width", width)

d3.csv("cells.csv", type, function(error, data){
  linearScale.domain([0, d3.max(data, function(d){return d.value;})]);

  chart.attr("height", barHeight * data.length);

  var bar = chart.selectAll("g")
        .data(data)
      .enter().append("g")
        .attr("transform", function(d,i){
              return "translate(0," + i *barHeight + ")";}
              );

  bar.append("rect")
    .attr("width", function(d){
      return linearScale(d.value); })
    .attr("height", barHeight - 1);

  bar.append("text")
    .attr("x", function(d){
      return linearScale(d.value) - 3;})
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function(d){return d.value;});
});

function type(d){
  d.value = +d.value
  return d;
}
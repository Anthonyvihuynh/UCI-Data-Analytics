//define chart parameters
var svgWidth = 960;
var svgHeight = 480;

var margin = {
  top: 20,
  right: 40,
  bottom: 80,
  left: 100
};

var width = svgWidth - margin.left - margin.right;
var height = svgHeight - margin.top - margin.bottom;

var svg = d3.select("#scatter")
  .append("svg")
  .attr("width", svgWidth)
  .attr("height", svgHeight);

var chartGroup = svg.append("g")
  .attr("transform", `translate(${margin.left}, ${margin.top})`);

d3.csv("assets/data/data.csv").then(function(data) {
    console.log(data)

    data.poverty = +data.poverty;
    data.healthcare = +data.healthcare;
//define properties of chart
    var xLinearScale = d3.scaleLinear()
      .domain([8, d3.min(data, d => d.poverty)*2.2])
      .range([0, width]);
    var yLinearScale = d3.scaleLinear()
      .domain([0, d3.max(data, d => d.healthcare)*3])
      .range([height, 0]);
    var bottomAxis = d3.axisBottom(xLinearScale);
    var leftAxis = d3.axisLeft(yLinearScale);
    chartGroup.append("g")
      .attr("transform", `translate(0, ${height})`)
      .call(bottomAxis);
    chartGroup.append("g")
      .call(leftAxis);

//create circle properties
    var circlesGroup = chartGroup.selectAll("circle")
    .data(data)
    .enter()
    .append("circle")
    .attr("cx", d => xLinearScale(d.poverty))
    .attr("cy", d => yLinearScale(d.healthcare))
    .attr("r", "15")
    .attr("fill", "orange")
    .attr("opacity", ".5");

//add state abbr to circles; does not appear

//chartGroup.append("text")
//.text(function(d){return d.abbr})
//.attr("x", d => xLinearScale(d.poverty))
//.attr("y", d => yLinearScale(d.healthcare));

//add popups when mouse over
    var toolTip = d3.tip()
      .attr("class", "tooltip")
      .offset([80, -60])
      .html(function(d) {
        return (`${d.abbr}<br>Poverty: ${d.poverty}<br>Healthcare: ${d.healthcare}`);
      });

    chartGroup.call(toolTip);

//tried making targeted circle bolder on mouse over, but 
//doesn't work yet

    circlesGroup.on("mouseover", function(data) {
      toolTip.show(data, this)
      .attr("opacity", ".8");;
    })
      .on("mouseout", function(data, index) {
        toolTip.hide(data)
        .attr("opacity", ".5");
      });

    chartGroup.append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 0 - margin.left + 40)
      .attr("x", 0 - (height / 2))
      .attr("dy", "1em")
      .attr("class", "axisText")
      .text("Lacks Healthcare (%)");

    chartGroup.append("text")
      .attr("transform", `translate(${width / 2}, ${height + margin.top + 30})`)
      .attr("class", "axisText")
      .text("In Poverty (%)");
});
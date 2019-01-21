function buildMetadata(sample) {

  // @TODO: Complete the following function that builds the metadata panel

  // Use `d3.json` to fetch the metadata for a sample
  var url = "`/samples/${sample}`";
  d3.json(url).then(function(data) {
    // Use d3 to select the panel with id of `#sample-metadata`
    var metaData = d3.select(`#sample-metadata`);
    // Use `.html("") to clear any existing metadata
    metaData.html("");
    // Use `Object.entries` to add each key and value pair to the panel
    // Hint: Inside the loop, you will need to use d3 to append new
    // tags for each key-value in the metadata.
    Object.entries(data).forEach(([key, value]) => {
      metaData.append("div").text(`${key}: ${value}`)}
  )
  })
    };
    // BONUS: Build the Gauge Chart
    // metadata.forEach((dataRow) => {


function buildCharts(sample) {

  // @TODO: Use `d3.json` to fetch the sample data for the plots
  var url = `/samples/${sample}`;
  d3.json(url).then((data) => {
    var response = data;
    console.log(response);
    // @TODO: Build a Bubble Chart using the sample data
  //Use otu_ids for the x values
  //Use sample_values for the y values
  //Use sample_values for the marker size
  //Use otu_ids for the marker colors
  //Use otu_labels for the text values
  
    var bubbleChart = {
      margin: {t:0},
      xaxis: {title:"Sample ID"}};

    var bubbleData = [
      {
        x: response.otu_ids,
        y: response.sample_values,
        text: response.otu_labels,
        mode: "markers",
        marker: {
          size: response.sample_values,
          color: response.otu_ids,
        }
      }
    ];

    Plotly.plot("bubble", bubbleData, bubbleChart);

    // @TODO: Build a Pie Chart
    // HINT: You will need to use slice() to grab the top 10 sample_values,
    // otu_ids, and labels (10 each).    

//Use sample_values as the values for the PIE chart
//Use otu_ids as the labels for the pie chart
//Use otu_labels as the hovertext for the chart

    var pieData = [{
      values: response.sample_values.slice(0, 10),
      labels: response.otu_ids.slice(0, 10),
      hoverinfo: response.otu_labels.slice(0, 10),
      type: "pie"
    }]

    var pieLayout = {
      margin: {top: 50, 
              left: 50}
    };

    Plotly.plot("pie", pieData, pieLayout);
  })
};

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();

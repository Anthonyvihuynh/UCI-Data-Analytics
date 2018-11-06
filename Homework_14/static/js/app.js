// from data.js
var tableData = data;
var dateInput = d3.select('#datetime');
var searchBtn = d3.select('#filter-btn');

// // YOUR CODE HERE!
var table = d3.select("#ufo-table");

// $searchBtn.addEventListener('click', dateSearch);

function renderTable() {
	for (var i = 0; i < tableData.length; i++) {
		var date = tableData[0];
		var fields = Object.keys(date);
		// var row = table.insertRow(i)
	    for (var j = 0; j < fields.length; j++) {
	    	var datum = fields[j];
	    	table.append(datum);
	};
};
};



// data.forEach((tableData) => {
// 	var row = table.append("tr");
// 	Object.entries(tableData).forEach(([datetime, city, state, country, shape, comment]) => {
// 		var cell = table.append("td");
// 		cell.text(city);
// 		var date = tableData[0]
// 	});
// });



searchBtn.on("click", function() {
	d3.event.preventDefault();
	var filteredDate = tableData.filter(tableData => tableData.datetime === datetime)
	renderTable(filteredDate);
});
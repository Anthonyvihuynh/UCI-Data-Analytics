// from data.js
var tableData = data;

// // YOUR CODE HERE!
var tbody = d3.select("tbody");
var table = d3.select("#ufo-table");

// $searchBtn.addEventListener('click', dateSearch);

// function renderTable() {
// 	for (var i = 0; i < tableData.length; i++) {
// 		var date = tableData[0];
// 		var fields = Object.keys(date);
// 		// var row = table.insertRow(i)
// 	    for (var j = 0; j < fields.length; j++) {
// 	    	var datum = fields[j];
// 	    	table.append(datum);
// 	};
// };
// };


// function buildTable(data) {
//   table.html("");
//   data.forEach((dataRow) => {
//     var row = table.append("tr");
//     Object.values(datum).forEach((datum) => {
//       var cell = row.append("td");
//         cell.text(val);
//       }
//     );
//   });
// }

function buildTable(data) {
  tbody.html("");
  data.forEach((datum) => {
    var row = tbody.append("tr");
    Object.values(datum).forEach((dataCell) => {
      var cell = row.append("td");
        cell.text(dataCell);
      }
    );
  });
}


function handleClick() {
  d3.event.preventDefault();
  var date = d3.select("#datetime").property("value");
    searchDate = tableData;
	if (date) {
    	searchDate = searchDate.filter(row => row.datetime === date);
	}
  buildTable(searchDate);
};

d3.selectAll("#filter-btn").on("click", handleClick);

buildTable(tableData);

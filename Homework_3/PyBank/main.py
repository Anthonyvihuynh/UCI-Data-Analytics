# Import modules
import os
import csv
import sys

# Locate CSV File
csvpath = os.path.join("..", "PyBank", "budget_data.csv")

# Define function to calculate mean
def average(numbers):
	return float(sum(numbers)) / max(len(numbers),1)

# Open data file with CSVReader
with open(csvpath, newline='') as csvfile:
	csvreader = csv.reader(csvfile, delimiter=',')
	
	# Skips header row
	csv_header = next(csvreader)

	# Create a list of all revenue entries
	revenues = []
	months = []
	for row in csvreader:
		months.append(row[0])
		revenues += [int(row[1])]

	# Calculate number of months (entries)
	month_count = len(revenues)
	# Calculate total revenues
	total_revenue = sum(revenues)

	# Calculate mean
	average_change = average(revenues)
	
	# Define difference between each month
	delta = [revenues[i+1] - revenues[i] for i in range(month_count-1)]

	# Find greatest increase
	gr_increase = max(delta)

	# Find greatest decrease
	gr_decrease = min(delta)

	# Match index # of increase/decrease with months
	inc_month = months[delta.index(gr_increase) + 1]

	dec_month = months[delta.index(gr_decrease) + 1]

#	for row in csvreader:
#		if row[1] == gr_increase:
#			gr_inc_month = row[0]
#		elif row[1] == gr_decrease:
#			gr_dec_month = row[0]

# Print to terminal
print("Financial Analysis")
print("----------------------------")
print(f"Total Months: {month_count}")
print(f"Total: ${total_revenue}")
print(f"Average Change: ${average_change}")
print(f"Greatest Increase in Profits: {inc_month} (${gr_increase})")
print(f"Greatest Decrease in Profits: {dec_month} (${gr_decrease})")

# Print to output file
# Create/open output file
sys.stdout = open('results.txt', 'w')
print("Financial Analysis")
print("----------------------------")
print(f"Total Months: {month_count}")
print(f"Total: ${total_revenue}")
print(f"Average Change: ${average_change}")
print(f"Greatest Increase in Profits: {inc_month} (${gr_increase})")
print(f"Greatest Decrease in Profits: {dec_month} (${gr_decrease})")
# Close output file
sys.stdout.close()
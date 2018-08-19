# Import modules
import os
import csv
import sys

# Locate CSV File
csvpath = os.path.join("..", "PyPoll", "election_data.csv")

# Open data file with CSVReader
with open(csvpath, newline='') as csvfile:
	csvreader = csv.reader(csvfile, delimiter=',')
	
	# Skips header row
	csv_header = next(csvreader)

	candidates = []
	#Count total votes
	for row in csvreader:
		candidates.append(row[2])
	votes = len(candidates)

	# Place unique names into a list
	name = list(set(candidates))

	# Calculate votes per candidate
	candi_votes = []
	for x in name: 
		candi_votes.append(int(candidates.count(x)))

	# Calculate percentage of total votes
	vote_perc = []
	for number in candi_votes:
		vote_perc.append("{:.2%}".format(number / votes))

	# Compile list of candidates and list of vote amounts
	# into a single dictionary
	result_dict = dict(zip(name, candi_votes))

# Print to terminal
print("Election Results")
print("-------------------------")
print(f"Total Votes: {votes}")
print("-------------------------")
print(f"{name[0]}: {vote_perc[0]} ({candi_votes[0]})")
print(f"{name[1]}: {vote_perc[1]} ({candi_votes[1]})")
print(f"{name[2]}: {vote_perc[2]} ({candi_votes[2]})")
print(f"{name[3]}: {vote_perc[3]} ({candi_votes[3]})")
print("-------------------------")
print("Winner: " + max(result_dict, key=result_dict.get))
print("-------------------------")

# Print to output file
# Create/open output file
sys.stdout = open('results.txt', 'w')
print("Election Results")
print("-------------------------")
print(f"Total Votes: {votes}")
print("-------------------------")
print(f"{name[0]}: {vote_perc[0]} ({candi_votes[0]})")
print(f"{name[1]}: {vote_perc[1]} ({candi_votes[1]})")
print(f"{name[2]}: {vote_perc[2]} ({candi_votes[2]})")
print(f"{name[3]}: {vote_perc[3]} ({candi_votes[3]})")
print("-------------------------")
print("Winner: " + max(result_dict, key=result_dict.get))
print("-------------------------")
# Close output file
sys.stdout.close()
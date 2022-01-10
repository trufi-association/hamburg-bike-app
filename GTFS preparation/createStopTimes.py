#!/bin/python
import os

referenceStopTimesFile = "stop_times2.txt"
referenceTripsFile = "trips.txt"
stopTimesFile = "stop_times.txt"
stopTimesHeading = "trip_id,arrival_time,departure_time,stop_id,stop_sequence,pickup_type,drop_off_type,stop_headsign"

# open all files
print("Opening '{}'...".format(referenceStopTimesFile))
referenceStopTimesFileFD = open(referenceStopTimesFile, "r")
print("Opening '{}'...".format(referenceTripsFile))
referenceTripsFileFD = open(referenceTripsFile, "r")

# read all files
print("Reading '{}'...".format(referenceStopTimesFile))
referenceStopTimesContent = referenceStopTimesFileFD.read()
print("Reading '{}'...".format(referenceTripsFile))
referenceTripsFileContent = referenceTripsFileFD.read()

# close all files
referenceStopTimesFileFD.close()
referenceTripsFileFD.close()

# indexing
print("Indexing...")
referenceStopTimesJSON = {}
referenceTripsJSON = {}
stopTimesJSON = {}
for content in [
	# csv content       , primary key, target
	(referenceStopTimesContent, 0, referenceStopTimesJSON),
	(referenceTripsFileContent, 2, referenceTripsJSON)
	]:
	for row in content[0].split("\n"):
		if row == "":
			continue
		row = row.split(",")
		key = row[content[1]]
		if not key in content[2]:
			content[2][key] = []
		content[2][key].append(",".join(row))

stopTimesContent = [stopTimesHeading]
for row in referenceTripsJSON:
	if row in referenceStopTimesJSON:
		print("Adding Trip {}".format(row))
		stopTimesContent.append("\n".join(referenceStopTimesJSON[row]))

print("Writing new stop_times.txt")
stopTimesFD = open(stopTimesFile, "w")
stopTimesFD.write("\n".join(stopTimesContent))
stopTimesFD.close()

#!/bin/python
import os

referenceTripsFile = "trips2.txt"
referenceRoutesFile = "routes.txt"
tripsFile = "trips.txt"
tripsFileHeading = "route_id,service_id,trip_id,trip_headsign,trip_short_name,direction_id,block_id,shape_id,wheelchair_accessible,bikes_allowed"

# open all files
print("Opening '{}'...".format(referenceTripsFile))
referenceTripsFileFD = open(referenceTripsFile, "r")
print("Opening '{}'...".format(referenceRoutesFile))
referenceRoutesFileFD = open(referenceRoutesFile, "r")

# read all files
print("Reading '{}'...".format(referenceTripsFile))
referenceTripsContent = referenceTripsFileFD.read()
print("Opening '{}'...".format(referenceRoutesFile))
referenceRoutesFileContent = referenceRoutesFileFD.read()

# close all files
referenceTripsFileFD.close()
referenceRoutesFileFD.close()

# indexing
print("Indexing...")
referenceTripsJSON = {}
referenceRoutesJSON = {}
stopTimesJSON = {}
for content in [
	# csv content       , primary key, target
	(referenceTripsContent, 0, referenceTripsJSON),
	(referenceRoutesFileContent, 0, referenceRoutesJSON)
	]:
	firstRow = True
	for row in content[0].split("\n"):
		if row == "" or firstRow:
			firstRow = False
			continue
		row = row.split(",")
		key = row[content[1]]
		
		# bikes_allowed=1 in each row of referenceTripsFile
		if content[0] == referenceTripsContent:
			row[9] = "1"
		
		if not key in content[2]:
			content[2][key] = []
		content[2][key].append(",".join(row))

tripsContent = [tripsFileHeading]
for row in referenceRoutesJSON:
	if row in referenceTripsJSON:
		print("Adding Trip {}".format(row))
		
		tripsContent.append("\n".join(referenceTripsJSON[row]))

print("Writing new trips.txt")
stopTimesFD = open(tripsFile, "w")
stopTimesFD.write("\n".join(tripsContent))
stopTimesFD.close()

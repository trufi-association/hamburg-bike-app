#!/bin/python
import os 

stopTimesFile = "stop_times.txt"
tripsFile = "trips.txt"
routesFile = "routes.txt"
referenceTransfersFile = "transfers2.txt"
outputFile = "transfers.txt"
outputFileHeading = "from_stop_id,to_stop_id,transfer_type,min_transfer_time,from_route_id,to_route_id,from_trip_id,to_trip_id"

stopTimesContent = ""
routesContent = ""
tripsContent = ""
referenceTransfersContent = ""

stopTimesJSON = {}
routesJSON = {}
tripsJSON = {}
referenceTransfersJSON = {}
outputContent = [outputFileHeading] # --> as a list

print("Reading {}...".format(stopTimesFile))
stopTimesFD = open(stopTimesFile, "r")
stopTimesContent = stopTimesFD.read()
stopTimesFD.close()

print("Reading {}...".format(routesFile))
routesFD = open(routesFile, "r")
routesContent = routesFD.read()
routesFD.close()

print("Reading {}...".format(tripsFile))
tripsFileFD = open(tripsFile, "r")
tripsContent = tripsFileFD.read()
tripsFileFD.close()

print("Reading {}...".format(referenceTransfersFile))
referenceTransfersFD = open(referenceTransfersFile, "r")
referenceTransfersContent = referenceTransfersFD.read().split("\n")
referenceTransfersFD.close()

indexes = [
	# csv content       , primary key, target
	(stopTimesContent, 3, stopTimesJSON),
	(tripsContent, 2, tripsJSON),
	(routesContent, 0, routesJSON),
	]

positionInTransfersTXT = [
	(0, stopTimesJSON),
	(1, stopTimesJSON),
	(4, routesJSON),
	(5, routesJSON),
	(6, tripsJSON),
	(7, tripsJSON)
	]

for content in indexes:
	for row in content[0].split("\n"):
		if row == "":
			continue
		row = row.split(",")
		key = row[content[1]]
		if not key in content[2]:
			content[2][key] = []
		content[2][key].append(",".join(row))

pointsToAchieve = len(positionInTransfersTXT)
maxLines = len(referenceTransfersContent)
line = 1
for row in referenceTransfersContent:
	print("Processing {} of {}...".format(line, maxLines))
	if row == "":
		continue
	row = row.split(",")
	points = 0
	for content in positionInTransfersTXT:
		i, json = content
		if row[i] == "" or row[i] in json:
			points += 1
			continue
	if pointsToAchieve == points:
		print("  |--> copying it...")
		outputContent.append(",".join(row))
	line += 1

print("Writing {}...".format(outputFile))
outputFD = open(outputFile, "w")
outputFD.write("\n".join(outputContent))
outputFD.close()

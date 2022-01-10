#!/bin/python
import os

whitelistAgencies = {
	"361": True,
	"76": True,
	"73": True,
	"41": True,
}

colors = {
	"S1": ["662483","ffffff"],
	"S11": ["662483","ffffff"],
	"S2": ["b71e44", "ffffff"],
	"S21": ["b71e44", "ffffff"],
	"S3": ["662383", "ffffff"],
	"S31": ["662383", "ffffff"],
	"A1": ["f39200", "ffffff"],
	"A2": ["f39200", "ffffff"],
	"A3": ["f39200", "ffffff"],
	"U1": ["0069b4", "ffffff"],
	"U2": ["e30613", "ffffff"],
	"U3": ["ffdd00", "ffffff"],
	"U4": ["009ba4", "ffffff"],
	"RB": ["1d1d1b", "ffffff"],
	"RE": ["1d1d1b", "ffffff"],
	"75": ["00b7e1","ffffff"],
	"73": ["00b7e1","ffffff"],
	"72": ["00b7e1","ffffff"],
	"64": ["00b7e1","ffffff"],
	"62": ["00b7e1","ffffff"],
	"61": ["00b7e1","ffffff"],

}

referenceRoutesFile = "routes.txt"
RoutesFileHeading = "route_id,agency_id,route_short_name,route_long_name,route_type,route_color,route_text_color,route_desc"

# open all files
print("Opening '{}'...".format(referenceRoutesFile))
referenceRoutesFileFD = open(referenceRoutesFile, "r")

# read all files
print("Reading '{}'...".format(referenceRoutesFile))
referenceRoutesFileContent = referenceRoutesFileFD.read()

# close all files
referenceRoutesFileFD.close()

# indexing
print("Indexing...")
referenceRoutesFileJSON = {}
for content in [
	# csv content       , primary key, target
	(referenceRoutesFileContent, 0, referenceRoutesFileJSON),
	]:
	for row in content[0].split("\n"):
		if row == "":
			continue
		row = row.split(",")
		key = row[content[1]]
		
		# Add only whitelisted agencies
		if not row[1] in whitelistAgencies:
			continue # if not whitelisted
		
		# Add colors if whitelisted based on route_short_name
		for route_short_name in colors:
			if row[2].replace("\"", "").startswith(route_short_name):
				row[5] = colors[route_short_name][0]
				row[6] = colors[route_short_name][1]
		
		if not key in content[2]:
			content[2][key] = []		
		
		content[2][key].append(",".join(row))

referenceRoutesFileContent = [RoutesFileHeading]
for key in referenceRoutesFileJSON:
	referenceRoutesFileContent.append("\n".join(referenceRoutesFileJSON[key]))

print("Writing new routes.txt")
referenceRoutesFileFD = open(referenceRoutesFile, "w")
referenceRoutesFileFD.write("\n".join(referenceRoutesFileContent))
referenceRoutesFileFD.close()

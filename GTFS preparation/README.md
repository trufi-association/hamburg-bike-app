# Altering the GTFS

to just include trains and ferries because taking your bicycle with you in buses is too complicated to map.

## How to only include trains and ferries with their color codes

Place the three python scripts

- **createRoutes.py**
  Script used to remove every agency not whitelisted (whitelist hardcoded). In addition that script adds known color codes to each route of whitelisted agencies. It alters `route.txt`.
- **createTrips.py**
  Script used to alter the `trips.txt` file after changes to `routes.txt`.
- **createStopTimes.py**
  Script used to alter the `stop_times.txt` after changes to `trips.txt`.
- **createTransfers.py**
  Script used to alter the `transfers.txt` after changes to `routes.txt`, `trips.txt`, `stop_times`

inside the unzipped directory with all the GTFS txts. Then perform the following steps:

1. Rename `trips.txt` to `trips2.txt`.
2. Rename `stop_times.txt` to `stop_times2.txt`.
3. Rename `transfers.txt` to `transfers2.txt`.
3. Execute `createRoutes.py`
4. Execute `createTrips.py`
5. Execute `createStopTimes.py`
6. Execute `createTransfers.py`
7. Zip the necessary files without files which end in `2.txt` or `.py`.

**TO DO:** Alter code to make renaming operations not necessary

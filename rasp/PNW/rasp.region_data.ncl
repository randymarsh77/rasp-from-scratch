#############################################################################################
#############  RASP PLOT INFORMATION - to be read by rasp.ncl  ##############################
#############################################################################################
### FORMAT FOR EACH REGION:
###   1st line: ===MY_REGION_NAME (matching that used in rasp.pl, spaces not allowed)
###   2nd line: units (american/celsius/metric)
###   then (optional) sounding location(s) of 4 lines each: (1) "sounding#" (where # is an integer) (2) sounding id (spaces allowed) (3) latitude (decimal degrees,S=negative) (4) longitude (decimal degrees, W=negative)
###   ( sounding integers normally increase sequentially but need not - numbers must not contain a "+" sign )
### IF RUN REGION IS NOT IN THIS FILE, THEN DEFAULT UNITS USED AND NO SOUNDINGS ARE PLOTTED
#############################################################################################
===PNW
american
sounding1
~F34~7~F21~Blanchard
48.6047
-122.4237
sounding2
~F34~7~F21~Bellingham
48.7928
-122.5375
sounding3
~F34~7~F21~Lookout Mtn
48.7167
-122.3958
sounding4
~F34~7~F21~Abbotsford
49.0253
-122.3600
sounding5
~F34~7~F21~Mt Constitution
48.6767
-122.8297

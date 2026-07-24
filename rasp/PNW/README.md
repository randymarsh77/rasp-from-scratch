# PNW region — Bellingham / Chuckanut area

Target box: 48.9387N,-122.8572W (UL) to 48.5659N,-122.1870W (BR).

Domain (Lambert conformal, centered 48.752N -122.522W):
- d01: 104x104 @ 10 km  → covers ~43.9-53.4N, 130.2-114.8W (BC coast to Oregon)
- d02: 151x151 @ 2 km   → covers ~47.4-50.1N, 124.6-120.4W (Vancouver Island to the east Cascades)

The target box sits >=40 km inside every d02 boundary.

## Geog data needed (in /root/rasp/geog, i.e. the WPS_GEOG mount)

From https://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog.html:
- geog_high_res_mandatory.tar.gz (2.6 GB dl / ~29 GB unpacked) — or
  geog_low_res_mandatory.tar.gz (150 MB) for smoke tests (see below)
- landuse_30s_with_lakes (USGS w/ lakes; optional download, matches num_land_cat=28)
- bnu_soiltype_top/bot 30s (already in ../geog_alt_lsm.tar in the project root)

SRTM 3" topo for d02 (see top-level README for gdal_translate conversion):
- srtm_12_03 (125-120W, 45-50N) — already downloaded
- srtm_12_02 (125-120W, 50-55N) — needed for the northern edge of d02
Place converted .bil/.hdr tiles in geog/topo_SRTM/.

## Low-res smoke test

With geog_low_res_mandatory + landuse_30s_with_lakes extracted into the
WPS_GEOG mount, temporarily set in namelist.wps:
  geog_data_res = 'lowres', 'lowres',
(the GEOGRID.TBL 'lowres' keyword maps every field to the low-res bundle,
except landuse which stays USGS 30s-with-lakes, so num_land_cat=28 is
unchanged). Terrain will be uselessly smooth — this only validates the
machinery and domain placement, not the forecast.

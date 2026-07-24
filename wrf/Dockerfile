ARG FEDORA_VERSION
ARG WRF_VERSION
ARG WPS_VERSION
ARG WRF_MARCH
ARG BASE_IMAGE

FROM ${BASE_IMAGE}:fedora${FEDORA_VERSION}
ARG WRF_VERSION
ARG WPS_VERSION
ARG WRF_MARCH

# required packages
RUN dnf update -y && dnf install -y \
  m4 tcsh git \
  gcc gcc-c++ gcc-gfortran \
  netcdf-devel netcdf-fortran-devel \
  libpng-devel jasper-devel \
  cmake \
  && dnf clean all

ENV CC=gcc \
  CXX=g++ \
  FC=gfortran \
  F77=gfortran \
  NETCDF=/usr \
  NETCDF_classic=1

RUN mkdir build && cd build \
  && git clone --branch ${WRF_VERSION} --depth 1 --recurse-submodule https://github.com/wrf-model/WRF.git \
  && git clone --branch ${WPS_VERSION} --depth 1 https://github.com/wrf-model/WPS.git

COPY patch_registry.sh patch_configure_wrf.sh $BASEDIR/build/WRF/
COPY patch_configure_wps.sh $BASEDIR/build/WPS/

# Docker needs more than 2GB of memory to compile WRF -- 8GB worked
# Update to use CMake configuration and compilation
# Patches to WRF might not be needed -- But probably are for netcdf
# Jasper either needs to be compiled from source (part of WRS configuration) or CMake list update to 2.0.33 from 1.900.x
# Patches to WPS probably needed for netcdf-fortran location

# WRS configure_new
#   Select configuration [0-0] Default [0] (note !!)  : 
#   [GRIB2] Build GRIB2 libraries (zlib, libpng, JasPer) from source in external/? Default [N] [y/N] : 
#   [WRF]   Attempt to find compiled WRF model (needed for geogrid and metgrid)? Default [Y] [Y/n] : 

RUN cd $BASEDIR/build/WRF \
  && sh patch_registry.sh \
  && printf "33\n1\n" | ./configure \
  && sh patch_configure_wrf.sh ${WRF_MARCH} \
  && ./compile -j 8 em_real

# Must be built after WRF
RUN cd $BASEDIR/build/WPS \
  && printf "1\n" | ./configure \
  && sh patch_configure_wps.sh \
  && ./compile

# This first installs WRF in smpar GNU mode (option 33) and WPS in serial GNU mode (option 1).
# Some parameters in the compile configurations must be changed for the compilation to succeed.

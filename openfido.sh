#!/bin/sh
#
# Generic python environment for OpenFIDO
#

on_error()
{
    echo '*** ABNORMAL TERMINATION ***'
    echo 'See error Console Output stderr for details.'
    exit 1
}

trap on_error 1 2 3 4 6 7 8 11 13 14 15

set -x # print commands
set -e # exit on error
set -u # nounset enabled

NETWORKGLM=$(grep '^NETWORKGLM,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
CONFIGGLM=$(grep '^CONFIGGLM,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
POLEGLM=$(grep '^POLEGLM,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
RECORDERGLM=$(grep '^RECORDERGLM,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
WEATHERGLM=$(grep '^WEATHERGLM,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
TIMESTEP=$(grep '^TIMESTEP,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
OPTIONS=$(grep '^OPTIONS,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)

cd ${OPENFIDO_OUTPUT}
/usr/local/bin/gridlabd ${WEATHERGLM} ${POLEGLM} ${NETWORKGLM} ${RECORDERGLM} -D minimum_timestep=${TIMESTEP} ${OPTIONS}

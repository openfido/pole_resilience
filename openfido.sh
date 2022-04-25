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
WEATHERCSV=$(grep '^WEATHERCSV,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
SETTINGSCSV=$(grep '^SETTINGSCSV,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
TIMESTEP=$(grep '^TIMESTEP,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)
OPTIONS=$(grep '^OPTIONS,' ${OPENFIDO_INPUT}/config.csv | cut -f2 -d,)

cd ${OPENFIDO_OUTPUT}
cp "${OPENFIDO_INPUT}/${CONFIGGLM}" "${OPENFIDO_INPUT}/${WEATHERCSV}" "${OPENFIDO_INPUT}/${SETTINGSCSV}" .
/usr/local/bin/gridlabd "${OPENFIDO_INPUT}/${WEATHERGLM}" "${OPENFIDO_INPUT}/${POLEGLM}" "${OPENFIDO_INPUT}/${NETWORKGLM}" "${OPENFIDO_INPUT}/${RECORDERGLM}" -D minimum_timestep=${TIMESTEP} ${OPTIONS}
rm -f "${CONFIGGLM}" "${WEATHERCSV}" "${SETTINGSCSV}"

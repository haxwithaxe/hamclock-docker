#!/bin/sh
set -e

export HOME=/hamclock

DISPLAY_RES=${DISPLAY_RES:-'1600x960'}

/usr/bin/hamclock-web-${DISPLAY_RES} -o -t 20

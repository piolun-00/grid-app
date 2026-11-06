#!/bin/sh
# Podbija numer wersji w obu miejscach naraz: APP_VERSION w index.html
# i version.json. Rozjechanie ich daje albo brak paska o nowej wersji,
# albo pasek, który nie znika po odświeżeniu.
#
#   ./bump.sh            — numer z dzisiejszej daty, kolejny tego dnia
#   ./bump.sh 2026.11.07.1 — numer podany wprost
set -e
cd "$(dirname "$0")"

if [ -n "$1" ]; then
  NEW="$1"
else
  DZIS=$(date +%Y.%m.%d)
  STARA=$(sed -n "s/.*APP_VERSION = '\([^']*\)'.*/\1/p" index.html)
  case "$STARA" in
    "$DZIS".*) NEW="$DZIS.$(( ${STARA##*.} + 1 ))" ;;
    *)         NEW="$DZIS.1" ;;
  esac
fi

sed -i '' "s/APP_VERSION = '[^']*'/APP_VERSION = '$NEW'/" index.html
printf '{ "version": "%s" }\n' "$NEW" > version.json
echo "$NEW"

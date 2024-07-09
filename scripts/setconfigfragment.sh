#!/bin/sh

CONFIG="$1"
FRAGMENT="$2"

echo "Apply config fragment $FRAGMENT to $CONFIG"

# Remove duplicate options
for opt in $(egrep -o "CONFIG_[A-Z]+" "$FRAGMENT"); do
    echo "/$opt/d"
done | sed -f - -i "$CONFIG"

# Merge fragment and config options
echo "" >> "$CONFIG"
echo "#" >> "$CONFIG"
echo "# begin of config fragment $FRAGMENT" >> "$CONFIG"
echo "#" >> "$CONFIG"
cat "$FRAGMENT" | envsubst >> "$CONFIG"
echo "#" >> "$CONFIG"
echo "# end of config fragment $FRAGMENT" >> "$CONFIG"
echo "#" >> "$CONFIG"
echo "" >> "$CONFIG"

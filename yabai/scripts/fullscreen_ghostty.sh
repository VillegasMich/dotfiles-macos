#!/usr/bin/env sh

# Ghostty is set to manage=off (see yabairc), so bsp never touches it. This
# just resizes each newly created Ghostty window to fill its display's usable
# area (inside yabai's padding), since manage=off windows otherwise keep
# whatever frame macOS gave them.

new_window_id="$YABAI_WINDOW_ID"

top_padding=8
bottom_padding=8
left_padding=8
right_padding=8

display_id=$(yabai -m query --windows --window "$new_window_id" | jq -r '.display')
display_frame=$(yabai -m query --displays --display "$display_id" | jq -r '.frame')

dx=$(echo "$display_frame" | jq -r '.x')
dy=$(echo "$display_frame" | jq -r '.y')
dw=$(echo "$display_frame" | jq -r '.w')
dh=$(echo "$display_frame" | jq -r '.h')

x=$(echo "$dx + $left_padding" | bc)
y=$(echo "$dy + $top_padding" | bc)
w=$(echo "$dw - $left_padding - $right_padding" | bc)
h=$(echo "$dh - $top_padding - $bottom_padding" | bc)

yabai -m window "$new_window_id" --move abs:"$x":"$y"
yabai -m window "$new_window_id" --resize abs:"$w":"$h"

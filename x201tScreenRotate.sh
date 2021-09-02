#!/usr/bin/env bash
#
# @AUTHOR: Luca Leon Happel
# @DATE  : 2021-06-13 So 00:50 57
#
# This is a script that toggles rotation of the screen through xrandr,
# and also toggles rotation of the stylus, eraser and cursor through xsetwacom

screen=`xrandr --current | grep " connected" | awk '{print $1;}'`
orientation=`xrandr --verbose -q | grep $screen | awk '{print $6}'`

echo $screen
echo $orientation

function wacom_setup {
	xsetwacom set "Wacom Serial Penabled 2FG Touchscreen Pen stylus" Rotate $1
	xsetwacom set "Wacom Serial Penabled 2FG Touchscreen Pen eraser" Rotate $1
	xsetwacom set "Wacom Serial Penabled 2FG Touchscreen Finger touch" Rotate $1
}

if [ "$1" = "normal" ]; then
    if [ "$orientation" = "normal" ]; then
		xrandr --output $screen --rotate right
		wacom_setup cw
    else
		xrandr --output $screen --rotate normal
		wacom_setup none
    fi
elif [ "$1" = "invert" ]; then
    if [ "$orientation" = "normal" ]; then
		xrandr --output $screen --rotate inverted
		wacom_setup half
    elif [ "$orientation" = "inverted" ]; then
		xrandr --output $screen --rotate normal
		wacom_setup none
    elif [ "$orientation" = "right" ]; then
		xrandr --output $screen --rotate left
		wacom_setup ccw
    elif [ "$orientation" = "left" ]; then
		xrandr --output $screen --rotate right
		wacom_setup cw
    fi
fi

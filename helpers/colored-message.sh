#!/bin/bash

# Define the function to print colored messages
colored_message() {
    printf "\e[$1m$2\e[0m\n"
}

# Define the color switch (mapping color names to color codes)
case $1 in
    "Black")      color_code=30 ;;
    "Red")        color_code=31 ;;
    "Green")      color_code=32 ;;
    "Yellow")     color_code=33 ;;
    "Blue")       color_code=34 ;;
    "Magenta")    color_code=35 ;;
    "Cyan")       color_code=36 ;;
    "White")      color_code=37 ;;
    "BrightBlack") color_code=90 ;;
    "BrightRed")  color_code=91 ;;
    "BrightGreen") color_code=92 ;;
    "BrightYellow") color_code=93 ;;
    "BrightBlue")  color_code=94 ;;
    "BrightMagenta") color_code=95 ;;
    "BrightCyan")  color_code=96 ;;
    "BrightWhite") color_code=97 ;;
    *)
        echo "Invalid color name. Valid options are: Black, Red, Green, Yellow, Blue, Magenta, Cyan, White, BrightBlack, BrightRed, BrightGreen, BrightYellow, BrightBlue, BrightMagenta, BrightCyan, BrightWhite."
        exit 1
        ;;
esac

# Call the colored_message function with the color code and message
colored_message $color_code "$2"

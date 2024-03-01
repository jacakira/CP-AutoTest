#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# FILE: progressbar.plugin.zsh
# DESCRIPTION: Show a progress bar GUI on terminal platform
# AUTHOR: Toan Nguyen (hello at nntoan dot com)
# VERSION: 1.0.0
# ------------------------------------------------------------------------------

function delay()
{
    sleep 0.2;
}

CURRENT_PROGRESS=0
function progress()
{
    PARAM_PROGRESS=$1;
    PARAM_STATUS=$2;

    if [ $CURRENT_PROGRESS -le 0 -a $PARAM_PROGRESS -ge 0 ]    ; then echo -ne "[....................] (0%)  $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 5 -a $PARAM_PROGRESS -ge 5 ]    ; then echo -ne "[#...................] (5%)  $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 10 -a $PARAM_PROGRESS -ge 10 ]  ; then echo -ne "[##..................] (10%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 15 -a $PARAM_PROGRESS -ge 15 ]  ; then echo -ne "[###.................] (15%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 20 -a $PARAM_PROGRESS -ge 20 ]  ; then echo -ne "[####................] (20%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 25 -a $PARAM_PROGRESS -ge 25 ]  ; then echo -ne "[#####...............] (25%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 30 -a $PARAM_PROGRESS -ge 30 ]  ; then echo -ne "[######..............] (30%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 35 -a $PARAM_PROGRESS -ge 35 ]  ; then echo -ne "[#######.............] (35%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 40 -a $PARAM_PROGRESS -ge 40 ]  ; then echo -ne "[########............] (40%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 45 -a $PARAM_PROGRESS -ge 45 ]  ; then echo -ne "[#########...........] (45%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 50 -a $PARAM_PROGRESS -ge 50 ]  ; then echo -ne "[##########..........] (50%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 55 -a $PARAM_PROGRESS -ge 55 ]  ; then echo -ne "[###########.........] (55%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 60 -a $PARAM_PROGRESS -ge 60 ]  ; then echo -ne "[############........] (60%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 65 -a $PARAM_PROGRESS -ge 65 ]  ; then echo -ne "[#############.......] (65%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 70 -a $PARAM_PROGRESS -ge 70 ]  ; then echo -ne "[##############......] (70%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 75 -a $PARAM_PROGRESS -ge 75 ]  ; then echo -ne "[###############.....] (75%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 80 -a $PARAM_PROGRESS -ge 80 ]  ; then echo -ne "[################....] (80%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 85 -a $PARAM_PROGRESS -ge 85 ]  ; then echo -ne "[#################...] (85%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 90 -a $PARAM_PROGRESS -ge 90 ]  ; then echo -ne "[##################..] (90%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 95 -a $PARAM_PROGRESS -ge 95 ]  ; then echo -ne "[###################.] (95%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 100 -a $PARAM_PROGRESS -ge 100 ]; then echo -ne 'Done!                                            \n' ; delay; fi;

    CURRENT_PROGRESS=$PARAM_PROGRESS;
}

# Function to run tests

cprun() {
  # Check the number of arguments is one
  if [ $# -ne 1 ]; then
    echo "Usage: cprun <filename>"
    return 1
  fi
# Create variables
  local input_file="$1.in"
  local output_file="$1.out"
  local PARAM_PHASE="Compiling"

  # Clear output file
  rm -f "$output_file"

  # Progress bar for compilation
  progress 0 "$PARAM_PHASE"

  # Compile C++ file
  g++-13 "$1.cpp" -o "$1"
  
  # Check if compilation was successful
  if [ $? -ne 0 ]; then
    echo "Compilation failed. Exiting."
    return 1
  fi

  # Progress bar for processing
  PARAM_PHASE="Compiling"
  progress 50 "$PARAM_PHASE"

  # Check if input file exists
  if [ ! -e "$input_file" ]; then
    echo "Input file $input_file not found. Exiting."
    return 1
  fi

  # Process each input section delimited by '---'
  input_section=""
  while IFS= read -r line; do
    # Check for '---' as delimiter
    if [ "$line" = "---" ]; then
      if [ -n "$input_section" ]; then
        # Run compiled C++ program with the current input section
        echo "$input_section" | "./$1" >> "$output_file"
        echo "---" >> "$output_file"
        input_section=""
      fi
    else
      input_section+="$line"$'\n'
    fi
  done < "$input_file"

  # Progress bar for completion
  PARAM_PHASE="Running Tests"
  progress 100 "$PARAM_PHASE"

  # Display completion message
  echo "Testing completed. Output written to $output_file"
}

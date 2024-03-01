cprun () {
  #Check no. of args is one
  if [ $# -ne 1 ]; then
    echo "Usage : cprun <filename>"
    return 1
  fi
  #create variables
  local input_file="$1.in"
  local output_file="$1.out"
  #clear output file
  rm -f "$output_file"
  #compile C++ file
  g++-13 "$1.cpp" -o "$1"
  #check if compilation was successful
  if [ $? -ne 0 ]; then
    echo "Compilation failed. Exiting."
    return 1
  fi
  #check input file exists
  if [ ! -e "$input_file" ]; then
    echo "Input file $input_file not found. Exiting. "
    return 1
  fi
  #Process each input section delimted by '---'
  input_section = ""
  while IFS= read -r line; do
    #Check for '---' as delimiter
    if [ "$line" = "---"]; then
      if [ -n "$input_selection"]; then
        #Run compiled C++ program, with current input selection
        echo "$input_seleciton" | "./$1" >> "$output_file"
        echo "---" >> "$output_file"
        input_selection = ""
      fi
    else
      input_selection+="$line"$'\n'
    fi
  done < "$input_file"
}

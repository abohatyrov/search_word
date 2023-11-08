#!/bin/bash

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Error! Check your parameters."
    echo "Usage: $0 <search word> <input file> [sleep interval in seconds]"
    exit 1
fi

search_word="$1"
input_file="$2"
log_dir="logs"
sleep_interval=${3:-900}


if [ ! -r "$input_file" ]; then
    echo "Error: Input file '$input_file' not found or unreadable."
    exit 1
fi

if [ ! -d "$log_dir" ]; then
    mkdir "$log_dir"
fi

while true; do
    current_time=$(date +"%Y-%m-%d %H:%M:%S")
    log_file="$log_dir/search_log_$(date +"%Y-%m-%d%H:%M:%S").txt"
    
    results=$(grep -n -o -i "$search_word" "$input_file")
    
    echo "Search for '$search_word' at $current_time" | tee -a "$log_file"
    echo "Input File: $input_file" | tee -a "$log_file"
    echo "-------------------------------------------------" | tee -a "$log_file"

    if [ -n "$results" ]; then
        echo "Occurrences found:" | tee -a "$log_file"
        while read -r result; do
            line_number=$(echo "$result" | cut -d: -f1)
            value=$(echo "$result" | cut -d: -f2)
            echo "$line_number: $value" | tee -a "$log_file"
        done <<< "$results"
    else
        echo "No occurrences found." | tee -a "$log_file"
    fi

    echo "-------------------------------------------------" | tee -a "$log_file"
    
    
done


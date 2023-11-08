# Automated Search of Words in Files

## Introduction
This is a BASH script which is designed to perform automated serches of specific word in a given text file and log the line numbers where the word is found, along with a timestamp. It runs continuously at intervals of 15 minutes (900 seconds) by default.

## Usage
The script requires a minimum of two and a maximum of three parameters:
- <search word>: The word you want to search for.
- <input file>: The file in which the search will be performed.
- [sleep interval in seconds] (optional): The time interval (in seconds) between search cycles. The default interval is 900 seconds (15 minutes).
```
Usage: ./script.sh <search word> <input file> [sleep interval in seconds]
```
_Note: If you don't provide exactly two parameters, the script displays an error message and exits._
```bash
./script.sh "search_word" "input.txt"  # Default sleep interval of 15 minutes
./script.sh "search_word" "input.txt" 600  # Custom sleep interval of 10 minutes
./script.sh "search_word" "input.txt" 1800  # Custom sleep interval of 30 minutes
```

## File structure
#### 1. Shebang Line:
  - The script starts with `#!/bin/bash`, indicating that it should be executed using the Bash interpreter.
#### 2. Parameter Validation and Variable Assignment
  - The script checks the number of parameters provided and assigns them to variables.
  - It sets default values for variables, such as the sleep interval.
  - It handles parameter validation and provides an error message for incorrect usage.
  - ```bash
    if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Error! Check your parameters."
    echo "Usage: $0 <search word> <input file> [sleep interval in seconds]"
    exit 1
    fi
    
    search_word="$1"
    input_file="$2"
    log_dir="logs"
    sleep_interval=${3:-900}
    ```
#### 3. Error Handling for Input File:
  - The script checks if the input file exists and is readable. If not, it displays an error message and exits.
  - ```bash
    if [ ! -r "$input_file" ]; then
    echo "Error: Input file '$input_file' not found or unreadable."
    exit 1
    fi
    ```
#### 4. Log Directory Setup:
  - The script checks if the log directory exists. If not, it creates the directory to store log files.
  - ```bash
    if [ ! -d "$log_dir" ]; then
        mkdir "$log_dir"
    fi
    ```
#### 5. Main Loop for Continuous Searching and Logging:
  - The primary part of the script is a continuous loop that performs the following steps:
    - Get the current timestamp.
    - ```
      current_time=$(date +"%Y-%m-%d %H:%M:%S")
      ```
    - Create a unique log file name based on the timestamp.
    - ```bash
      log_file="$log_dir/search_log_$(date +"%Y-%m-%d%H:%M:%S").txt"
      ```
    - Search for the specified word in the input file and store the results.
    - ```bash
      results=$(grep -n -o -i "$search_word" "$input_file")
      ```
    - Logs search results, including the timestamp, input file, matched word, and line number to the log files.
    - ```bash
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
      ```
    - Sleep for the specified or default interval to repeat the process.
    - ```bash
      sleep "$sleep_interval"
      ```

# Automated Search of Words in Files

## Introduction
This is a BASH script which is designed to perform automated serches of specific word in a given text file and log the line numbers where the word is found, along with a timestamp. It runs continuously at intervals of 15 minutes (900 seconds) by default.

## Usage
To use this script follow the instructions below:

### Step 1: Insert Parameters
The script requires three parameters: the search word, the input file to search in, and the output file for logging.

ʼʼʼ
./script.sh <search word> <input file> <output file>
ʼʼʼ
__Note: If you don't provide exactly three parameters, the script displays an error message and exits.__



# Automated Search of Words in Files

## Introduction
This is a BASH script which is designed to perform automated serches of specific word in a given text file and log the line numbers where the word is found, along with a timestamp. It runs continuously at intervals of 15 minutes (900 seconds) by default.

## Usage
The script requires three parameters: the search word, the input file to search in, and the output file for logging.

```
./script.sh <search word> <input file> <output file>
```
_Note: If you don't provide exactly three parameters, the script displays an error message and exits._

## File structure

#!/bin/bash

# Configuration
SEQ_FILES_DIR="/home/ec2-user/seq_files" 
HISTORY_DIR="/home/ec2-user/HIST_DIR"     
ARCHIVE_DIR="/home/ec2-user/ARCHIVE_DIR"    
REPORT_FILE="archive_report_$(date +%Y%m%d_%H%M%S).log"

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

echo "Archive Report - $(date)" > "$REPORT_FILE"
echo "-------------------------------------" >> "$REPORT_FILE"

# Function to process a directory
process_directory() {
    local dir_path="$1"
    local dir_name=$(basename "$dir_path")
    local old_files_count=0

    echo "" >> "$REPORT_FILE"
    echo "Processing directory: $dir_name" >> "$REPORT_FILE"
    echo "-------------------------------------" >> "$REPORT_FILE"

    # Find files older than 3 months (90 days)
    find "$dir_path" -type f -mtime +90 -print0 | while IFS= read -r -d $'\0' file; do
        echo "Found old file: $file" >> "$REPORT_FILE"
        ((old_files_count++))
        # Archive the file
        mv "$file" "$ARCHIVE_DIR/"
        echo "Archived: $file to $ARCHIVE_DIR" >> "$REPORT_FILE"
    done

    echo "Total $dir_name files older than 3 months: $old_files_count" >> "$REPORT_FILE"
}

# Process SEQ_FILES_DIR
process_directory "$SEQ_FILES_DIR"

# Process HISTORY_DIR
process_directory "$HISTORY_DIR"

echo "" >> "$REPORT_FILE"
echo "Archiving process completed. Report saved to $REPORT_FILE" >> "$REPORT_FILE"

echo "Script execution complete. Check $REPORT_FILE for details."
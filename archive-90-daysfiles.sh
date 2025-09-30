#!/bin/bash

# Configuration
SOURCE_DIRS=("/path/to/SEQ_FILES" "/path/to/history")  # Directories to check
ARCHIVE_DIR="/path/to/archive"                         # Directory to store archived files
REPORT_FILE="archive_report_$(date +%Y%m%d_%H%M%S).log" # Log file with timestamp

# Ensure the archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Initialize the report file
echo "Archive Report - $(date)" > "$REPORT_FILE"
echo "-------------------------------------" >> "$REPORT_FILE"

# Function to process each directory
process_directory() {
    local dir_path="$1"
    local dir_name=$(basename "$dir_path")
    local old_files_count=0

    echo "" >> "$REPORT_FILE"
    echo "Processing directory: $dir_name" >> "$REPORT_FILE"
    echo "-------------------------------------" >> "$REPORT_FILE"

    # Find files older than 3 months (90 days)
    find "$dir_path" -type f -mtime +90 -print0 | while IFS= read -r -d $'\0' file; do
        # Compute relative path
        rel_path="${file#$dir_path/}"
        archive_path="$ARCHIVE_DIR/$rel_path"

        # Create the destination directory if it doesn't exist
        mkdir -p "$(dirname "$archive_path")"

        # Move the file to the archive
        if mv "$file" "$archive_path"; then
            echo "Archived: $file to $archive_path" >> "$REPORT_FILE"
            ((old_files_count++))
        else
            echo "Failed to archive: $file" >> "$REPORT_FILE"
        fi
    done

    echo "Total files older than 3 months in $dir_name: $old_files_count" >> "$REPORT_FILE"
}

# Process each source directory
for dir in "${SOURCE_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        process_directory "$dir"
    else
        echo "Directory $dir does not exist or is not accessible." >> "$REPORT_FILE"
    fi
done

# Final message
echo "" >> "$REPORT_FILE"
echo "Archiving process completed. Report saved to $REPORT_FILE" >> "$REPORT_FILE"
echo "Script execution complete. Check $REPORT_FILE for details."

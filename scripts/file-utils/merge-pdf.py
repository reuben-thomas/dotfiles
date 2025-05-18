import os
from PyPDF2 import PdfMerger
import re

def natural_sort_key(s):
    # Define a natural sort key function
    return [int(text) if text.isdigit() else text.lower() for text in re.split(r'(\d+)', s)]

def combine_pdfs_with_sections(target_dir, output_file):
    # Initialize a PdfMerger object
    merger = PdfMerger()

    # Get a sorted list of all PDF files in the directory using natural sorting
    pdf_files = sorted(
        [file for file in os.listdir(target_dir) if file.endswith('.pdf')],
        key=natural_sort_key
    )

    if not pdf_files:
        print("No PDF files found in the specified directory.")
        return

    print("Found the following PDF files:")
    for pdf in pdf_files:
        print(f" - {pdf}")

    # Add each PDF file to the merger with a bookmark
    for pdf in pdf_files:
        file_path = os.path.join(target_dir, pdf)
        # Use the filename (without extension) as the bookmark title
        bookmark_title = os.path.splitext(pdf)[0]
        merger.append(file_path, outline_item=bookmark_title)

    # Write out the combined PDF to the output file
    merger.write(output_file)
    merger.close()

    print(f"All PDFs combined into {output_file} with sections based on filenames.")

# Example usage
if __name__ == "__main__":
    target_directory = input("Enter the directory containing PDF files: ")
    output_filename = input("Enter the output filename (e.g., combined_with_sections.pdf): ")

    combine_pdfs_with_sections(target_directory, output_filename)

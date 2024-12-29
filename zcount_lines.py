import os

# List of files and directories to ignore
ignore_list = ['venv', '.git']

def should_ignore(path):
    for ignore in ignore_list:
        if ignore in path:
            return True
    return False

def count_lines_in_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
            return sum(1 for _ in file)
    except (FileNotFoundError, IsADirectoryError, UnicodeDecodeError):
        return 0

def count_lines_in_directory(directory):
    total_lines = 0
    for root, _, files in os.walk(directory):
        if should_ignore(root):
            continue
        for file in files:
            file_path = os.path.join(root, file)
            if should_ignore(file_path):
                continue
            total_lines += count_lines_in_file(file_path)
    return total_lines

workspace_directory = '.'  # Change this to your workspace directory if needed
total_lines = count_lines_in_directory(workspace_directory)
print(f'Total number of lines in the workspace: {total_lines}')
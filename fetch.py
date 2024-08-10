import os
import shutil
import toml


def main():
    current_path = os.path.abspath("")

    config_path = "./config.toml"
    config = toml.load(os.path.join(current_path, config_path))

    for folder, file_paths in config.items():
        fetched_files = 0
        shutil.rmtree(os.path.join(current_path, folder), ignore_errors=True)

        if len(file_paths) == 1 and os.path.isdir(os.path.expanduser(file_paths[0])):
            # If single directory, copy contents
            shutil.copytree(os.path.expanduser(file_paths[0]), os.path.join(current_path, folder))
            fetched_files += 1
        else:
            # If multiple, copy each file / directory
            os.makedirs(os.path.join(current_path, folder), exist_ok=True)
            for file_path in file_paths:
                if os.path.isfile(os.path.expanduser(file_path)):
                    shutil.copyfile(os.path.expanduser(file_path), os.path.join(current_path, folder, os.path.basename(file_path)))
                elif os.path.isdir(os.path.expanduser(file_path)):
                    dir_name = os.path.basename(os.path.normpath(os.path.expanduser(file_path)))
                    shutil.copytree(os.path.expanduser(file_path), os.path.join(current_path, folder, dir_name))
                else:
                    continue

                fetched_files += 1

        print(folder, ":", fetched_files, "/", len(file_paths))

if __name__ == "__main__":
    main()
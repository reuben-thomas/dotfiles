import os
import yaml

relative_path = os.path.join("..", "config.yml")
full_path = os.path.abspath(relative_path)

with open(full_path, "r") as file:
    data = yaml.safe_load(file)

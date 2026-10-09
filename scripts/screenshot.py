#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["requests", "secretstorage"]
# ///

import subprocess
import os
from datetime import datetime
import requests
import secretstorage


def get_secret(name):
    conn = secretstorage.dbus_init()
    collection = secretstorage.get_default_collection(conn)
    if collection.is_locked():
        collection.unlock()
    for item in collection.get_all_items():
        if item.get_label() == name:
            return item.get_secret().decode().strip()
    raise KeyError(name)


TELEGRAM_BOT_TOKEN = get_secret("ss_bot_token")
TELEGRAM_CHAT_ID = get_secret("ss_bot_id")

screenshot_dir = os.path.expanduser("~/Pictures/Telegram")
os.makedirs(screenshot_dir, exist_ok=True)

timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
screenshot_path = os.path.join(screenshot_dir, f"screenshot_{timestamp}.png")
subprocess.run(["grim", screenshot_path], check=True)

url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendDocument"
with open(screenshot_path, "rb") as document:
    requests.post(url, data={"chat_id": TELEGRAM_CHAT_ID}, files={"document": document})

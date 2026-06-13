#!/home/reuben/.venv/base/bin/python3
import subprocess
import os
from datetime import datetime
import requests

TELEGRAM_BOT_TOKEN = "7839235687:AAEYrUEHsLj0i4IFY3HTlJBHgLCOrZLuVbA"
TELEGRAM_CHAT_ID = "647549577"

screenshot_dir = os.path.expanduser("~/Pictures/Telegram")
os.makedirs(screenshot_dir, exist_ok=True)

timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
screenshot_path = os.path.join(screenshot_dir, f"screenshot_{timestamp}.png")
subprocess.run(["grim", screenshot_path], check=True)

url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendDocument"
with open(screenshot_path, "rb") as document:
    requests.post(url, data={"chat_id": TELEGRAM_CHAT_ID}, files={"document": document})

print(f"Screenshot saved and sent: {screenshot_path}")

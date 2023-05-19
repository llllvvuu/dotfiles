#!/usr/bin/env python3

import os
import sys
import time
from datetime import datetime
import subprocess

def screenshot_every_minute(save_directory):
    while True:
        date = datetime.now().strftime("%Y-%m-%d")
        date_directory = os.path.join(save_directory, date)
        os.makedirs(date_directory, exist_ok=True)

        timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        screenshot_file = os.path.join(date_directory, f"{timestamp}.png")

        subprocess.run(["screencapture", "-x", screenshot_file])

        time.sleep(60)

if __name__ == "__main__":
    save_directory = sys.argv[1]
    screenshot_every_minute(save_directory)

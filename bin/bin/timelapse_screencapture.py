#!/usr/bin/env python3

import os
import time
from datetime import datetime
import argparse
from mss import mss

def screenshot_every_minute(save_directory):
    with mss() as sct:
        while True:
            date = datetime.now().strftime("%Y-%m-%d")
            date_directory = os.path.join(save_directory, date)
            os.makedirs(date_directory, exist_ok=True)

            timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
            screenshot_file = os.path.join(date_directory, f"{timestamp}.png")

            sct.shot(mon=-1, output=screenshot_file)

            time.sleep(60)

def main():
    parser = argparse.ArgumentParser(
        description=('A cross-platform script to capture screenshots every '
                     'minute. Each screenshot is saved in a subdirectory '
                     'named by the current date, and the screenshot file is '
                     'named by the current timestamp.')
    )
    parser.add_argument('save_directory', type=str, 
                        help='The directory where screenshots will be saved.')

    args = parser.parse_args()

    screenshot_every_minute(args.save_directory)

if __name__ == "__main__":
    main()

#!/usr/bin/env python3

import os
import sys
import cv2
import imageio
from glob import glob

def create_gif_or_video(input_directory, output_type="gif"):
    images = sorted(glob(os.path.join(input_directory, "*.png")))

    if output_type == "gif":
        gif_output_file = os.path.join(input_directory, "output.gif")
        with imageio.get_writer(gif_output_file, mode="I") as writer:
            for image_file in images:
                image = imageio.imread(image_file)
                writer.append_data(image)
    elif output_type == "video":
        video_output_file = os.path.join(input_directory, "output.mp4")
        img = cv2.imread(images[0])
        height, width, _ = img.shape
        video_writer = cv2.VideoWriter(video_output_file, cv2.VideoWriter_fourcc(*"avc1"), 4, (width, height))

        for image_file in images:
            img = cv2.imread(image_file)
            video_writer.write(img)

        video_writer.release()
    else:
        print("Invalid output_type. Choose 'gif' or 'video'.")

if __name__ == "__main__":
    input_directory = sys.argv[1]  # Replace with your desired input directory, e.g. "X/2023-04-11"
    output_type = "video"  # Change to "video" if you prefer a video output
    create_gif_or_video(input_directory, output_type)

#!/usr/bin/env python3

import os
import argparse
import cv2
import imageio
from glob import glob


def create_timelapse_video(input_directory, output_file):
    images = sorted(glob(os.path.join(input_directory, "*.png")))

    img = cv2.imread(images[0])
    height, width, _ = img.shape
    video_writer = cv2.VideoWriter(
        output_file,
        cv2.VideoWriter_fourcc(*"avc1"),
        4,
        (width, height),
    )

    for image_file in images:
        img = cv2.imread(image_file)
        img = cv2.resize(img, (width, height))
        video_writer.write(img)

    video_writer.release()


def main():
    parser = argparse.ArgumentParser(
        description='Create a video from a directory of PNG images.'
    )
    parser.add_argument('input_directory', type=str,
                        help='The directory containing the PNG images.')
    parser.add_argument('-o', '--output', type=str,
                        default=None,
                        help=('The desired output file for the video. If not specified, '
                              'the output file will be named "timelapse.mp4" and placed '
                              'in the input directory.'))

    args = parser.parse_args()

    if args.output is None:
        args.output = os.path.join(args.input_directory, "timelapse.mp4")

    create_timelapse_video(args.input_directory, args.output)


if __name__ == "__main__":
    main()

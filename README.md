# Season Rip Meta

This script is an enhancement software for DVD rips of series.
The primary goals are:

1. to speed up the process
1. to avoide mistakes
1. optimize the video files for SAMSUNG SmartTVs

## Usage

1. rip your series onto your disk and use episode numbers as names for the video files
1. create a CSV file with relevant episode titles, see [titles.csv](examples/titles.csv) for an example
1. run the script

The script will create new video files, with episode titles in their name, which are optimized for SAMSUNG SmartTVs.

## SAMSUNG SmartTV Optimization

My current SAMSUNG SmartTV has a huge disadvantage when playing video files from network devices:
It automatically uses the first subtitle stream.
If your rip covers subtitles, e.g. for a second language stream, it will be displayed regardless of the language you're listening in.
While you can disable subtitles, the TV re-enables them when playing the next video file.

This problem is known and there will be no firmware updates provided which would solve this issue.

As a solution, this script injects another subtitle stream.
This stream displays the episode title at the start of the video and remains silent hereafter.

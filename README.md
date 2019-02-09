# Season Rip Meta

This script is an enhancement software for DVD rips of series.
The primary goals are:

* to speed up the process
* to avoide mistakes
* optimize the video files for SAMSUNG SmartTVs

## Usage

1. rip your series onto your disk and use episode numbers as names for the video files
1. create a CSV file with relevant episode titles, see [titles.csv](examples/titles.csv) for an example
1. run the script, on Windows e.g. via *Git for Windows*:

       "<PathToGitForWindows>\git-bash.exe" "<PathToScript>" NUMBER_OF_DIGITS FIRST_EPISODE_NUMBER

The script will create new video files.
While these files will be named after the episode title valid NTFS filenames will be produced.

### Parameters

In this context, `NUMBER_OF_DIGITS` is the number of digits (e.g. `2`) used when formatting the filenames (e.g. `01 - Flug 627`) of generated video files.
This is to ensure a correct ordering of the episodes according to the episode number by filename.

`FIRST_EPISODE_NUMBER` is the number of the first episode that should be processed.
While it could be extraced from the CSV file, it oddly doesn't work for me when running on Windows.
This is a rather dirty but quick for this annoying issue.

## SAMSUNG SmartTV Optimization

My current SAMSUNG SmartTV has a huge disadvantage when playing video files from network devices:
It automatically uses the first subtitle stream.
If your rip covers subtitles, e.g. for a second language stream, it will be displayed regardless of the language you're listening in.
While you can disable subtitles, the TV re-enables them when playing the next video file.

This problem is known and there will be no firmware updates provided which would solve this issue.

As a solution, this script injects another subtitle stream.
This stream displays the episode title at the start of the video and remains silent hereafter.

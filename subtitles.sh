#!/bin/bash

# path to the portable MKV toolnix folder
# THIS PATH HAS TO BE SET ONLY WHEN RUNNING THE SCRIPT ON WINDOWS, CLEAR OUT OTHERWISE
PATH_MKVTN='/g/rip/mkvtoolnix-64-bit-30.1.0'

# parameters
FIRST_EP="$2"
NUM_LEADING_ZEROS="$1"

# defaults
CMD_MKVINFO=mkvinfo
CMD_MKVMERGE=mkvmerge
FIRST=true

# set command paths when on Windows
if [ -n "$PATH_MKVTN" ]; then
  CMD_MKVINFO="$PATH_MKVTN"/mkvinfo.exe
  CMD_MKVMERGE="$PATH_MKVTN"/mkvmerge.exe
fi

# remove existing subtitle files
if ls -U *.srt 2>/dev/null 1>&2; then
  rm *.srt
fi

while IFS=';' read -r ID TITLE
do
  if $FIRST; then
    FIRST=false
	ID="$FIRST_EP"
  fi
  
  IDF=$(printf "%0${NUM_LEADING_ZEROS}d" "$ID")
  FSOURCE="$ID.mkv"
  FSUB="$ID.srt"
  FULLTITLE="$IDF"' - '"$TITLE"
  # remove question marks and replace other NTFS-invalid filename characters
  FTARGET=${FULLTITLE//[?]/}
  FTARGET="${FTARGET//[^0-9A-Za-zäöüÄÖÜß._\-,! ]/_}.mkv"
  
  # check if processing is necessary and possible
  if [ -f "$FTARGET" ]; then
    echo "[INFO] Skipping existing file '$FTARGET'"
	continue
  fi
  if [ ! -f "$FSOURCE" ]; then
    echo "[WARN] Skipping missing source file '$FSOURCE'"
  fi
  echo "[INFO] Processing '$TITLE' (#$ID) into '$FTARGET'"
  
  # generate subtitle file
  echo '1' > "$FSUB"
  echo '00:00:00,000 --> 00:00:05,000' >> "$FSUB"
  echo "$ID - $TITLE" >> "$FSUB"

  # merge subtitle file into video file
  "$CMD_MKVINFO" "$FSOURCE" > /dev/null
  if [ "$?" -eq "0" ]; then
	"$CMD_MKVMERGE" -o "$FTARGET" --default-track 0 --track-name "0:Titel" "$FSUB" "$FSOURCE"
	if [ "$?" -eq "0" ]; then
	  # clean up
      rm "$FSUB"
	fi
  fi
done < "titles.csv"

read -n 1 -s -r -p "Done. Press any key to continue"

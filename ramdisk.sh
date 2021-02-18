#!/bin/sh

if [ -z $RAM_DRIVE_SIZE ]; then
  RAM_DRIVE_SIZE=4
fi
if [ -z $RAM_DRIVE_LABEL ]; then
  RAM_DRIVE_LABEL='RAM Disk'
fi

while getopts ":s:l:h" optname
  do
    case "$optname" in
      "s")
	RAM_DRIVE_SIZE=$OPTARG
        ;;
      "l")
	RAM_DRIVE_LABEL=$OPTARG
        ;;
      "h")
	echo "Mac OS ramdrive creater (c--) 2021 br0k3ncircuit\n"
        echo "usage: "$(basename $0)" -s SIZE_IN_GB -l DRIVE_LABEL\n"
        echo "parameters are optional\ndefault values are\nsize....: "$RAM_DRIVE_SIZE" gb\nlabel...: '"$RAM_DRIVE_LABEL"'\nif label contains spaces enclose it in ''\n"
	echo "use the environment variables RAM_DRIVE_SIZE and RAM_DRIVE_LABEL to change default values"
	exit
	;;
      "?")
        echo "unknown option $OPTARG"
        ;;
      ":")
        echo "no argument value for option $OPTARG"
        ;;
      *)
	echo "try -h"
        ;;
    esac
  done

DRIVESIZE=$[$RAM_DRIVE_SIZE*1024*2048]

echo 'making a '$DRIVESIZE' bytes ('$RAM_DRIVE_SIZE gb') ramdrive labeled '$RAM_DRIVE_LABEL

diskutil erasevolume HFS+ "$RAM_DRIVE_LABEL" `hdiutil attach -nomount ram://$DRIVESIZE`

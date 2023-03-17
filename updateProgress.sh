#!/bin/sh

# If you want to run this as a cron job, on OSX you need to add the following to your PATH
# Not on OSX, you'll need to find the corresponding directories
# export PATH=/usr/local/bin:/Library/TeX/texbin/:$PATH

echo "Updating progress"
TEX_DOC='/home/runner/work/phd-thesis/phd-thesis/main.tex'
DOCUMENT='/home/runner/work/phd-thesis/main.pdf'
DIR='/home/runner/work/phd-thesis/phd-thesis/'

# Setup CSV if it doesn't exist
if [ ! -f ${PROGRESSFILE} ]; then
    echo "timestamp,wordcount,pagecount" >> ${PROGRESSFILE}
fi

WORDCOUNT=`texcount -sum -total -inc ${TEX_DOC}  -dir ${DIR} | grep "Sum count:" | tr -d "Sum count::"`
PAGECOUNT=`pdfinfo ${DOCUMENT} | grep Pages | tr -d "Pages: "`

echo `date '+%Y-%m-%d %H:%M:%S'`,$WORDCOUNT,$PAGECOUNT >> $PROGRESSFILE
echo "Done! Page count ${PAGECOUNT}, word count ${WORDCOUNT}. Written to ${PROGRESSFILE}"

python plotProgress.py ${PROGRESSFILE}

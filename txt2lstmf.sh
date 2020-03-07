#!/bin/bash
# SINGLE line images using text2image -

lang=xsa
unicodefontdir=/home/ubuntu/.fonts 
prefix=gt/$lang
mkdir -p gt
rm -rf ${prefix} 
mkdir  ${prefix} 
traininginput=langdata/$lang.txt
fontlist=langdata/$lang.fontslist.txt
fontcount=$(wc -l < "$fontlist")
linecount=$(wc -l < "$traininginput")
numlines=1
numfiles=$(( linecount / numlines))
# files created by script during processing
fonttext=/tmp/$lang-file-train.txt
linetext=/tmp/$lang-line-train.txt
 
 while IFS= read -r fontname
     do
        cp ${traininginput} ${fonttext}
        sed -i  "1,$linecount d"  ${trainingtext}
        for cnt in $(seq 1 $numfiles) ; do
            head -$numlines ${fonttext} > ${linetext}
             sed -i  "1,$numlines  d"  ${fonttext}
            OMP_THREAD_LIMIT=1 text2image --fonts_dir="$unicodefontdir" --text="${linetext}" --strip_unrenderable_words=false --xsize=2500 --ysize=300  --leading=32 --margin=12   --font="$fontname"   --outputbase="$prefix"/"${fontname// /_}.$cnt" 
            cp "$linetext" "$prefix"/"${fontname// /_}.$cnt".gt.txt
            OMP_THREAD_LIMIT=1  tesseract "$prefix"/"${fontname// /_}.$cnt".tif "$prefix"/"${fontname// /_}.$cnt" -l ara --psm 13 --dpi 300 lstm.train  
         done
        ls -1  $prefix/*${fontname// /_}.*.lstmf > data/all-${fontname// /_}-$lang-lstmf
        echo "Done with ${fontname// /_}"
     done < "$fontlist"
echo "All Done"



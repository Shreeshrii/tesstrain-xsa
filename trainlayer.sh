#!/bin/bash

export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
MODEL=xsa

mkdir -p data  data/ara
cd data/ara
wget -O ara.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/ara.traineddata
combine_tessdata -u ara.traineddata $MODEL.
cd $SCRIPTPATH

rm -rf data/$MODEL
mkdir data/$MODEL

cd data/$MODEL
wget -O $MODEL.config https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.config
wget -O $MODEL.numbers https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.numbers
wget -O $MODEL.punc https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.punc

Version_Str="$MODEL:shreeshrii`date +%Y%m%d`:from:"
sed -e "s/^/$Version_Str/" $SCRIPTPATH/data/ara/$MODEL.version > $MODEL.version

ls -1  $SCRIPTPATH/gt/$MODEL/*.lstmf >  /tmp/all-$MODEL-lstmf
python3 $SCRIPTPATH/shuffle.py 1 < /tmp/all-$MODEL-lstmf > all-lstmf
cat $SCRIPTPATH/langdata/$MODEL.txt > all-gt 

cd ../..

nohup make  training  \
MODEL_NAME=$MODEL  \
LANG_TYPE=RTL \
BUILD_TYPE=Layer  \
TESSDATA=/home/ubuntu/tessdata_best \
GROUND_TRUTH_DIR=$SCRIPTPATH/gt \
START_MODEL=ara \
LAYER_NET_SPEC="[Lfx128 O1c1]" \
LAYER_APPEND_INDEX=5 \
RATIO_TRAIN=0.95 \
DEBUG_INTERVAL=-1 \
MAX_ITERATIONS=25000 > $MODEL.log & 

#!/bin/bash
# nohup bash trainlayer.sh > trainlayer-xsa.log & 
export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
MODEL=xsa
STARTMODEL=xsa3
BUILDTYPE=Layer

mkdir -p data  data/$STARTMODEL
cp $SCRIPTPATH/best_$STARTMODEL.traineddata data/
cd data/$STARTMODEL
combine_tessdata -u $SCRIPTPATH/best_$STARTMODEL.traineddata $MODEL.
cd $SCRIPTPATH

rm -rf data/$MODEL
mkdir data/$MODEL

cd data/$MODEL
wget -O $MODEL.config https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.config
wget -O $MODEL.numbers https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.numbers
wget -O $MODEL.punc https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.punc

Version_Str="$MODEL:shreeshrii`date +%Y%m%d`:from:"
sed -e "s/^/$Version_Str/" $SCRIPTPATH/data/$STARTMODEL/$MODEL.version > $MODEL.version

cat $SCRIPTPATH/data/*$MODEL-lstmf >   /tmp/all-$MODEL-lstmf
cat $SCRIPTPATH/data/*nospace-lstmf >>   /tmp/all-$MODEL-lstmf
python3 $SCRIPTPATH/shuffle.py 1 < /tmp/all-$MODEL-lstmf > all-lstmf
cat $SCRIPTPATH/langdata/$MODEL.training_text > all-gt 

cd ../..

nohup make  training  \
MODEL_NAME=$MODEL  \
LANG_TYPE=RTL \
BUILD_TYPE=$BUILDTYPE  \
TESSDATA=data \
GROUND_TRUTH_DIR=$SCRIPTPATH/gt \
START_MODEL=$STARTMODEL \
LAYER_NET_SPEC="[Lfx 96 O1c1]" \
LAYER_APPEND_INDEX=5 \
RATIO_TRAIN=0.80 \
DEBUG_INTERVAL=-1 \
MAX_ITERATIONS=500000 > trainlayer-$MODEL.log & 

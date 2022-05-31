#!/bin/bash - 
#===============================================================================
#
#          FILE: run_large.sh
# 
#         USAGE: ./run_large.sh
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Xuanli He, 
#  ORGANIZATION: 
#       CREATED: 06/09/2020 14:01
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

CORPUS=$1
LR=$2
TRAIN_FILE=$5
VALID_FILE=$6

if [ $CORPUS = "SST-2" ]
then
    SAVE=100
    #SAVE=2000
    BATCH=$3
    ACCUMU=$4
    EPOCH=5
elif [ $CORPUS = "RTE" ]
then
    SAVE=10
    BATCH=$3
    ACCUMU=$4
    EPOCH=30
elif [ $CORPUS = "drug" ]
then
    SAVE=15
    BATCH=$3
    ACCUMU=$4
    EPOCH=30
elif [ $CORPUS = "MRPC" ]
then
    SAVE=15
    BATCH=$3
    ACCUMU=$4
    EPOCH=30
elif [ $CORPUS = "CoLA" ]
then
    SAVE=30
    BATCH=$3
    ACCUMU=$4
    EPOCH=20
elif [ $CORPUS = "STS-B" ]
then
    SAVE=20
    BATCH=$3
    ACCUMU=$4
    EPOCH=25
elif [ $CORPUS = "QNLI" ]
then
    SAVE=150
    #SAVE=12000
    BATCH=$3
    ACCUMU=$4
    EPOCH=5
elif [ $CORPUS = "MNLI" ]
then
    SAVE=500
    BATCH=$3
    ACCUMU=$4
    EPOCH=10
else
    SAVE=1000
    BATCH=$3
    ACCUMU=$4
    EPOCH=20
fi

FULL_BATCH=$(( BATCH*ACCUMU ))

echo $FULL_BATCH
OUTPUT_DIR=ckpt/$CORPUS/large_drop0.3_${LR}_${FULL_BATCH}
LOGDIR=log/$CORPUS/large_drop0.3_${LR}_${FULL_BATCH}

if [ ! -d $LOGDIR ];then
    mkdir -p $LOGDIR
fi

log=$LOGDIR/log.txt

echo $CORPUS

python run_language_modeling.py \
    --output_dir=$OUTPUT_DIR \
    --overwrite_output_dir \
    --model_type=gpt2-large \
    --model_name_or_path=gpt2-large \
    --do_train \
    --save_steps $SAVE \
    --logging_steps $SAVE \
    --warmup_steps 0 \
    --eval_steps $SAVE \
    --save_total_limit 1 \
    --gradient_accumulation_steps $ACCUMU \
    --train_data_file=$TRAIN_FILE \
    --do_eval \
    --eval_data_file=$VALID_FILE \
    --per_device_train_batch_size=$BATCH \
    --per_device_eval_batch_size=$BATCH \
    --line_by_line \
    --block_size 512 \
    --evaluate_during_training \
    --learning_rate $LR \
    --num_train_epochs=$EPOCH \
    --logging_dir "log" > $log 2>&1

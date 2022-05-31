#!/bin/bash - 
#===============================================================================
#
#          FILE: run_gal_single.sh
# 
#         USAGE: ./run_gal_single.sh
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

#set -o nounset                              # Treat unset variables as an error

export TASK_NAME=$1
SEED=$2

SIZE=1
MIX=$3
DUP=2
DATA=$4
if [ $MIX = "40x_20x" ]
then
    DUP=3
fi
PAD=False
MODEL=distilroberta-base

MNLI_CKPT="None"

if [ $TASK_NAME = "SST-2" ]
then
    echo "SST-2"
    SAVE=$((2104*DUP))
    BATCH=32
    MAX=128
    ACCUMU=1
    EPOCH=${SIZE}
    LR=2e-5
    METRIC="accuracy"
    TASK_NAME=sst2
elif [ $TASK_NAME = "QNLI" ]
then
    echo "QNLI"
    SAVE=$((3273*DUP))
    BATCH=32
    MAX=128
    ACCUMU=1
    EPOCH=5
    EPOCH=${SIZE}
    LR=2e-5
    METRIC="accuracy"
elif [ $TASK_NAME = "MNLI" ]
then
    echo "MNLI"
    SAVE=12271
    SAVE=$((12271*DUP))
    BATCH=32
    MAX=128
    ACCUMU=1
    EPOCH=5
    EPOCH=${SIZE}
    LR=2e-5
    METRIC="accuracy"
elif [ $TASK_NAME = "QQP" ]
then
    echo "QQP"
    SAVE=11370
    SAVE=$((11370*DUP))
    BATCH=32
    MAX=128
    ACCUMU=1
    EPOCH=5
    EPOCH=${SIZE}
    LR=2e-5
    METRIC="accuracy"
elif [ $TASK_NAME = "MRPC" ]
then
    echo "MRPC"
    SAVE=$((114*DUP))
    BATCH=32
    MAX=128
    ACCUMU=1
    EPOCH=5
    EPOCH=${SIZE}
    LR=2e-5
    METRIC="accuracy"
    MNLI_CKPT=$5
elif [ $TASK_NAME = "RTE" ]
then
    echo "RTE"
    SAVE=$((77*DUP))
    BATCH=16
    MAX=256
    ACCUMU=1
    EPOCH=5
    EPOCH=${SIZE}
    LR=2e-5
    METRIC="accuracy"
    MNLI_CKPT=$5
elif [ $TASK_NAME = "STS-B" ]
then
    echo "STS-B"
    SAVE=$((179*DUP))
    BATCH=16
    MAX=256
    ACCUMU=1
    EPOCH=5
    EPOCH=${SIZE}
    LR=2e-5
    TASK_NAME=stsb
    METRIC="combined_score"
    MNLI_CKPT=$5
else
    echo "CoLA"
    SAVE=$((267*DUP))
    BATCH=32
    MAX=128
    #WARMUP=200
    ACCUMU=1
    EPOCH=5
    EPOCH=${SIZE}
    LR=2e-5
    METRIC="matthews_correlation"
fi


OUTPUT_DIR=hf/ckpt/distilroberta_gal_${MIX}_single/${TASK_NAME}/seed$SEED
LOGDIR=hf/log/distilroberta_gal_${MIX}_single/${TASK_NAME}/seed$SEED


if [ $TASK_NAME = "MNLI" ]
then
    DEV=$DATA/dev_matched.json
    TEST=$DATA/test_matched.json
else
    DEV=$DATA/dev.json
    TEST=$DATA/test.json
fi

if [ ! -d $LOGDIR ];then
    mkdir -p $LOGDIR
fi

log=$LOGDIR/log.txt

python run_gal.py \
    --model_name_or_path $MODEL \
    --mnli_ckpt $MNLI_CKPT \
    --task_name $TASK_NAME \
    --evaluation_strategy "steps" \
    --save_total_limit 1 \
    --eval_steps $SAVE \
    --train_file $DATA/train.json \
    --validation_file $DEV \
    --test_file $TEST \
    --fp16 \
    --seed $SEED \
    --pad_to_max_length $PAD\
    --do_train \
    --do_eval \
    --do_predict \
    --load_best_model_at_end \
    --metric_for_best_model $METRIC \
    --max_seq_length $MAX \
    --per_device_train_batch_size $BATCH \
    --per_device_eval_batch_size $BATCH \
    --gradient_accumulation_steps $ACCUMU \
    --learning_rate $LR \
    --num_train_epochs $EPOCH \
    --output_dir $OUTPUT_DIR > $log 2>&1

#!/bin/bash

CORPUS=$1 # task: 
CKPT=$2 # dir to a fine-tuned GPT2

K=50
seed=$3
OUTPUT=YOUR_OUTPUT_DIR/${CORPUS}_s${seed}.txt
#OUTPUT=log/$1/gen/${MODEL}/${ATT}/${1}_s${i}.txt
#sleep $i
echo $CORPUS $i $4
time python run_generation.py \
    --model_type gpt2 \
    --model_name_or_path $CKPT \
    --stop_token "<EOS>" \
    --length 300 \
    --prompt "<BOS>" \
    --k $K \
    --seed $i \
    --num_return_sequences 50 > $OUTPUT

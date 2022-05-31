# Generate, Annotate, and Learn: NLP with Synthetic Text (Synthesizing Text part)

## Descriptions
This repo contains source code and pre-processed corpora for Generate, Annotate, and Learn: NLP with Synthetic Text (accepted to TACL2022) ([paper](https://arxiv.org/abs/2106.06168), [blog](https://synthetic-text.github.io/))


## Dependencies
* requirements.txt

## Preprocessed Data
The preprocessed data for in-domain fine-tuning can be found [here](https://drive.google.com/file/d/1V4sH14mWxTvAZD81YMt-B2DvY_AiS9DD/view?usp=sharing).
 
## Training
Here is an example showing how to fine-tune GPT2 on a particular task.
```
TASK= # CoLA, MNLI, MRPC, QNLI, QQP, RTE, SST-2, STS-B 
LR= # learning rate
BATCH= # mini-batch size
UPDATE_FREQ= # How many gradient steps do we need before updating model parameters.

sh run_large.sh $TASK $LR $BATCH $UPDATE_FREQ
```

## Generating Synthetic Data
Here is an example showing how to generate synthetic data from the fine-tuned GPT2.
```
TASK= # CoLA, MNLI, MRPC, QNLI, QQP, RTE, SST-2, STS-B 
CKPT= # dir to a fine-tuned GPT2
seed= # varying this var can generate distinct outputs
sh run_gen.sh $TASK $CKPT $seed
```

## Trained Models
We provide our best generation models for all tasks here

## Citation

Please cite as:

```bibtex
@article{DBLP:journals/corr/abs-2106-06168,
  author    = {Xuanli He and
               Islam Nassar and
               Jamie Kiros and
               Gholamreza Haffari and
               Mohammad Norouzi},
  title     = {Generate, Annotate, and Learn: NLP with Synthetic Text},
  journal   = {CoRR},
  volume    = {abs/2106.06168},
  year      = {2021},
  url       = {https://arxiv.org/abs/2106.06168},
  eprinttype = {arXiv},
  eprint    = {2106.06168},
  timestamp = {Tue, 15 Jun 2021 16:35:15 +0200},
  biburl    = {https://dblp.org/rec/journals/corr/abs-2106-06168.bib},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```

# Generate, Annotate, and Learn: NLP with Synthetic Text (Knowledge Distillation part)

## Descriptions
This repo contains source code and pre-processed corpora for Generate, Annotate, and Learn: NLP with Synthetic Text (accepted to TACL2022) ([paper](https://arxiv.org/abs/2106.06168), [blog](https://synthetic-text.github.io/))


## Dependencies
* requirements.txt

## Preprocessed Data
We provide the ground-truth data and two types of pseudo-labeled synthetic data [here](https://drive.google.com/file/d/1STm9GWyNUkWhQW-ONfCPadM_rElQ35u3/view?usp=sharing):

* KD data from a single teacher
* KD data from an ensemble teacher
 
## Training and inference
```
TASK= # CoLA, MNLI, MRPC, QNLI, QQP, RTE, SST-2, STS-B 
seed= # seed for replication
DATA= # path to kd data
MNLI_CKPT=None # dir to MNLI checkpoint. Using MNLI checkpoint can boost the performance of RTE, MPRC and STSB tasks. None by default

sh run_gal_single.sh $TASK $seed mix_40x $DATA $MNLI_CKPT
```

## Trained Models
We provide our best models for all tasks [here](https://drive.google.com/file/d/17dV0_NaAvgotIKMDPOR8ANmTjAIz1pYp/view?usp=sharing)

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

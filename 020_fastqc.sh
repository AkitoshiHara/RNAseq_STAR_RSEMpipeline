#!/bin/bash

## スクリプトを走らせる前にSRR_Acc_Listの位置を確認
mkdir fastqc
cat ■SRR_Acc_List.txt | while read ID;do
echo echo processing:${ID};
fastqc -t 12 --nogroup -o fastqc \
-f fastqc ${ID}_trim_pair_1.fastq.gz ${ID}_trim_pair_2.fastq.gz;
done;echo finished

# -o　出力ディレクトリを指定
# -f 入力データの形式
# -t CPUコア数指定
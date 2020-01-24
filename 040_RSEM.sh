#!/bin/bash

## RSEMを使用した発現量算出
## スクリプトを走らせる前にSRR_Acc_Listの位置■、RSEMレファレンスファイルの位置★を確認

mkdir rsem
cat ■SRR_Acc_List.txt | while read ID;do
echo echo processing:${ID};
rsem-calculate-expression --alignments --paired-end -p 12 \
--strandedness reverse --append-names --estimate-rspd \
${ID}/Aligned.toTranscriptome.out.bam [★] rsem/${ID};
done;echo finished

# --alignments 入力が生成済のマッピングデータ（SAM/BAM/CRAM形式のいずれか）のとき指定する
# --paired-end 入力データがペアエンドのときに指定
# --strandedness Illumina TruSeq Stranded RNAの場合はreverseを指定　デフォルトではnone
# --append-names　出力ファイルで遺伝子・転写産物の末尾に名前を追記する※重要！
# --estimate-rspd　転写産物のRSPD　リードの戦闘位置の分布を評価する場合に使用
# 最後の引数はSTARによるマッピングデータ（BAM)、RSEMリファレンスファイル、出力ディレクトリ／出力ファイル（拡張子を除いた名前）をそれぞれ指定する
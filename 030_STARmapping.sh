#!/bin/bash

## STARを使用したマッピング
## スクリプトを走らせる前にSRR_Acc_Listの位置、STARインデックスファイルの位置を確認

cat ■SRR_Acc_List.txt | while read ID;do
echo processing:${ID};
mkdir ${ID};
STAR --genomeDir [★] --runThreadN 12 \
--outFileNamePrefix ${ID}/ --quantMode TranscriptomeSAM \
--outSAMtype BAM SortedByCoordinate \
--readFilesIn ${ID}_trim_pair_1.fastq.gz ${ID}_trim_pair_2.fastq.gz \
--readFilesCommand gunzip -c;
done;echo finished

# --outFileNamePrefix 出力先のディレクトリを指定
# --quantMode TranscriptomeSAM でRSEM用のBAM形式データを生成することを指定
# --outSAMtype SortedByCoordinate 生成されるBAM形式データがゲノム座標順にソートされることを指定
# --readFilesCommand 入力データが圧縮ファイルの場合、解凍のために使用するコマンドを指定　ここではgunzip -c

#　生成されるファイル群
 # Aligned.sortedByCoord.out.bam IGVでの可視化に使用するソート済BAMファイル
 # Aligned.toTranscriptome.out.bam RSEMでの発現量算出に使用するBAMファイル
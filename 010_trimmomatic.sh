#!/bin/bash

## trimmomaticを使用したトリミング→結果の確認
## スクリプトを走らせる前にSRR_Acc_Listの位置を確認

cat ■SRR_Acc_List.txt | while read ID;do
echo processing:${ID};
trimmomatic PE -thread 12 -phred33 -trimlog trimlog_${ID}.txt -summary summary_${ID}.txt \
${ID}_1.fastq.gz $_2.fastq.gz \ # 入力するFASTQファイルへのパス
${ID}_trim_pair_1.fastq.gz \ # トリム後出力ファイル　その1
${ID}_trim_unpair_1.fastq.gz \ # トリム後出力ファイル　その1
${ID}_trim_pair_2.fastq.gz \ # トリム後出力ファイル　その1
${ID}_trim_unpair_2.fastq.gz \ # トリム後出力ファイル　その1
ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEM:50;
done; echo finised; cat summary_${ID}.txt > trimming_summary.txt

# PEはペアエンドリードを対象とするときのオプション（シングルエンドはSE）
# -phred33 はQuality valueの形式としてphred33を指定
# -trimlogはトリミング情報ファイル名を指定
# -summaryはサマリ情報ファイル名を指定
# ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10まででアダプター配列情報を指定(2:30:10はこのままで良い)
# LEADING/TRAILING は先頭/末尾の塩基除去時のQV最小値
# SLIDINWINDOW:でQVを計算する枠のサイズを指定
# MINLENはトリミング後の最小リード長を指定

# トリミング結果summary_${ID}.txtをcatコマンド表示し、90％以上のペアリードがペアとして残っていれば概ね問題なし
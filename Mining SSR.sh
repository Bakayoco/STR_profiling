#! /bin/bash

## SSR identification

FASTA=/path/to/fasta


cd /path/to/output_folder
perl misa.pl $FASTA 

#Collect all SSR
for i in *.gff; do cat $i >> cat.gff; echo "processing $i"; done
grep -v -E "#|region" cat.gff > cat.mod.gff

#Perfect_SSR
awk '{OFS="\t"} {split($9, a, ";"); split(a[1], b, ",")} b[1]!= "Note=compound_repeat" {split(b[2], c, ")"); print $1, $4, $5, c[2], c[1]}' cat.mod.gff > perfect.bed
sed -e 's/(//' perfect.bed > perfect.result.bed
awk '{OFS="\t"} q=length($5) {print $1, $2, $3, q, $5}' perfect.result.bed > perfect.final.bed

#Compound repeat 
awk '{OFS="\t"} {split($9, a, ";"); split(a[1], b, ",")} b[1]=="Note=compound_repeat" {split(b[3], c, ")"); print $1, $4, $5, c[2], c[1]}' cat.mod.gff > compound_repeat.bed
sed -e 's/(//' compound_repeat.bed > compound_repeat.result.bed 
awk '{OFS="\t"} q=length($5) {print $1, $2, $3, q, $5}' compound_repeat.result.bed > compound_repeat.final.bed

##Remove >6 motif length (only for GangSTR reference panel)
awk '{OFS="\t"} $4 <= 6 {print $1, $2, $3, $4, $5}' hg38_ver13.bed > hg38_ver13.result2.bed

#Count number of each type of SSR
awk '{print $0 > $4"_motif.bed"}' MISA.bed

#STR by length
awk '{split($9, a, "(")} {split(a[2], b, ")")} {split(b[2], c, ";"); q=length(b[1]); w=q*c[1]; print $1, $4, $5, w}' cat.mod.gff > STR.length.gff
awk '$4<=10 {print $0}' STR.length.gff > under.10.gff
awk '$4<=13 && $4>10 {print $0}' STR.length.gff > 11to13.gff
awk '$4<=16 && $4>13 {print $0}' STR.length.gff > 14to16.gff
awk '$4<=25 && $4>16 {print $0}' STR.length.gff > 17to25.gff
awk '$4>25 {print $0}' STR.length.gff > over25.gff

#count STR each classes
for i in *.bed; do awk '{OFS="\t"} {$1=$1"_"; print $0}' $i > $i.gff; done
for i in *.gff; do grep -Eo 'chr1_' $i | sort | uniq -c | awk '{print  $2, $1}'; done
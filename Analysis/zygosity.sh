bcftools view input.vcf.gz | \
awk -F"\t" 'BEGIN {
    print "CHR\tPOS\tREF\tALT\tAltHetCount\tAltHomCount\tRefHomCount\to_het"
}
!/^#/ {
#Alternative heterozygosity counts
AltHetCount = gsub(/0\/1|1\/0|1\/2|2\/1/,"");

#Alternative heterozygosity counts
AltHomCount = gsub(/1\/1/,"");

#Alternative heterozygosity counts
RefHomCount = gsub(/0\/0/,"");
Denominator = AltHetCount + AltHomCount + RefHomCount
if (Denominator == 0) {
    Hete = 0
} else {
    Hete = (AltHetCount / Denominator)
}
print $1"\t"$2"\t"$4"\t"$5"\t" AltHetCount "\t" AltHomCount "\t" RefHomCount "\t" Hete
}' > zygosity.tsv
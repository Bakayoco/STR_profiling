# STR profiling in WGS from 1000 Genome Project populations

In this project, we only focused on profiling STR in Kinh in Ho Chi Minh - VN using [GangSTR](https://github.com/gymreklab/GangSTR) as genotyper and [TRTools](https://hub.docker.com/r/gymreklab/str-toolkit) as quality control toolkit. 

Although STR is an important type of genetic markers which has the potential in the forensic studies, STR variation in Vietnamese population has been not studied in depth. Some studies shown that genetics variables such as heterozygosity vary across worldwide populations. Therefore, there are the need to examine STR in different populations instead of solely rely on single STR panel. Besides, current genotypers have been facing challenges in accurately genotyping from nextgeneration sequencing data, results in missing of alleles that longer than read length. The objective of this investigation was to perform a screening analysis of a set of all STRs detected on GRCh38 and release a novel high polymorphic STR panel in Vietnamese population to the forensic community. A set of 1,340,266 STR were analyzed using CRAM file of Kinh Vietnamese from the 1000 Genomes Project on high-coverage (30x) GRCh38 dataset. 122 individuals from Kinh Vietnamese were used to call genotypes. Despite 5,685 high polymorphic STR (PIC > 0.5) recorded by performing multiple analysis, only 98 STR survived that are more genetics diverse in Vietnamese population than current common STR. This study provided complementary data for further forensic research in Vietnamese populations.

# Data collection
High coverage (30x) NGS data of 122 KHV individuals from 1000 Genome Project on high coverage [GRCh38](ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa) are available on [IGSR](https://www.internationalgenome.org/data-portal/population/KHV). The available data were already sorted and indexed by SAMtools. We perform GangSTR on 122 samples using STR reference panel available on GangSTR github.

# Quality control
VCF files from GangSTR output was merged and pass through dumpSTR to filter poor quality calls with `DP < 25` and `Q score < 0.9`. Locus with minor allele frequency < 1% were also removed with R script `MAF.R`

#Analysis
After multiple analysis calculating zygosity, Hardy-Weinberg equilibrium, Polymorphism Information Content, GC content, we successfully generated a novel high polymorphic STR panel in Vietnamese population. This initial development provided an open-access STR panel for subsequent confirmation in wet lab.

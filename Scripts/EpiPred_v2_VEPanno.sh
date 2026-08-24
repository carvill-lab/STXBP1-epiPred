#!/bin/bash
#SBATCH -A b1042
#SBATCH -p genomics
#SBATCH -N 1
#SBATCH -n 24
#SBATCH -t 01:00:00 
#SBATCH --mem=48gb

# EpiPred_v2_VEPanno.sh

module purge all

# load newer perl and htslib for new VEP
module load perl/5.26
module load htslib/1.16
#may need to load htslib for CADD or gnomAD or both to work - needs tabix

####### UPDATE BELOW #############
batch=All_snv_slc6a1
input=SLC6A1_VEPinput.txt
output=/projects/b1073/u54/SLC6A1/newRun_jun2026
#transcriptID=NM_001271.3 # this major STXBP1 transcript listed on Clinvar ## update if running on different gene
##################################

cd $output
 
perl /projects/b1073/u54/VEP_110/ensembl-vep/vep --offline --fasta /projects/b1073/pipelines/commonref/GRCh37/GRCh37.fa --dir /projects/b1073/u54/VEP_110/ensembl-vep/cache \
--cache --assembly GRCh37 --merged --port 3337 --canonical --biotype --hgvs --symbol --numbers --domains --force_overwrite --fork 24 --buffer_size 50000 \
--plugin dbNSFP,/projects/b1073/u54/VEP_110/ensembl-vep/Plugins/dbNSFP/dbNSFP4.4a_grch37.gz,pep_match=0,MetaLR_score,MetaSVM_score,M-CAP_score,MutPred_score,FATHMM_score,fathmm-MKL_coding_score,MutationAssessor_score,LRT_score,PROVEAN_score,SIFT_score,Polyphen2_HDIV_score,Polyphen2_HVAR_score,rs_dbSNP,phastCons100way_vertebrate,phastCons470way_mammalian,phyloP100way_vertebrate,phyloP470way_mammalian,SiPhy_29way_pi,SiPhy_29way_logOdds,GERP++_NR,GERP++_RS,PrimateAI_score,VARITY_R_score,VARITY_ER_score,CADD_raw,CADD_phred,REVEL_score,gMVP_score,Eigen-raw_coding,Eigen-phred_coding,CADD_raw_hg19,CADD_phred_hg19,VEST4_score,integrated_fitCons_score,MPC_score,BayesDel_addAF_score,ClinPred_score,LIST-S2_score,bStatistic,ref,alt,aapos,aaref,aaalt \
-i ${input} \
-o ${output}/${batch}.vcf

exit

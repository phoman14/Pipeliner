rule canvas_wgs_tumoronly:
    input: tumor=lambda wildcards: config['project']['units'][wildcards.x]+".recal.bam",
           somaticvcf=config['project']['workpath']+"/mutect2_out/{x}.FINALmutect2.vcf",
    output: vcf="canvas_out/{x}/CNV.vcf.gz",
    params: genome=config['references'][pfamily]['CANVASGENOME'],tumorsample=lambda wildcards: config['project']['units'][wildcards.x],kmer=config['references'][pfamily]['CANVASKMER'],filter=config['references'][pfamily]['CANVASFILTER'],balleles=config['references'][pfamily]['KNOWNVCF2'],rname="pl:canvas"
    shell: "mkdir -p canvas_out; mkdir -p canvas_out/{params.tumorsample}; cp {params.tumorsample}.recal.bai {params.tumorsample}.recal.bam.bai; export COMPlus_gcAllowVeryLargeObjects=1; module load Canvas/1.38; Canvas.dll Somatic-WGS -b {input.tumor} -o canvas_out/{params.tumorsample} -r {params.kmer} -g {params.genome} -f {params.filter} --sample-name={params.tumorsample} --population-b-allele-vcf={params.balleles} --somatic-vcf={input.somaticvcf}"
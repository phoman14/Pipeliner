rule rnafusioncleanup:
        input:  expand("{name}.RnaSeqMetrics.txt",name=samples),
                "RawCountFile_genes_filtered.txt",
                "RawCountFile_junctions_filtered.txt",
                "RawCountFile_genejunctions_filtered.txt",
                expand("{name}.star.count.overlap.txt",name=samples),
                "RawCountFileOverlap.txt",
                "RawCountFileStar.txt",
                expand("{name}.rsem.genes.results",name=samples),
                expand("QC/{x}_readlength.txt",x=samples),
                expand("{x}.R1.fastq.gz", x=samples),
        output: expand("expression/{name}.RnaSeqMetrics.txt",name=samples),
                "expression/RawCountFile_genes_filtered.txt",
                "expression/RawCountFile_junctions_filtered.txt",
                "expression/RawCountFile_genejunctions_filtered.txt",
                expand("expression/{name}.star.count.overlap.txt",name=samples),
                "expression/RawCountFileOverlap.txt",
                "expression/RawCountFileStar.txt",
                expand("expression/{name}.rsem.genes.results",name=samples),
                expand("expression/QC/{x}_readlength.txt",x=samples),
        params: rname="pl:clean"
        shell:  "mv *filtered.tx expression/; mv *.RnaSeqMetrics.txt expression/; mv *.star.count.overlap.txt expression/; mv RawCountFileOverlap.txt expression/; mv RawCountFileStar.txt expression/; mv *.rsem.genes.results expression/; mv  mkdir -p {output.fusioncatcher}; mkdir -p {output.starfusion}; mkdir -p {output.fusioninspcatch}; mkdir -p {output.oncofusecatch}; mkdir -p {output.fusioninspstar}; mkdir -p {output.oncofusestar}; mkdir -p {output.expression}"
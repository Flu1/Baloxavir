# Baloxavir
Analysis of next-generation sequencing data from ferret nasal wash samples for the paper - Baloxavir treatment of ferrets infected with influenza A(H1N1)pdm09 virus reduces onward transmission. A description of the samples can be found on the sample spreadsheet.

1. Sample sequences can be downloaded from https://www.ebi.ac.uk/ena -project number PRJEB33516. Download the sequences and put them in a new folder in your working directory.

2. Initial sample preparation - see initial_baloxavir_nextgen.R

3. Run Baloxavir_ngs_analysis.R to perform the analysis. To do this you will need a folder with the samples in fasta format.  Then run Baloxavir_ngs_analysis(list.files(pattern=".fasta"))

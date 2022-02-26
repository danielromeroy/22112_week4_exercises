GENOME_PATH = "/path/to/genome/human.fsa"
COPY_PATH = "/destination/genome/path/human.fsa"

infile = open(GENOME_PATH, "r")
outfile = open(COPY_PATH, "w")
for line in infile:
    outfile.write(line)
infile.close()
outfile.close()

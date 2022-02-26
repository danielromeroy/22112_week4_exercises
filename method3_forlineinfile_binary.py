GENOME_PATH = "/path/to/genome/human.fsa"
COPY_PATH = "/destination/genome/path/human.fsa"

infile = open(GENOME_PATH, "rb")
outfile = open(COPY_PATH, "wb")
for line in infile:
    outfile.write(line)
infile.close()
outfile.close()

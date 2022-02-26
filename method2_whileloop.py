GENOME_PATH = "/path/to/genome/human.fsa"
COPY_PATH = "/destination/genome/path/human.fsa"

infile = open(GENOME_PATH, "r")
outfile = open(COPY_PATH, "w")
line = infile.readline()
while line != "":
    outfile.write(line)
    line = infile.readline()
infile.close()
outfile.close()

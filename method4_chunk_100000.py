GENOME_PATH = "/path/to/genome/human.fsa"
COPY_PATH = "/destination/genome/path/human.fsa"

infile = open(GENOME_PATH, "rb")
outfile = open(COPY_PATH, "wb")
while True:
    chunk = infile.read(100000)
    outfile.write(chunk)
    if len(chunk) < 100000:
        break
infile.close()
outfile.close()

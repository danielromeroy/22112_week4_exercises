$tests_per_file = 50

$GENOME_PATH = 'C:\path\to\genome\human.fsa'
$COPY_PATH = 'C:\destination\genome\path\human.fsa'
$RESULTS_FILE = 'C:\destination\results\file.txt'
$FILES_LOCATION = 'C:\python\scripts\location\'

$files = @('method1_forlineinfile.py', 'method2_whileloop.py', 'method3_forlineinfile_binary.py',
           'method4_chunk_10000.py', 'method4_chunk_100000.py')

Remove-Item $RESULTS_FILE

for ($i = 1; $i -le $tests_per_file; $i++)
{
    Foreach ( $curr_file in $files )
    {
        Write-Host "Testing $curr_file for the $i'th time"
        Write-Host "N $i $curr_file" *>> $RESULTS_FILE
        Measure-Command { py -3 $curr_file } *>> $RESULTS_FILE
        Remove-Item $COPY_PATH
    }

    Write-Host "Testing powershellcopy for the $i'th time"
    Write-Host "N $i poweshellcopy" *>> $RESULTS_FILE
    Measure-Command { Copy-Item $GENOME_PATH $COPY_PATH } *>> $RESULTS_FILE
    Remove-Item $COPY_PATH
}

Read-Host -Prompt "Press Enter to exit"

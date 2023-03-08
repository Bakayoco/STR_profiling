# Define a function to calculate the statistics
function calculate_stats() {
    # Extract column 8 from the input file and sort it
    column=$(cut -f 8 "$1" | sort -n)

    # Calculate the statistics
    count=$(echo "$column" | wc -l)
    min=$(echo "$column" | head -n 1)
    max=$(echo "$column" | tail -n 1)
    mean=$(echo "$column" | awk '{ sum += $1 } END { print sum / NR }')
    median=$(echo "$column" | awk '{ a[NR]=$1 } END{ print (NR%2==0)?(a[NR/2]+a[NR/2+1])/2:a[(NR+1)/2] }')
    stdev=$(echo "$column" | awk -v mean="$mean" '{ sum += ($1 - mean)^2 } END { print sqrt(sum/NR) }')

    # Print the statistics to the output file
    echo -e "$(basename "$1")\t$count\t$min\t$max\t$mean\t$median\t$stdev" >> stats.tsv
}

# Print the header of the output file
echo -e "Filename\tCount\tMin\tMax\tMean\tMedian\tStdev" > stats.tsv

# Loop over the input files and calculate the statistics
for file in *.tsv; do
    calculate_stats "$file"
done

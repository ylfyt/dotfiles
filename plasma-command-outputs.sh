# widget link
# https://store.kde.org/p/2136636

# print memory usage
free | awk '/Mem/{printf("M:%02d\n", $3/$2 * 100)}'

# print ping latency
ping google.com -c 1 -w 400 | grep 'time=' | awk -F'=' '{print $4}' | awk '{if ($1 < 500) print $1; else print "😡"}'
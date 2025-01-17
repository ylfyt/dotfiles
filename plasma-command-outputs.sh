# widget link
# https://store.kde.org/p/2136636

# print memory usage
free | awk '/Mem/{printf("M:%02d\n", $3/$2 * 100)}'

# print ping latency
(timeout 2s ping -c 1 -w 400 8.8.8.8 2> /dev/null | grep 'time=' || echo '0=0=0=0') | awk -F'=' '{print $4}' | awk '{if ($1 > 500) print "😡"; else if ($1 > 0) print $1; else print "❌"}'

# print cpu usage
top -bn2 -d 0.01 | grep "Cpu(s)" | tail -1 | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "💥:"int(100 - $1)}'

# print cpu temp
sensors | grep 'Tctl' | awk '{print int($2)"°C"}'

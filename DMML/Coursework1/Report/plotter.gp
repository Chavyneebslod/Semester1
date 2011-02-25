set title "Histogram of Yeast Dataset\nMcGeoch's method for signal sequence recognition (field 1)"

set auto x
set yrange [0:100]
set xtics (0-20,21-40,41-60,61-80,81-100)
plot "yeastHistData" using 1:6 with boxes

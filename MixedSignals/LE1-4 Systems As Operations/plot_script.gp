# Gnuplot script to plot RC Circuit Step Response

# 1. Set the output format (save to a PNG image file)
set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output 'rc_circuit_plot.png'

# Alternatively, un-comment the line below to show a pop-up window instead
# set terminal wxt size 800,600 persist

# 2. Set titles and labels
set title "RC Circuit Step Response: Numerical vs Analytic"
set xlabel "Time [t]"
set ylabel "Voltage [V]"
set grid

# 3. Move the legend (key) to a nice spot
set key right bottom box

# 4. Plot the data from "out.dat"
# 'skip 1' tells Gnuplot to ignore the first line (the text header)
# using 1:2 means X=Column 1 (Time), Y=Column 2 (Numeric)
# using 1:3 means X=Column 1 (Time), Y=Column 3 (Analytic)

plot "out.dat" skip 1 using 1:2 with lines lw 2 lc rgb "red" title "Numerical", \
     "out.dat" skip 1 using 1:3 with lines dashtype 2 lw 2 lc rgb "blue" title "Analytic"
set encoding default
unset key
plot 'q1plot.dat' u 1:2 w l lc rgbcolor "black" lw 2
set xr[-2:8];
set yr[-4:4];
set xtics 1
set grid x y 

set xlabel "Time [s]"
set ylabel "x(t)"

set size ratio -1 

set term png  #size 6in,3.5in
set output "q1.png"
replot

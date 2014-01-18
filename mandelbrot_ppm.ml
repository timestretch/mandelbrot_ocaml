(*
 * OCaml mandelbrot - PPM bitmap generator.
 * By Erik Wrenholt 2014-01-18 
 * License: Public Domain
 *)

let max_iterations = 1000;;
let bailout = 16.0;;

let mandelbrot cr ci =
  let cr = cr -. 0.5 in
  let rec iterate i zr zi = 
    let temp = zr *. zi in
    let zr2 = zr *. zr in
    let zi2 = zi *. zi in
  if (zi2 +. zr2) > bailout || i >= max_iterations then i
  else iterate (i+1) (zr2 -. zi2 +. cr) (temp +. temp +. ci) in
  iterate 0 0. 0.
;;

print_string "P6\n";;
print_string "256 256\n";;
print_string "255\n";;

for yy = -128 to 127 do
  let ci = (float_of_int yy) /. 128. in
  for xx = -128 to 127 do
    let cr = (float_of_int xx) /. 128. in
    let gray = char_of_int ((mandelbrot ci cr) mod 255) in
    print_char gray;
    print_char gray;
    print_char gray;
  done;
done;;

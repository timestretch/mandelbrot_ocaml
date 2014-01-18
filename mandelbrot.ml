(* 
 * OCaml mandelbrot - ASCII version.
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


let ramp = [' ';'.';':';';';'!';'+';'E';'$';'#';'&';'%'] in
let list_length = (List.length ramp) in
for yy = -39 to 39 do
  let ci = (float_of_int yy) /. 40. in
  for xx = -39 to 39 do
    let cr = (float_of_int xx) /. 40. in
    let ramp_index = ((mandelbrot ci cr) mod list_length) in
    print_char (List.nth ramp ramp_index)
  done;
  print_newline ();
done;;

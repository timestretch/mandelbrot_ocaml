(*
 * OCaml Buddhabrot - PPM bitmap generator.
 * By Erik Wrenholt 2014-05-29 
 * License: Public Domain
 *)

let max_iterations = 1024;;
let bailout = 16.0;;
let image_size = 512;;
let samples_per_pixel = 32;;
let max_pixel = ref 0;;
let radius = 1.0;;

(* matrix holds the 'hit-count' for each pixel *)
let fractal_data = Array.make_matrix image_size image_size 0;;

(* each iteration's x,y pairs are stored here *)
let iteration_list = Array.make max_iterations (0.0, 0.0);;

(* Iterate and store each orbit in case it is outside the set, so we can plot it later *)
let mandelbrot cr ci =
  let rec iterate i zr zi = 
    let temp = zr *. zi in
    let zr2 = zr *. zr in
    let zi2 = zi *. zi in
	if (zi2 +. zr2) > bailout || i >= max_iterations then i
	else begin
		let zr = (zr2 -. zi2 +. cr) in
		let zi = (temp +. temp +. ci) in
		iteration_list.(i) <- (zi, zr);
	  iterate (i+1) zr zi 
	end in
  iterate 0 0. 0.
;;

let plot_pixel (ax : float) (ay : float) = 
  let scale_val n = 
	int_of_float ((n /. (radius *. 2.0)) *. (float_of_int image_size) +. (float_of_int image_size) /. 2.0) in

  let px = scale_val ax in
  let py = scale_val ay in

  if px < image_size && px > 0 && py < image_size && py > 0 then
	let current_value = fractal_data.(py).(px) in
	
	if current_value + 1 > !max_pixel then
	  max_pixel := current_value + 1;
	
	fractal_data.(py).(px) <- current_value + 1;
;;

let render_fractal_size = 

  let calc_fractal = 
	let random_float = (fun () -> (Random.float (radius *. 2.0)) -. radius) in
	let pixel_samples = image_size * image_size * samples_per_pixel in

	for i=0 to pixel_samples do
	  let cr = random_float () in
	  let ci = random_float () in
	  let iterations = (mandelbrot ci cr) in

	  if iterations != max_iterations then

		for i = 0 to iterations-1 do
		  let tx = snd iteration_list.(i) in
		  let ty = fst iteration_list.(i) in
		  plot_pixel tx ty;
		done;

	done in

  let render_fractal = 

	print_string "P6\n";
	Printf.printf ("%d %d\n") image_size image_size;
	print_string "255\n";

	for y = 0 to image_size-1 do
	  for x = 0 to image_size-1 do
		let iterations = fractal_data.(y).(x) in
		let gray = char_of_int (int_of_float (((float_of_int iterations) /. (float_of_int !max_pixel)) *. 255.0))  in
		print_char gray;
		print_char gray;
		print_char gray;
	  done;
	done in
	
	calc_fractal;
	render_fractal;
;;


let () = 
  render_fractal_size;;

OCaml Mandelbrot Set
--------------------

When I learn a new language, one of the first things I write is a Mandelbrot fractal generator. I've recently started looking at OCaml. The compiled output is very fast. It looks like a good fit for generating fractals.

Two variations are presented here. One just outputs an ASCII representation, and the other generates a PPM bitmap which you can open in Photoshop.

Run with bytecode compiler:

	time ocaml mandelbrot.ml
	time ocaml mandelbrot_ppm.ml > output.ppm

Optimizing Compiler:

	ocamlopt mandelbrot.ml -o mandelbrot_opt;
	time ./mandelbrot_opt;
	
	ocamlopt mandelbrot_ppm.ml -o mandelbrot_ppm_opt;
	time ./mandelbrot_ppm_opt > output.ppm

Buddhabrot Example
-

I added a Buddhabrot generator. To run it with bytecode compiler:

	time ocaml buddhabrot_ppm.ml > buddhabrot.ppm

Optimizing Compiler:

	ocamlopt buddhabrot_ppm.ml -o buddhabrot_ppm_opt;
	time ./buddhabrot_ppm_opt > output.ppm
	
![Buddhabrot Example Image](/buddhabrot.png "Buddhabrot Example")

License: Public Domain

Erik Wrenholt 2014-01-14

#import "@preview/zap:0.2.0"

= A word on references, figures and other basics

== References
Inside the "bibliography.bib" file you place your references. To reference simply use ```typst @name-of-reference``` to reference it and it will appear in the outline according to the standard set in "main.typ" (by default IEEE). For example here's a reference to an awesome book! @goat-boken

To reference an object inside the document you must first insert a label, it can be done with using ```typst <label>``` as follows

#align(left)[```typst
	== Example heading <label-of-heading>
	```
]

and later use ```typst @label-of-heading``` to reference it. This works on almost any type of object, be figures or headings (and even pages!). Headings of level 1 automatically have the supplement "Chapters" and sub headings the supplement "Section". For example this a reference to @intro and this is a reference to @structure. Also, here's a footnote. #footnote("Footnote!")

== Figures
Figures are created using the ```typst #figure()``` function. By default there are three types: image, table and raw (used for code). Should you feel like it there's the possibility of making your own. @TypstFigure. Typst automatically detects which one of the three kinds that's being used.

//#figure()

#figure(
  table(
    columns: 4,
    [t], [$t_1$], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [This is a table],
)

#figure(
	align(left, [```c
	int fact(int n){
		if(n == 1){
			return 1;
		}
		return fact(n - 1);
	}
	```]),
	caption: "This is raw text"
)

=== An example figure with Zap
In @electrical-circuit I have used what Typst calls a "package". This package (called Zap @TypstZap) is much like circuitTikZ. Other packages are available at Typst Universe, however I must warn that most are still in their early stages and are far away as easy to use as LaTeX packages. A package is typically imported using 

#align(left)[
	```typst
	#import "@preview/zap:0.2.0"
	```
]

#figure(
	zap.canvas({
	    import zap: *
	    scale(0.6)
	    vsource("vs", (0,-4), (0, 4), u: (label: $V_"cc"$))
	    npn("q1", (3-0.4,0), label: $Q_1$)
	    npn("q2", (6-0.4,0), label: $Q_2$)
	    resistor("r_ref", "q1.e",  (3,4), i: (label: $I_"ref"$, position: right, invert: true), u: (label: $V_"ref"$), label: $R_"ref"$)
	    resistor("r_a", "q2.e", (6,4), label: $R_A$)
	    resistor("r_l",  "q2.c", (6,-4), i: (label: $I_L$, position: end + bottom), label: $R_L$)
	    wire("vs.in", "r_l.out")
	    wire("vs.out", "r_a.out")
	    wire("q1.c", (3,-4))
	    wire("q1.b", (2, 0))
	    wire((2, 0), (2, -1))
	    wire((2, -1), (3, -1))
	    wire((3, 0), (3, -1))
	    wire((3,0), "q2.b")
	}),
    caption: "The current mirror. This mirror is in the 'above' configuration, pushing current down into the load.",
)<electrical-circuit>

== Math

Of course we want to be able to do mathematical equations. This is done simply by either writing ```typst $ a = b $ ```. Which produces $ a = b $ Or you can do inline math with ```typst $a = b$```. Which just gives $a = b$. Special symbols can either be written with ```typst $NN$``` or using escape characters as ```typst \u{2115}```, both of which produce \u{2115}.

Let's say you want something more complicated, for example the definition of a convolution. Typst offers many symbols to choose from. Keep in mind that letters together form variables and symbols, so keep them apart! The code  ```typst $ (f * g)(t) colon.eq integral_(- infinity)^infinity f(tau) g(t - tau ) d tau $``` produces

$ (f * g)(t) colon.eq integral_(- infinity)^infinity f(tau) g(t - tau ) d tau $ <convolution>

Of course, you can reference these equations. The one above is @convolution. Typst's math module is pretty extensive so I recommend following the documentation.@TypstDocumentation


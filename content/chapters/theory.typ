#import "@preview/zap:0.2.1"

= A word on references, figures and other basics

== References and labels
Inside *bibliography.bib* you place your references. To reference simply use ```typst @name-of-reference``` to reference it and it will appear in the outline according to the standard set in *main.typ*. For example here's a reference to an awesome book! @goat-boken

A reference in *bibliography.bib* can look like this: 

#align(left)[
```typst
@book{goat-boken,
    title = {Introduction to Electrodynamics (4th ed.)},
    author = {David Jeffrey Griffiths},
    isbn = {9781009397759},
    series = {},
    year = {2013},
    publisher = {Cambridge University Press},
    keywords = {physics, electromagnetics}
}
```
]

To reference an object inside the document you must first insert a label, it can be done using ```typst <label>``` as follows

#align(left)[```typst
	== Example heading <label-of-heading>
	```
]

and later use ```typst @label-of-heading``` to reference it. This works on almost any type of object, be figures or headings (and even pages!). Headings of level 1 automatically have the supplement "Chapter" and sub headings the supplement "Section". For example this a reference to @intro and this is a reference to @structure. Also, here's a footnote. #footnote("Footnote!")

== Figures
Figures are created using the ```typst #figure()``` function. By default there are three types: image, table and raw (code). Should you feel like it there's the possibility of making your own. @TypstFigure. Typst automatically detects which one of the three kinds that's being used.

//#figure()

#figure(
  table(
    columns: 4,
    [t], [$t_1$], [$t_2$], [$t_3$],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: "This is a table.",
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
	caption: "This is raw text."
)

#figure(
	square(
		width: 35%,
		fill: tiling(
			size: (20pt, 20pt),
  		relative: "parent",
			place(
  			dx: 5pt,
  			dy: 5pt,
  			rotate(
  				45deg, 
  				square(
    				size: 5pt,
    				fill: black,
  				)
  			),
			),
  	)
	),
	caption: "This is a figure."
)

=== An example figure with Zap
In @electrical-circuit I have used what Typst calls a "package". This package (called Zap @TypstZap) is much like circuitTikZ. Other packages are available at Typst Universe, however I must warn that most are still in their early stages and are far away as easy to use as LaTeX packages. A package is typically imported using 

#align(left)[```typst 
#import "@preview/zap:0.2.1"
```]

#figure(
	zap.canvas({
	    import zap: *
	    
	    //Voltage source
	    vsource("vs", (0,-4), (0, 4), u: (label: $V_"cc"$))

	    //Transistors
	    npn("q1", (3,0), label: $Q_1$)
	    npn("q2", (6,0), label: $Q_2$)

	    //Resistors
	    resistor("r_ref", (3,4),  "q1.e", i: (label: $I_"ref"$, position: start, invert: true), u: (label: $V_"ref"$, position: left), label: $R_"ref"$)
	    resistor("r_a", (6,4), "q2.e", label: $R_A$)
	    resistor("r_l",  "q2.c", (6,-4), i: (label: $I_L$, position: end + bottom), label: $R_L$)

	    //Wires
	    wire("vs.in", "r_l.out")
	    wire("vs.out", "r_a.in")
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

Of course we want to be able to do mathematical equations. This is done simply by either writing ```typst $ a = b $ ```. Which produces $ a = b $ Or you can do inline math with ```typst $a = b$```. Which just gives $a = b$. Special symbols can either be written with ```typst $NN$```, ```typst math.bb(N)``` or using escape characters as ```typst \u{2115}```, all of which produce \u{2115}.

Let's say you want something more complicated, for example the definition of a convolution. Typst offers many symbols to choose from. Keep in mind that letters together form variables and symbols, so keep them apart! This is the definition of the divergence of a vector field:

$ "div" bold(A) =^Delta lim_(Delta v -> 0) frac(integral.cont bold(A) dot d bold(s), Delta v) $ <divergence>

Written as ```typst $ "div" bold(A) =^Delta lim_(Delta v -> 0) frac(integral.cont bold(A) dot d bold(s), Delta v) $ <divergence>```.

Of course, you can reference these equations. The equation above is @divergence. I recommend looking at the documentation to get the full picture. @TypstDocumentation

== Typst documentation

Typst has a dedicated site for its documentation, this contains everything from basic styling and setting up a document to context handling and multiple styled documents like this report. The documentation also contains references to everything included in the language. @TypstDocumentation

= Full page example

#lorem(150)

#lorem(200)

== Test Section

#lorem(700)
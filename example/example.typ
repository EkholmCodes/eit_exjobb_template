#import "../src/exjobb_eit.typ": thesis, frontmatter, mainmatter, flexCaption, backmatter
#import "@preview/lilaq:0.5.0" as lq

#show: thesis.with(
	print: false,
	thesis_title: [Test of exjobb_eit.typ],
  subtitle: [An unofficial Typst template for degree project at Electrical and Information Technology at LTH, made by Lucas Ekholm (E22)],
	short_title: [A shorter title],
	examiner: [Some examiner],
	supervisors: ([Academic Supervisor: Some Supervisor], [Company Supervisor: Another Supervisor]),
	authors: (
		(
			name: "Student A",
			email: "Student.A@mail.com"
		),
		(
			name: "Student B",
			affiliation: "Lund University",
			email: "Student.B@mail.com"
		),
	),
	degree: "Masters of Science in Engineering, Electrical Engineering",
	affiliations: ([Department of Electrical and Information Technology \ Lund University], [Some company?]),
	front_images: ("../example/LTH_RGB_ENG.png", "../example/LTH_BLACK_ENG.png"),
	keywords: ("Keyword 1", "Keyword 2"),
	description: "This is an example render made from the exjobb_eit.typ template made by Lucas Ekholm (E22).",
 heading_style: "original",
 header_style: "original",
	date: datetime(year: 2022, month: 10, day: 22),
 report-id: highlight[Here goes the report id!]
)

#show: frontmatter

= Frontmatter

#lorem(75)

#lorem(50)

#set terms(tight: false, spacing: 5mm)
#for (abb, des) in (
	"EIT": "Engineering Is (never) Trivial",
	"LED": "Let's Emit Dazzle",
	"MOSFET" : "Mostly Our Small Friend Enabling Transistor",
	"AC" : "Actually Confusing",
	"IC" : "Infinite Confusion",
	"EMC" : "Engineers' Major Complaint",
	"CODE" : "Computers Only Do Exactly (what you tell them)",
	"PING" : "Packet Is Now Going"
).pairs().sorted() [/ #abb: #des]

#align(center)[
	#quote(block: true, quotes: true, attribution: [Markus Törmänen #footnote([Translated. Original quote in Swedish.]), spring 2025])[
		To mature as an electrical engineer is to realize everything is about impedances.
	]
]

#outline(title: "Table of Contents") <outline>
#outline(title: "List of Figures", target: figure.where(kind: image))
#outline(title: "List of Tables", target: figure.where(kind: table))

#show: mainmatter

= Introduction <intro>
#lorem(100)

#lorem(100)

$ "div" bold(A) := lim_(Delta v arrow 0) (integral.surf_S bold(A) dot d bold(s)) / (Delta v) $ <divergence>

$ nabla times bold(B) = mu_0(bold(J) + epsilon_0 (partial bold(E)) / (partial t)) $ <ampere-maxwell>

The equations above are @divergence and @ampere-maxwell. This is @intro but below is @test and below that is @test2. This chapter can be found on #ref(<intro>, form: "page").

== Test section <test>

#lorem(50)

=== A section which won't appear in the outline on #ref(<outline>, form: "page"). <test2>
#lorem(50)

==== These sections keep going!

#lorem(50)

#figure(
	lq.diagram(
		lq.quiver(
			lq.linspace(-5, 5, num: 20),
			lq.linspace(-5, 5, num: 20),
			(x, y) => {
				let a = x*x - y*y
				return (calc.sin(y), calc.sin(x))
			},
			color: (x, y, u, v) => calc.norm(u, v),
			map: lq.color.map.lipari,
			scale: 0.5,
			min: 0,
			max: 2,
		)
	),
	caption: flexCaption([An example figure using the package Lilaq. @lilaq], [An example figure using the package Lilaq.])
) <vector-field>

== Another test section

#lorem(100) #footnote[https://www.lth.se]

#let l = counter("letters")
#let letter() = block[
	#l.step()
	#context l.display("A")
]

#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), letter()))),
	caption: flexCaption([A figure with a longer caption. #lorem(50)], [A shorter caption, but links to the same figure!])
)

/*
== Styling parameters

#figure(
	table(rows: 4, columns: 7, 
		[], [Headings], [Sub-headings], [Sub-sub-headings], [Body], [Secondary text], [Tertiary], 
		[Size], [#size_heading (Body)], [#size_sub_heading], [#size_sub_sub_heading], [#size_main], [#size_secondary], [-],
		[Color], rect(fill: colour_heading), rect(fill: colour_heading), rect(fill: colour_heading), rect(fill: colour_main), rect(fill: colour_secondary), rect(fill: colour_tertiary)
		),
	caption: "Document types, their size and color."
)*/

= #flexCaption("New Chapter with a Long Title that Spanns over More Than One Line", "A New Chapter with a Short Title") <flexHeading>

#grid(columns: 2, 
	[#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), letter()))),
	caption: "A figure together with another figure."
	) <figureB> ], [
	#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), letter()))),
	caption: flexCaption([This figure can have a long caption and still fit if done this way. #lorem(10)], [This figure can have a long caption and still fit.])
) <figureC>])

Above @figureB is next to @figureC. By using the #raw("#flexCaption(long caption, short caption)", lang: "typst", block: false) function you can make flexible captions. You can also make longer/shorter headings! See @flexHeading on #ref(<outline>, form: "page").

== New section

$ F_(n) = F_(n-1) + F_(n-2), #h(1cm) cases(F_0 = 0, F_1 = 1) $

#lorem(20)

#let count = 15
#let nums = range(1, count + 1)
#let fib(n) = (
  if n <= 2 { 1 }
  else { fib(n - 1) + fib(n - 2) }
)

#figure(table(
  columns: count,
  ..nums.map(n => $F_#n$),
  ..nums.map(n => str(fib(n))),
),
caption: [The Fibonacci sequence up to n = #count.])

= A word on Typst referencing

On #ref(<ref>, form: "page") you can find links. @latex-guide provides a guide for past LaTeX users on the differences between the two typesetting languages, including what's native or not native, which macros map to which function etc. @cite and @bibliography links to information on how to cite and reference different sources. Typst includes support for both its native YAML-based format and BibTeX. @universe gives a link to the Typst Universe. On this page you can find packages which aid in your workflow, both in terms of styling and automation. For example @vector-field was made using lilaq, a package used to make graphs inside the Typst environment. Another good package is Zap which is used to make circuit diagrams much like TikZ. @zap

For documentation on all functions, markup- and styling commands, see @documentation.


//This can also be in a seperate .bib/.yml file! Then you would simply write the relative path in #bibliography("PATH", ..)
#let works = ```bib
	@online{latex-guide,
		title = {Guide for LaTeX users},
		url = {https://typst.app/docs/guides/guide-for-latex-users/},
		publisher = {Typst},
		date = {2025-10-22}
	}

	@online{lilaq,
		title = {Lilaq - Typst Universe},
		url = {https://typst.app/universe/package/lilaq/},
	}

	@online{bibliography,
		title = {Bibliography function},
		url = {https://typst.app/docs/reference/model/bibliography/},	
	}

	@online{cite,
		title = {Cite function},
		url = {https://typst.app/docs/reference/model/cite/}
	}

	@online{documentation,
		title = {Typst Documentation},
		url = {https://typst.app/docs}
	}

	@online{universe,
		title = {Typst Universe},
		url = {https://typst.app/universe/}
	}

	@online{zap,
		title = {Zap - Typst Universe},
		url = {https://typst.app/universe/package/zap}	
	}
```.text

#bibliography(bytes(works), title: "References") <ref>

#show: backmatter

= Backmatter

#figure(
	align(left, [```c
	/* Function to sort array using insertion sort */
	void insertionSort(int arr[], int n)
	{
	    for (int i = 1; i < n; ++i) {
	        int key = arr[i];
	        int j = i - 1;

	        /* Move elements of arr[0..i-1], that are
	           greater than key, to one position ahead
	           of their current position */
	        while (j >= 0 && arr[j] > key) {
	            arr[j + 1] = arr[j];
	            j = j - 1;
	        }
	        arr[j + 1] = key;
	    }
	}
	```]),
	caption: "Code snippet for insertionsort written in C."
)

#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), letter()))),
	caption: "This is the last figure."
	) <figureD>
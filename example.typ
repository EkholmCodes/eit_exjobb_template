#import "src/exjobb_eit.typ": *
#import "@preview/lilaq:0.5.0" as lq

#show: doc.with(
	print: false,
	title: "A Test of exjobb_eit.typ",
	short-title: "A shorter title",
	examinor: "Some examinor",
	supervisors: ("Academic Supervisor: Some Supervisor", "Company Supervisor: Another Supervisor"),
	authors: (
		(
			name: "Student A",
			affiliation: none,
			email: "Student.A@mail.com"
		),
		(
			name: "Student B",
			affiliation: "Lund University",
			email: "Student.B@mail.com"
		),
		(
			name: "Student C",
			affiliation: none,
			email: "Student.C@mail.com"
		)
	),
	affiliations: ([Department of Electrical and Information Technology \ Lund University], [Some company?], [Another affiliation]),
	front_images: (("../content/media/LTH_RGB_ENG.png"), ("../content/media/LTH_BLACK_ENG.png")),
	date: datetime(year: 2025, month: 10, day: 20)
)

#show: frontmatter

= Frontmatter

#lorem(100)

#lorem(50)

#set terms(tight: false, spacing: 5mm)
#for (abb, des) in (
	"EIT": "Department of Electrical and Information Technology",
	"LED": "Let's Emit Dazzle",
	"MOSFET" : "Mostly Our Small Friend Enabling Transistor",
	"EITF80": "Energy Isn’t Truly Free",
	"AC" : "Actually Confusing",
	"CODE" : "Computers Only Do Exactly (what you tell them)",
	"PING" : "Packet Is Now Going"
).pairs().sorted() [/ #abb: #des]

#align(center)[
	#quote(block: true, quotes: true, attribution: [Markus Törmänen, spring 2025])[
		To mature as an electrical engineer is to realize everything is about impedances.
	]
]

#outline(title: "Table of Contents")

#outline(title: "List of Figures", target: figure.where(kind: image))

#show: mainmatter

= Introduction <intro>
#lorem(100)

#lorem(100)

$ "div" bold(A) =^Delta lim_(Delta v -> 0) frac(integral.surf_S bold(A) dot d bold(s), Delta v) $ <divergence>

The equation above is @divergence. This is @intro but below is @test and below that is @test2.

== Test section <test>

#lorem(50)

=== A section which won't appear in the outline <test2>

#lorem(50)

#figure(
	lq.diagram(
		lq.quiver(
			lq.linspace(-4, 4, num: 15),
			lq.linspace(-4, 4, num: 15),
			(x, y) => {
				let (a, b) = (2, 2)
				x = x - a
				y = y - b
				let r = ((calc.pow(x, 2) + calc.pow(y, 2)))
				let scale = 30/(r + 30)
				if r == 0 {
					return (a, b)
				}
				else{
					return (scale*x/calc.sqrt(r), scale*y/calc.sqrt(r))
				}
			},
			color: (x, y, u, v) => calc.norm(u, v),
			map: lq.color.map.lipari,
			scale: 0.5,
			min: 0,
			max: 1.5
		)
	),
	caption: flexCaption([An example figure using the package Lilaq [SÄTT REFERENS!]], [Vector field figure.])
)

== Another test section

#lorem(100) #footnote[https://www.lth.se]

#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), [A]))),
	caption: flexCaption([A figure with a longer caption. #lorem(50)], [A shorter caption, but links to the same figure!])
)

= #flexCaption("New Chapter with a Long Title that Spanns over More Than One Line", "A New Chapter with a Short Title") <flexHeading>

#grid(columns: 2, 
	[#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), [B]))),
	caption: "A figure together with another figure."
	) <figureB> ], [
	#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), [C]))),
	caption: flexCaption([This figure can have a long caption and still fit if done this way. #lorem(10)], [This figure can have a long caption and still fit.])
) <figureC>])

Above @figureB is next to @figureC. By using the ```typst #flexCaption(long caption, short caption)``` function you can make flexible captions. You can also make longer/shorter headings! See @flexHeading.

== New section

#lorem(100)

#figure(
	table(rows: 2, columns: 3, [$t_0$], [$t_1$], [$t_2$], [$y_0$], [$y_1$], $y_2$),
	caption: "A simple table."
)

== Styling parameters

#figure(
	table(rows: 4, columns: 7, 
		[], [Headings], [Sub-headings], [Sub-sub-headings], [Body], [Secondary text], [Tertiary], 
		[Size], [#size_heading (Body), #size_chapter_nbr (Chapter numbering)], [#size_sub_heading], [#size_sub_sub_heading], [#size_main], [#size_secondary], [-],
		[Color], rect(fill: grey_heading), rect(fill: grey_heading), rect(fill: grey_heading), rect(fill: grey_main), rect(fill: grey_secondary), rect(fill: grey_tertiary)
		),
	caption: "Document types, their size and color."
)

#figure(
	table(rows: 3, columns: 6,
		[], [Body], [Secondary text], [Chapter numbering], [Math], [Raw],
		[Font], text(font: font_main, font_main), text(font: font_secondary, font_secondary), text(font: font_chapter_nbr, font_chapter_nbr), text(font: font_math, font_math), text(font: font_code, font_code),
		[Usage], [Main text], [Headings, captions, header], [Chapter and page number], [Equations, inline math], [Code blocks]
		),
	caption: "Fonts used."
)

#bibliography("./content/bibliography.bib", title: "References", full: true)

#show: backmatter

= Backmatter

#figure(
	align(left, [```cpp
	void insertionSort(int a[], int n)
	{
	    int i, key, j;
	    for (i = 1; i < n; i++) {
	        key = a[i];
	        j = i - 1;

	        while (j >= 0 && a[j] > key) {
	            a[j + 1] = a[j];
	            j = j - 1;
	        }
	        a[j + 1] = key;
	    }
	}
	```]),
	caption: "Code snippet for insertionsort written in C."
)

#figure(
	block(width: 5cm, height: 3cm, fill: luma(80%), align(center + horizon, text(size: 90pt, fill: luma(10%), [D]))),
	caption: "This is the last figure."
	) <figureD>

#let abbreviations(dictionary) = {
	block()[
		#set par(
			leading: 1em,
			first-line-indent: 0pt
		)
		#for (abbreviation, word) in dictionary.pairs().sorted() [
			#text(weight: "semibold", abbreviation) #h(0.5em) #word \
		]
	]
}

#set par(first-line-indent: 0pt)

= The Frontmatter

Welcome to the template for the exjobbsreport at EIT! Made by Lucas Ekholm (E22). My motivation for making this is simple: I don't like LaTeX and I love Typst, simple as that.

To start I will introduce some basic concepts. To write in this template you (the writer) only have to do basic styling, everything else is taken care of. The heading above ("The Frontmatter") is of depth 1. All headings inside the the frontmatter have this styling. How do you determine the depth of your heading? Simply by looking at how many "=" appears in the code. The frontmatter in this template only has a level 1 headings. Meaning you can only use "=" for these, all other levels do not have styling. 

Here is an example of some keywords:

#par(first-line-indent: 0pt)[*Keywords* #text([
	#lorem(1), 
	#lorem(2),
	#lorem(3)
	])]

Here is a quote:
#align(center)[
	#quote(block: true, quotes: true, attribution: [Markus Törmänen, spring 2025])[
		To mature as an electrical engineer is to realize everything is about impedances.
	]
]

This is the code used for producing this:

#align(left)[```typst
#par(first-line-indent: 0pt)[*Keywords* #text([
#lorem(1), 
#lorem(2),
#lorem(3)
])]

Here is a quote:
#align(center)[
	#quote(block: true, quotes: true, attribution: [Markus Törmänen, spring 2025])[
		To mature as an electrical engineer is to realize everything is about impedances.
	]
]
```]

As you might have noted there's no caption or numbering on this figure, that's on purpose, also you shouldn't have figures in your frontmatter for you degreeproject :).

The next few pages are examples of how to use the outlines for figures, headings and tables.

#v(10%)

#align(center)[#block(stroke: 1pt, outset: 2em)[Read more about the template/project structure in @intro.]]

#pagebreak()
#outline(title: [Table of Contents], target: heading)

#pagebreak()
#outline(title: [List of Figures], target: figure.where(kind: image))

#pagebreak()
= Abbreviations

Here is an example of how to make a simple abbreviations list.


#align(left)[
	```typst
#let abbreviations(dictionary) = {
	block()[
		#set par(
			leading: 1em,
			first-line-indent: 0pt
		)
		#for (abbreviation, word) in dictionary.pairs().sorted() [
			#text(weight: "semibold", abbreviation) #h(0.5em) #word \
		]
	]
}

#let dict = (:)
#dict.insert("EIT", "Department of Electrical and Information Technology")
#dict.insert("CS", "Department of Computer Science")
#dict.insert("BMT", "Department of Biomedical Engineering")
#dict.insert("EDAA01", "Programming - Second Course")
#dict.insert("EITF80", "Electromagnetic Fields")

#abbreviations(dict)
```]


Which produces (in alphabetical order):

#let dict = (:)
#dict.insert("EIT", "Department of Electrical and Information Technology")
#dict.insert("CS", "Department of Computer Science")
#dict.insert("BMT", "Department of Biomedical Engineering")
#dict.insert("EDAA01", "Programming - Second Course")
#dict.insert("EITF80", "Electromagnetic Fields")

#abbreviations(dict)
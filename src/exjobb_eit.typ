/*
A template of the degreeproject at EIT Lund University by Lucas Ekholm. Made in Typst 0.13
*/

#import "./style.typ" : *

#let doc(
	thesis_title: "A Test of eitExjobb.typ",
	student_name_A: "Student A",
	student_name_B: "Student B",
	email_A: "",
	email_B: "",
	supervisor: "Supervisor",
	examinor: "Examinor",
	company: [Department of Electrical and Information Technology \ Lund University],
	thesis_description: "",
	thesis_keywords: "",
	print: false,
	body
) = {

	//Set rules
	set document(
		title: thesis_title,
		author: (student_name_A, student_name_B),
		description: thesis_description,
		keywords: thesis_keywords,
		date: auto,
	)
	
	set par(
		justify: true, 
		first-line-indent: 8mm, 
		spacing: 1.3em,
		leading: 0.5em
	)

	set page(
		number-align: center + bottom,
		footer-descent: 0% + 7.5mm,
		header-ascent: 0% + 7.5mm
	)

	set page(
		paper: "a4",
		margin: (
			top: (297mm - 200mm)/2,
			bottom: (297mm - 200mm)/2,
			inside: 29.5mm,
			outside: 210mm - 125mm - 29.5mm
			),
		binding: right,
		background: [
			#place(center, dy: 22.5mm)["#thesis_title" - #datetime.today().display("[year]/[month padding:none]/[day padding:none]") - page #context(here().page())]
			#place(horizon, dx: 10mm, rotate(-90deg, "G5 box"))
			#rect(stroke: 0.2mm, width: 169mm, height: 239mm)
		]
	) if print == false

	set page(
		paper: "sis-g5",
	 	margin: (
    		top: (239mm - 200mm)/2,
    		bottom: (239mm - 200mm)/2,
    		inside: 29.5mm,
    		outside: 169mm - 125mm - 29.5mm,
  			),
		binding: right,
	) if print == true
	
	//Text (brödtext)
	set text(font: text_font, weight: "regular", size: size_text, hyphenate: true, lang: "en", ligatures: true)
	set line(length: 100%, stroke: 0.3mm + lth_grey)

	//Figures
	set figure(numbering: figure-numbering)
	show figure.caption: set text(font: secondary_font, weight: "light", size: size_text - 2pt)
	show figure.caption: set block(width: 75%)

	//Equations
	set math.equation(numbering: equation-numbering)
	show math.equation: set text(font: "New Computer Modern Math")

	//Raw text (Code)
	set raw(block: true, align: start, tab-size: 4, theme: "Dawn.tmTheme")
	show raw: set text(font: code_font)
	show raw: set block(fill: luma(240), inset: 10pt, radius: 4pt, width: 100%)
	
	//Outline
	set outline(depth: 2)

	//Level 1 Outline
	show outline.entry.where(level: 1): set outline.entry(fill: [#line()])
	show outline.entry.where(level: 1): set text(weight: "semibold")
	show outline.entry.where(level: 1): set block(above: 5mm)

	//Level 2 Outline
	show outline.entry.where(level: 2): set outline.entry(fill: [#repeat(".", gap: 2mm)])
	show outline.entry.where(level: 2): set block(above: 2.5mm)
	show outline.entry.where(level: 2): set text(weight: "regular")
	
	//Headings
	show heading.where(level: 1): set heading(supplement: [Chapter])
	show heading.where(level: 2): set text(size: size_sub_heading, font: secondary_font, weight: "light")
	show heading.where(level: 2): set block(above: 10mm)
	show heading.where(level: 2): set heading(supplement: [Section])
	show heading.where(level: 3): set text(size: size_sub_sub_heading, font: secondary_font, weight: "light")
	show heading.where(level: 3): set block(above: 7.5mm)
	show heading.where(level: 3): set heading(supplement: [Section])

  	// Main title
	page()[#align(
		center + horizon, 
		box(height: 195mm,
			width: auto,
			stroke: 1pt,
			[
				#text(thesis_title, size: size_heading, font: text_font)
				#v(1cm)
				#text([#student_name_A \ #email_A])
				#v(1cm)
				#text([#company])
				#v(1cm)
				#box(height: 5cm, stroke: 1pt)[
					#text([#supervisor])
					#v(1cm)
					#text([#examinor])
					#v(1cm)
					#text([#datetime.today().display("[month repr:long] [day padding:none], [year]")])
				]
			]
		)
	)]

	//Print page
	page()[
		#set text(size: 10pt)
		#set par(leading: 0.5em)
		#align(bottom + left,
			[
				#sym.copyright #datetime.today().year() \ Printed in Sweden \ Tryckeriet i E-huset, Lund
			]
		)
	]
	body
}
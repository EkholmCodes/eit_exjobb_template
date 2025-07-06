/*A template of the degreeproject at EIT Lund University by Lucas Ekholm.
*/

#import "./style.typ" : *
#import "@preview/headcount:0.1.0": * //used for counters on figures and equations

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
	final: false,
	body
) = {

	//Set rules
	set document(
		title: thesis_title,
		author: "student_name_A, student_name_B",
		description: thesis_description,
		keywords: "",
		date: auto,
	)
	
	set par(
		justify: true, 
		first-line-indent: 8mm, 
		spacing: 1.5em
	)

	set page(
		paper: "a4", //If final is set to true, used for prints
		margin: (
			top: (297mm - 200mm)/2,
			bottom: (297mm - 200mm)/2,
			inside: 29.5mm,
			outside: 210mm - 125mm - 29.5mm
			),
		binding: left,
		number-align: center + bottom,
		footer-descent: 15%,
	) if final == true
	
	set page(
		paper: "a4", //If final is set to false, used for edits
		margin: (
			top: (297mm - 200mm)/2,
			bottom: (297mm - 200mm)/2,
			inside: 210mm - 125mm - 29.5mm,
			outside: 29.5mm
			),
		binding: left,
		number-align: center + bottom,
		footer-descent: 15%,
		header-ascent: 22mm,
		header: align(center)[Exjobbsreport - #datetime.today().display("[year]/[month padding:none]/[day padding:none]") - page #context(here().page())],
		background: [#rect(stroke: 0.5pt, width: 169mm, height: 239mm)]
	) if final == false
	
	set text(font: "Adobe Garamond", weight: "regular", size: size_text)
	set figure(numbering: dependent-numbering("1.1", levels: 1))
	set math.equation(numbering: dependent-numbering("(1.1)", levels: 1))

	//Raw text (Code)
	set raw(block: true, align: start, tab-size: 4, theme: "Dawn.tmTheme")
	show raw.where(block: true): block.with(
  		fill: luma(245),
  		inset: 10pt,
  		radius: 4pt,
  		width: 100%
	)
	
	set outline(depth: 2)
	//Level 1 Outline
	show outline.entry.where(level: 1): set outline.entry(fill: [#line(length: 100%, stroke: 0.2mm)])
	show outline.entry.where(level: 1): it => {
		set text(weight: "bold")
		set block(above: 5mm)
		it
	}

	//Level 2 Outline
	show outline.entry.where(level: 2): set outline.entry(fill: [#repeat(".", gap: 5pt)])
	show outline.entry.where(level: 2): it => {
		set block(above: 2.5mm)
		set text(weight: "regular")
		it
	}

	show heading.where(level: 1): reset-counter(figure.where(kind: "code"), levels: 2)

	//Level 2 and 3 headings
	show heading.where(level: 2): it => {
		set text(size: size_sub_heading, font: "Frutiger LT Std", weight: "light")
		set block(above: 7.5mm)
		it
	}

	show heading.where(level: 3): it => { set text(size: size_sub_sub_heading, font: "Frutiger LT Std", weight: "light")
	set block(above: 7.5mm)
	it
	}

  	// Main title
	page()[#align(
		center + horizon, 
		box(height: 195mm,
			width: auto,
			stroke: 1pt,
			[
				#text(thesis_title, size: size_heading, font: "Adobe Garamond")
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
		#align(bottom + left,
			[
				#sym.copyright #datetime.today().year() \ Printed in Sweden \ Tryckeriet i E-huset, Lund
			]
		)
	]
	body
}
/*
A template of the degreeproject at EIT Lund University by Lucas Ekholm. Made in Typst 0.13
*/

#import "./style.typ" : *

#let doc(
	title: [Title],
	authors: (),
	supervisor: none,
	examinor: none,
	company: none,
	front_images: (),
	description: none,
	keywords: none,
	print: false,
	body
) = {

	//Set rules
	set document(
		title: title,
		author: authors.map(author => author.name),
		description: description,
		keywords: keywords,
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
			#place(center, dy: 22.5mm)[
			"#title" - #datetime.today().display("[year]/[month padding:none]/[day padding:none]") - page #context(counter(page).get().at(0)) - #sym.hash#context(here().page())]
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
	show outline.entry.where(level: 1): set outline.entry(fill: [#align(center, line(length: 95%))])
	show outline.entry.where(level: 1): set text(weight: "semibold")
	show outline.entry.where(level: 1): set block(above: 5mm)

	//Level 2 Outline
	show outline.entry.where(level: 2): set outline.entry(fill: [#align(center, block(width: 95%, repeat(".", gap: 2mm)))])
	show outline.entry.where(level: 2): set block(above: 3mm)
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
	page([
		#set align(center + horizon)
		#set block(above: 0pt, below: 0pt, stroke: 0pt + red)
		#text(size: size_heading, weight: "semibold", title)
		#v(2cm)
		#stack(dir: ttb, spacing: 1cm,
			stack(dir: ltr, spacing: 1cm,
				..authors.map(author => [
					#stack(dir: ttb, spacing: 3mm,
					author.name,
					author.affiliation,
					emph(author.email)
						)
					])
				),
			stack(dir: ttb, spacing: 5mm, [Department of Electrical and Information Technology \ Lund University], company),
			stack(dir: ttb, spacing: 5mm,
				if (supervisor == none){none} else {[Supervisor: #supervisor]}, 
				if (examinor == none){none} else {[Examinor: #examinor]}, datetime.today().display("[month repr:long] [day padding:none], [year]"),
				)
		)
		#set align(center + bottom)
		#grid(column-gutter: 1cm, columns: front_images.len(), ..front_images.map(img => image(img, fit: "contain", height: 3cm)))
	])
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
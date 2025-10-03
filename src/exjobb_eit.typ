/*
A template of the degreeproject at EIT Lund University by Lucas Ekholm. Made in Typst 0.13
*/

#import "./style.typ" : *

//Document state, can be used for formatting different contextual parts
#let doc-state = state("doc", none)

//Helper functions, to keep the main file clean
#let frontmatter(body) = {
	doc-state.update("front")
	set pagebreak(weak: true, to: "odd")
	set page(numbering: "i")
	set heading(outlined: false, bookmarked: true)
	body
}

#let mainmatter(body) = {
	pagebreak()
	doc-state.update("main")
	counter(heading).update(0)
	counter(page).update(1)
	set page(numbering: "1", header: header(), footer: footer())
	set heading(numbering: chapter-numbering, outlined: true)
	body
}

#let backmatter(body) = {
	doc-state.update("back")
	counter(heading).update(0)
	set pagebreak(to: none)
	set heading(numbering: "A.1")
	set figure(numbering: appendix-figure-numbering)
	show heading.where(level: 1): set heading(supplement: [Appendix])
	body
}

//Function for resetting counters with new chapters
#let reset-counters() = {
	counter(figure.where(kind:table)).update(0)
	counter(figure.where(kind:raw)).update(0)
	counter(math.equation).update(0)
}

//Custom captions
#let in-outline = state("in-outline", false)
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }

//Template function
#let doc(
	title: [Title],
	short-title: none,
	authors: (),
	supervisors: (),
	examinor: none,
	affiliations: (),
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
		first-line-indent: 1cm, 
		spacing: 1.4em,
		leading: 0.5em
	)

	set page(
		number-align: center + bottom,
		footer-descent: 0% + 7.5mm,
		header-ascent: 0% + 7.5mm
	)

	//Gives an a4 page but with margins matching G5
	set page(
		paper: "a4",
		margin: (
			top: (297mm - 200mm)/2,
			bottom: (297mm - 200mm)/2,
			inside: 29.5mm + 5.5mm,
			outside: 210mm - 125mm - 29.5mm - 5.5mm
			),
		binding: left,
	)

	set page(
		binding: right,
		background: [
			#set text(size: 12pt)
			#place(center, dy: 22.5mm)[
			"#short-title" - #datetime.today().display("[year]/[month padding:none]/[day padding:none]") - page #context(counter(page).get().at(0)) - #sym.hash#context(here().page())]
			#place(horizon, dx: 10mm, rotate(-90deg, "G5 box"))
			#rect(stroke: 0.2mm, width: 169mm, height: 239mm)
		]) if print == false
	
	//Text (brödtext)
	set text(font: text_font, fill: text_grey, weight: "regular", size: size_text, hyphenate: true, lang: "en", ligatures: true, bottom-edge: "baseline", top-edge: "cap-height", number-type: "lining")
	set line(length: 100%, stroke: (thickness: 0.5pt, paint: lth_grey, cap: "round"))

	//Footnotes
	show footnote.entry: set text(fill: caption_grey)
	set footnote.entry(separator: line(length: 30%, stroke: 0.5pt + caption_grey), gap: 0.8em)

	//Figures
	set figure(numbering: figure-numbering)
	show figure.caption: set text(font: secondary_font, weight: "light", size: size_text - 2pt)
	show figure.caption: set block(width: 75%)

	//Equations
	set math.equation(numbering: equation-numbering)
	show math.equation: set text(font: math_font)

	//Raw text (Code)
	set raw(block: true, align: start, tab-size: 4, theme: "Dawn.tmTheme")
	show raw: set text(font: code_font)
	show raw: set block(fill: luma(90%), inset: 10pt, radius: 4pt, width: 100%)

	//Bibliography
	show bibliography: it => {
		show heading: front-matter-heading
		it
	}

	//Outline
	set outline(depth: 2)
	show outline.entry.where(level: 1): set outline.entry(fill: [#align(center, line(stroke: text_grey, length: 100% - 5mm))])
	show outline.entry.where(level: 1): set text(weight: "semibold")
	show outline.entry.where(level: 1): set block(above: 5mm)
	show outline.entry.where(level: 2): set outline.entry(fill: [#align(center, block(width: 100% - 5mm, repeat(".", gap: 2mm)))])
	show outline.entry.where(level: 2): set block(above: 3mm)
	show outline.entry.where(level: 2): set text(weight: "regular")
	show outline: it => {
	  in-outline.update(true)
	  it
	  in-outline.update(false)
	}
	
	//Headings
	show heading.where(level: 1): set heading(supplement: [Chapter])
	show heading.where(level: 2): set text(size: size_sub_heading, font: secondary_font, fill: heading_grey,  weight: "light")
	show heading.where(level: 2): set block(above: 10mm)
	show heading.where(level: 2): set heading(supplement: [Section])
	show heading.where(level: 3): set text(size: size_sub_sub_heading, fill: heading_grey, font: secondary_font, weight: "light")
	show heading.where(level: 3): set block(above: 7.5mm)
	show heading.where(level: 3): set heading(supplement: [Section])

	//Figures out which heading to place depending on the state of the document
	show heading.where(level: 1): it => {
		reset-counters()
		if doc-state.get() == "front"{
			front-matter-heading(it)
		}
		if doc-state.get() == "main"{
			chapter-heading(it)
		}
		if doc-state.get() == "back"{
			appendix-heading(it)
		}
	}

  	//Main title page
	page([
		#set align(bottom + center)
		#set stack(dir: ttb)
		#set block(above: 0pt, below: 0pt, stroke: 0pt + red)
		
		#stack(spacing: 2cm,
			text(size: size_heading, weight: "regular", title),
				stack(spacing: 1.2cm,
					align(top, stack(dir: ltr, spacing: 1cm,
						..authors.map(author => [
							#stack(spacing: 3mm, 
								author.name, 
								if (author.affiliation == none){v(3mm)} else {author.affiliation},
								emph(author.email)
							)
						])
					)),
					stack(dir: ttb, spacing: 5mm, ..affiliations),
					stack(dir: ttb, spacing: 5mm, ..supervisors,
						if (examinor == none){v(5mm)} else {[Examinor: #examinor]},
					),
					datetime.today().display("[month repr:long] [day padding:none], [year]")
				),
			grid(column-gutter: 1cm, columns: front_images.len(), ..front_images.map(img => image(img, fit: "contain", height: 3cm)))
		)
	])
	//Print page
	page()[
		#set par(leading: 0.5em)
		#align(bottom + left,
			[
				#sym.copyright #datetime.today().year() \ Printed in Sweden \ Tryckeriet i E-huset, Lund
			]
		)
	]
	counter(page).update(1)
	body
}
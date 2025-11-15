/*
A template of the degreeproject at EIT Lund University by Lucas Ekholm (E22). Made in Typst 0.14.0

Copyright © 2025 Lucas Ekholm

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

//---------------------------------------------|	TEXT AND COLOR DEFINITIONS	|---------------------------------------------

//Text sizes
#let size_main = 10pt
#let size_secondary = 8pt
#let size_heading = 16pt
#let size_sub_heading = 14pt
#let size_sub_sub_heading = 12pt
#let size_chapter_nbr = 1.5cm

//Fonts
#let font_main = "EB Garamond"
#let font_secondary = "Lato"
#let font_chapter_nbr = "Libertinus Math"
#let font_code = "Source Code Pro"
#let font_math = "Libertinus Math"

//Colors
#let lth_bronze = cmyk(9%, 57%, 100%, 41%)
#let lth_blue = cmyk(100%, 85%, 5%, 22%)
#let lth_grey = cmyk(0%, 0%, 15%, 85%)

#let grey_main = luma(5%)
#let grey_secondary = luma(30%)
#let grey_heading = lth_grey
#let grey_tertiary = luma(20%)

//---------------------------------------------|	STYLINGS	|---------------------------------------------

//Logic for numbering
#let chapter-numbering(.. n) = {
	let numbers = n.pos()

	if numbers.len() == 1 {
			numbering("1", ..numbers)
		} else {
			numbering("1.1", ..numbers) 
		}
}
#let figure-numbering(n) = numbering("1.1", counter(heading).get().first(), n)
#let equation-numbering(n) = numbering("(1.1)", counter(heading).get().first(), n)
#let appendix-figure-numbering(n) = numbering("A.1", counter(heading).get().first(), n)
#let appendix-equation-numbering(n) = numbering("(A.1)", counter(heading).get().first(), n)

//Footer
#let footer() = {
	set text(font: font_secondary, size: size_secondary)
	context {
		let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == here().page())
		if(has-heading){align(center)[#counter(page).display()]}
		else{none}
	}
}

//Header, from the original LaTeX template
#let header() = {
	set par(spacing: 0pt)
	set text(font: font_secondary, size: size_secondary)
	context {
		let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == here().page())
		if(has-heading){none}
		else{
			let heading = query(selector(heading.where(level: 1)).before(here())).last()
			if calc.even(counter(page).get().at(0)) {
				box(width: 100%)[
					#text(font: font_chapter_nbr, counter(page).display())
					#h(1fr)
			    	#text(heading.body)
			    	]
			} else {
				box(width: 100%)[
			    	#text(heading.body)
			    	#h(1fr)
			    	#text(font: font_chapter_nbr, counter(page).display())
			    ]
			}
			v(2mm)
			line()
		}
	}
}

//A simplified header style, made for this template
#let header-simple() = {
	set par(spacing: 0pt)
	set text(font: font_secondary, size: size_secondary)
	context {
		let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == here().page())
		if(has-heading){none}
		else{
			let heading = query(selector(heading.where(level: 1)).before(here())).last()
			if calc.even(counter(page).get().at(0)) {
				set align(left)
				stack(dir: ltr, spacing: 1em, 
					text(counter(page).display()), 
					[|],
					text(heading.body))
			} else {
				set align(right)
				stack(dir: rtl, spacing: 1em, 
					text(counter(page).display()), 
					[|], 
					text(heading.body))
			}
		}
	}
}

//Heading stylings
#let front-matter-heading(it) = {
	pagebreak(weak: true, to: "odd")
	set text(fill: grey_heading, hyphenate: false, size: size_heading, font: font_secondary, weight: "regular")
	set align(right)
	v(22.5pt + size_chapter_nbr)
	block(below: 15mm)[
		#stack(dir: ttb, spacing: 7.5mm, line(), it.body, line())
	]
}
#let chapter-heading(it) = {
	pagebreak(weak: true, to: "odd")
	set text(font: font_secondary, weight: "regular",fill: grey_heading, hyphenate: false)
	set align(right)
	v(size_chapter_nbr)
	block(below: 15mm)[
		#stack(dir: ttb, spacing: 7.5mm,
			[#box(width: 1fr, line()) #box([#text(size: size_main, it.supplement)
			#text(size: size_chapter_nbr, font: font_chapter_nbr, weight: "regular", counter(heading).display(it.numbering))])],
			text(size: size_heading, it.body),
			line()
		)
	]
}

#let figure-caption(it) = {
	set text(font: font_secondary, weight: "regular", size: size_secondary)
	block(width: 75%)[
		#strong([#it.supplement #context{it.counter.display(it.numbering)}#it.separator])
		#text(fill: grey_secondary, it.body)
	]
}

//Document state, can be used for formatting different contextual parts
#let doc-state = state("doc", none)

//Helper functions, to keep the main file clean. Use for example "#show: mainmatter" to begin the main part of the document.
#let frontmatter(body) = {
	set page(numbering: "i")
	set heading(outlined: false, bookmarked: true)
	doc-state.update("front")
	body
}

#let mainmatter(body) = {
	pagebreak(weak: true, to: "odd")
	set page(numbering: "1", header: header-simple(), footer: footer())
	set heading(numbering: chapter-numbering, outlined: true)
	counter(page).update(1)
	counter(heading).update(0)
	doc-state.update("main")
	body
}

#let backmatter(body) = {
	set heading(numbering: "A.1")
	set figure(numbering: appendix-figure-numbering)
	show heading.where(level: 1): set heading(supplement: [Appendix])
	counter(heading).update(0)
	doc-state.update("back")
	body
}

//Function for resetting counters for new chapters
#let resetCounters() = {
	counter(figure.where(kind: table)).update(0)
	counter(figure.where(kind: raw)).update(0)
	counter(figure.where(kind: image)).update(0)
	counter(math.equation).update(0)
}

//Custom captions
#let in-outline = state("in-outline", false)
#let flexCaption(long, short) = context if in-outline.get() { short } else { long }

#let outline-entry(it) = {
	context {
    	if it.element.has("kind") {
      		let loc = it.element.location()
	      	if counter(figure.where(kind: it.element.kind)).at(loc).first() == 1 {v(1em)}
	      	block(above: 1em,
		    	link(loc,
		          box(strong(it.prefix().children.at(2)), width: 7.5mm)
		          + it.body()
		          + box([#align(center, block(width: 100% - 5mm, repeat(".", gap: 2mm)))], width: 1fr)
		          + it.page()
		        )
		    )
	    } 
	    else {
	      it
	    }
	}
}

//---------------------------------------------|	DOCUMENT TEMPLATE	|---------------------------------------------

//Template function
#let doc(
	title: [Title],
	short-title: [Short title],
	authors: (),
	supervisors: (),
	examinor: none,
	affiliations: (),
	front_images: (),
	description: none,
	keywords: (),
	print: false,
	date: datetime.today(),
	body
) = {

	//Set rules
	set document(
		title: title,
		author: authors.map(author => author.name),
		description: description,
		keywords: keywords
	)
	
	set par(
		justify: true, 
		first-line-indent: 1cm, 
		spacing: 1.5em,
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
		numbering: none
	)

	set page(
		binding: right,
		background: [
			#set text(size: 12pt)
			#place(center, dy: 22.5mm)[
			#emph(short-title) - #date.display("[year]/[month padding:none]/[day padding:none]") - page #context(counter(page).display()) - #sym.hash#context(here().page())]
			#rect(stroke: 0.2mm, width: 169mm, height: 239mm)
		]) if print == false
	
	//Text
	set text(font: font_main, fill: grey_main, weight: "regular", size: size_main, hyphenate: true, lang: "en", ligatures: true, bottom-edge: "baseline", top-edge: "cap-height", number-type: "lining")
	set strong(delta: 300)
	set line(length: 100%, stroke: (thickness: 0.75pt, paint: grey_tertiary, cap: "round"))

	//Footnotes
	show footnote.entry: set text(fill: grey_secondary)
	set footnote.entry(separator: line(length: 30%, stroke: 0.5pt + grey_secondary), gap: 0.8em)

	//Figures
	set figure(numbering: figure-numbering)
	show figure.where(kind: table): set figure.caption(position: top)
	show figure.caption: it => figure-caption(it)

	//Tables
	//show table: set text(font: font_secondary)
	show table.cell.where(y: 0): strong
	set table(
	  stroke: (x, y) => if y == 0 {
	    (bottom: 0.75pt + lth_grey)
	  },
	  align: (x, y) => (
	    if x > 0 { center }
	    else { left }
	  )
)

	//Equations
	set math.equation(numbering: equation-numbering)
	show math.equation: set text(font: font_math)

	//Raw text (Code)
	set raw(align: start, tab-size: 4, theme: "Dawn.tmTheme")
	show raw: set text(font: font_code, tracking: -0.25pt)
	show raw: set block(inset: 5mm, width: 100%)
	show raw.where(block: true): it => {
		show raw.line: line => {
  			box(
    			width: 100%,
    			fill: if calc.rem(line.number, 2) == 0 { luma(96%) } else { white },
    			[#text(fill: luma(50%), str(line.number)) #h(1cm) #line.body]
  			)
		}
		it
	}
	//Bibliography
	show bibliography: it => {
		set bibliography(style: "ieee")
		show heading: front-matter-heading
		it
	}

	//Outline
	set outline(depth: 2, indent: 1em)
	show outline.entry.where(level: 1): set outline.entry(fill: [#align(center, line(stroke: grey_main, length: 100% - 5mm))])
	show outline.entry.where(level: 1): strong
	show outline.entry.where(level: 1): set block(above: 2em)
	show outline.entry.where(level: 2): set outline.entry(fill: [#align(center, block(width: 100% - 5mm, repeat(".", gap: 2mm)))])
	show outline.entry.where(level: 2): set block(above: 1em)
	
	//Outline for figures, equations, etc.
	show outline: it => {
	  in-outline.update(true)
	  it
	  in-outline.update(false)
	}
	show outline.entry: it => outline-entry(it)
	
	//Headings
	show heading: set text(font: font_secondary, fill: grey_heading,  weight: "regular")
	show heading: set heading(supplement: [Section])
	show heading.where(level: 1): set heading(supplement: [Chapter])
	show heading.where(level: 2): set block(above: 2em, below: 1em)
	show heading.where(level: 2): set text(size: size_sub_heading)
	show heading.where(level: 3): set block(above: 1.5em, below: 1em)
	show heading.where(level: 3): set text(size: size_sub_sub_heading)

	//Figures out which heading to place depending on the state of the document
	show heading.where(level: 1): it => {
		resetCounters()
		if doc-state.get() == "front"{
			front-matter-heading(it)
		}
		if doc-state.get() == "main" or doc-state.get() == "back"{
			chapter-heading(it)
		}
	}

	//Quotes
	set quote(block: true)
	show quote: set block(inset: 2.5mm)

  	//Main title page
	page([
		#set align(horizon + center)
		#set stack(dir: ttb)
		#set block(above: 0pt, below: 0pt, stroke: 0pt + red)
		#set line(length: 90%)
		#set grid(stroke: 0pt)
		#set text(size: 11pt, hyphenate: false)
		#grid(columns: (1fr), rows: (0.5fr, 1.25fr, 0.5fr, 1fr, 1fr, 1fr, 1.25fr, 1fr),
			none,
			{
				set par(leading: 1em)
				block(width: 90%, stack(spacing: 1fr, line(), text(size: 18pt, font: font_secondary, weight: "semibold", title), line()))
			},
			none,
			block(align(top, stack(dir: ltr, spacing: 1cm,
				..authors.map(author => [
					#stack(spacing: 3mm, 
						author.name, 
						if (author.affiliation == none){v(3mm)} else {author.affiliation},
						if (author.email == none){v(3mm)} else {emph(author.email)}
					)
				])
			))),
			stack(spacing: 5mm, ..affiliations),
			stack(spacing: 5mm, ..supervisors, if (examinor == none){v(5mm)} else {[Examinor: #examinor]},
			),
			date.display("[month repr:long] [day padding:none], [year]"),
			if front_images.len() != 0 
			{
				grid(column-gutter: 1cm, columns: front_images.len(), ..front_images.map(img => image(img, fit: "contain", height: 1fr)))} else {v(6cm)}
		)
	])

	//Print page
	page()[
		#set par(leading: 0.5em)
		#place(bottom + left, [This thesis is typeset using Typst #sys.version \ \ #sym.copyright #date.year() \ Printed in Sweden \ Tryckeriet i E-huset, Lund])
	]
	//Beginning of document
	counter(page).update(1)
	body
}
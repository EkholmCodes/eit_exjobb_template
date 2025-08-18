#let size_heading = 18pt
#let size_chapter = 32pt
#let size_sub_heading = 14pt
#let size_sub_sub_heading = 12pt
#let size_text = 10pt

#let text_font = "Adobe Garamond"
#let secondary_font = "Frutiger LT Std"
#let chapter_font = "CMU Serif"
#let code_font = "Source Code Pro"

#let lth_bronze = rgb(156, 97, 20)
#let lth_grey = luma(30%) //rgb(77, 76, 68)

#let reset-counters() = {
	counter(figure.where(kind:table)).update(0)
	counter(figure.where(kind:raw)).update(0)
	counter(math.equation).update(0)
}

#let chapter-numbering(.. n) = {
	let numbers = n.pos()

	if numbers.len() == 1 {
			numbering("1", ..numbers)
		} else {
			numbering("1.1", ..numbers) 
		}
}

#let figure-numbering(n) = numbering("1.1", counter(heading).get().first(), n)
#let appendix-figure-numbering(n) = numbering("A.1", counter(heading).get().first(), n)

#let equation-numbering(n) = numbering("(1.1)", counter(heading).get().first(), n)
#let appendix-equation-numbering(n) = numbering("(A.1)", counter(heading).get().first(), n)

#let footer() = {
	context {
		let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == here().page())
		if(has-heading){
			align(center)[#counter(page).display()]
		}
		else{
			none
		}
	}
}

#let header() = {
	set text(size: size_text - 1pt, font: secondary_font, weight: "light")
	set par(spacing: 0pt)
	context {
		let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == here().page())
		if(has-heading){
			none
		}
		else{
			let heading = query(selector(heading.where(level: 1)).before(here())).last()
			if calc.even(counter(page).get().at(0)) {
				box(width: 100%)[
					#counter(page).display()
					#h(1fr)
			    	#heading.body
			    ]
			} else {
			    box(width: 100%)[
			    	#heading.body
			    	#h(1fr)
			    	#counter(page).display()
			    ]
			}
			v(0.5em)
			line()
		}
	}
}

#let front-matter-heading(it) = {
	pagebreak()
	reset-counters()
	set align(right)
	v(20mm)
	block(below: 15mm)[
		#block()[
			#line()
		]
		#v(0.5mm)
		#block()[
			#text(size: 18pt, font: secondary_font, weight: "light", fill: lth_grey, it.body)
		]
		#v(0.5mm)
		#block()[
		#line()
		]
	]
}

#let chapter-heading(it) = {
	pagebreak()
	reset-counters()
	set text(fill: lth_grey, hyphenate: false)
	set align(right)
	set par(leading: 0.3em)
	//set box(stroke: 1pt)
	//set block(stroke: 1pt)
	v(20mm - size_chapter)
	block(below: 15mm)[
		#box()[
			#box(width: 1fr, line())
			#box(width: auto, [
				#text(size: size_text, font: chapter_font, weight:  "regular", "Chapter") 
				#text(size: size_chapter, font: chapter_font, weight: "regular", counter(heading).display(it.numbering))])
			#v(5mm)
		]
		#box()[#text(size: size_heading, font: secondary_font, weight: "light", it.body) #v(5mm)]
		#box()[#line()]
	]
}

#let appendix-heading(it) = {
	pagebreak()
	reset-counters()
	set text(fill: lth_grey)
	set block(spacing: 0pt)
	set align(right)
	v(20mm - size_chapter)
	block(below: 15mm)[
		#block()[
			#box(width: 1fr, line(length: 100%))
			#box(width: auto, [
				#text(size: size_text, font: secondary_font, weight: "regular", "Appendix") 
				#text(size: size_chapter, font: text_font, weight: "regular", counter(heading).display(it.numbering))
			])
		]
		#v(7mm)
		#block()[#text(size: size_heading, font: secondary_font, weight: "light", it.body)]
		#v(7mm)
		#block()[#line()]
	]
}
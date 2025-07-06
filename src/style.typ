#let size_heading = 18pt
#let size_chapter = 32pt
#let size_sub_heading = 14pt
#let size_sub_sub_heading = 12pt
#let size_text = 10pt

#let chapter-numbering(.. n) = {
	let numbers = n.pos()

	if numbers.len() == 1 {
			numbering("1", ..numbers)
		} else {
			numbering("1.1", ..numbers) 
		}
}
#let figure-numbering(.. n) = {
	let hdr = counter(heading).get().first()
	let num = query(selector(heading).before(here())).last().numbering
	numbering(num, hdr, n.pos().first())
}

#let equation-numbering(n) = {
	numbering("(1.1)", counter(heading).get().at(0), n)
}

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
	set text(size: size_text, font: "Frutiger LT std", weight: "light")
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
			v(-1em)
			line(length: 100%, stroke: 0.2mm)
		}
	}
}

#let front-matter-heading(it) = {
	pagebreak()
	set align(right)
	v(2.5cm)
	block()[
		#block()[
			#line(length: 100%)
		]
		#v(0.5mm)
		#block()[
			#text(size: 18pt, font: "Frutiger LT std", weight: "light", it.body)
		]
		#v(0.5mm)
		#block()[
		#line(length: 100%)
		]
	]
	v(15mm)
}

#let chapter-heading(it) = {
	pagebreak()
	set block(spacing: 0pt, stroke: 0pt)
	set align(right)
	v(25mm - size_chapter)
	block()[
		#block()[
			#box(width: 1fr, line(length: 100%))
			#box(width: auto, [
				#text(size: size_text, font: "Frutiger LT Std", weight: "light", "Chapter") 
				#text(size: size_chapter, font: "Times New Roman", weight: "thin", counter(heading).display(it.numbering))
			])
		]
		#v(7mm)
		#block()[#text(size: size_heading, font: "Frutiger LT Std", weight: "light", it.body)]
		#v(7mm)
		#block()[#line(length: 100%)]
	]
	v(15mm)
}

#let appendix-heading(it) = {
	counter(figure).update(0)
	set block(spacing: 0pt, stroke: 0pt)
	set align(right)
	v(25mm - size_chapter)
	block()[
		#block()[
			#box(width: 1fr, line(length: 100%))
			#box(width: auto, [
				#text(size: size_text, font: "Frutiger LT Std", weight: "light", "Appendix") 
				#text(size: size_chapter, font: "Adobe Garamond", weight: "regular", counter(heading).display(it.numbering))
			])
		]
		#v(7mm)
		#block()[#text(size: size_heading, font: "Frutiger LT Std", weight: "light", it.body)]
		#v(7mm)
		#block()[#line(length: 100%)]
	]
	v(15mm)
}
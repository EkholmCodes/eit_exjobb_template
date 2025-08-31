#let size_heading = 18pt
#let size_chapter_nbr = 32pt
#let size_sub_heading = 14pt
#let size_sub_sub_heading = 12pt
#let size_text = 10pt

#let text_font = "Adobe Garamond Pro"
#let secondary_font = "Frutiger LT Std"
#let chapter_font = "Georgia Pro"
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

#let equation-numbering(n) = numbering("(1.1)", counter(heading).get().first(), n)

#let appendix-figure-numbering(n) = numbering("A.1", counter(heading).get().first(), n)

#let appendix-equation-numbering(n) = numbering("(A.1)", counter(heading).get().first(), n)

#let footer() = {
	set text(font: chapter_font)
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
					#text(font: chapter_font, counter(page).display())
					#h(1fr)
			    	#text(font: secondary_font, weight: "light", [#heading.body])
			    	]
			} else {
				box(width: 100%)[
			    	#text(font: secondary_font, weight: "light", [#heading.body])
			    	#h(1fr)
			    	#text(font: chapter_font, counter(page).display())
			    ]
			}
			v(2mm)
			line()
		}
	}
}

#let front-matter-heading(it) = {
	pagebreak()
	reset-counters()
	set text(fill: lth_grey, hyphenate: false)
	set align(right)
	v(22.5pt + size_chapter_nbr)
	block(below: 15mm)[
		#stack(dir: ttb, spacing: 7mm, line(), text(size: size_heading, font: secondary_font, weight: "light", it.body), line())
	]
}

#let chapter-heading(it) = {
	pagebreak()
	reset-counters()
	set text(fill: lth_grey, hyphenate: false)
	set align(right)
	v(size_chapter_nbr)
	block(below: 15mm)[
		#stack(dir: ttb, spacing: 7mm,
			[#box(width: 1fr, line()) #text(size: size_text, font: chapter_font, weight:  "regular", "Chapter")
			#text(size: size_chapter_nbr, font: chapter_font, weight: "light", counter(heading).display(it.numbering))],
			text(size: size_heading, font: secondary_font, weight: "light", it.body),
			line()
		)
	]
}

#let appendix-heading(it) = {
	pagebreak()
	reset-counters()
	set text(fill: lth_grey, hyphenate: false)
	set align(right)
	v(size_chapter_nbr)
	block(below: 15mm)[
		#stack(dir: ttb, spacing: 7mm,
			[#box(width: 1fr, line()) #text(size: size_text, font: chapter_font, weight:  "regular", "Appendix")
			#text(size: size_chapter_nbr, font: chapter_font, weight: "regular", counter(heading).display(it.numbering))],
			text(size: size_heading, font: secondary_font, weight: "light", it.body),
			line()
		)
	]
}
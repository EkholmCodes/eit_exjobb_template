/*
A template of the degreeproject at EIT (Electrical and Information Technology) Lund University by Lucas Ekholm (E22).

Made in Typst 0.14.2

Copyright © 2025 Lucas Ekholm

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#let template_version = version(1) // Change when changes are made to the template, used to distinguish from original

//---------------------------------------------|	TEXT AND COLOR DEFINITIONS	|---------------------------------------------

//Text sizes
#let size_main = 10pt
#let size_secondary = size_main * 0.9
#let size_heading = size_main * 1.6
#let size_sub_heading = size_main * 1.4
#let size_sub_sub_heading = size_main * 1.2
#let size_chapter_nbr = size_main * 4

//Fonts
#let font_main = "EB Garamond"
#let font_secondary = "Lato"
#let font_chapter_nbr = font_main //ta bort?
#let font_code = "Source Code Pro"
#let font_math = "Libertinus Math"

//Colours, not used in the template but are available
#let lth_bronze = cmyk(9%, 57%, 100%, 41%)
#let lth_blue = cmyk(100%, 85%, 5%, 22%)
#let lth_grey = cmyk(0%, 0%, 15%, 85%)

//Text colours
#let colour_main = black
#let colour_secondary = lth_grey
#let colour_heading = colour_main
#let colour_tertiary = luma(20%)

//States
//Heading state, used for which style of heading to be used
//#let _ = state("heading", none)
//#let _ = state("header", none)

//Outline state, used for the flexCaption function
#let in-outline = state("in-outline", false)

//---------------------------------------------|	STYLINGS	|---------------------------------------------

//Logic for numbering
#let chapternumbering(.. n) = {
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

//Helper function for various elements
#let has-heading() = {
  return (query(heading.where(level: 1)).any(it => it.location().page() == here().page()))
}

//Footer
#let front_footer() = {
  set align(center)
  set text(font: font_secondary, size: size_secondary)
  context counter(page).display()
}

#let main_footer() = {
  set align(center)
	set text(font: font_secondary, size: size_secondary)
	context {
		if(has-heading()){counter(page).display()}
		else{none}
	}
}

//Header
//From the original LaTeX template
#let header-original() = {
  set par(spacing: 0pt)
  set text(font: font_secondary, size: size_secondary)
  context {
    if(has-heading()){none}
    else{
      let heading = query(selector(heading.where(level: 1)).before(here())).last()
      if calc.even(counter(page).get().first()) {
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
  let print(alignment, direction, heading) = {
    set align(alignment)
    stack(dir: direction, spacing: 1em, 
      text(counter(page).display()), 
      [|],
      text(heading.body))
  }
  context {
    if(has-heading()){none}
    else{
      let heading = query(selector(heading.where(level: 1)).before(here())).last()
      if calc.even(counter(page).get().first()) {
        print(left, ltr, heading)
      } else {
        print(right, rtl, heading)
      }
    }
  }
}

#let header-alternating() = {
  set par(spacing: 0pt)
  set text(font: font_secondary, size: size_secondary)
  let print(alignment, direction, body) = {
    set align(alignment)
    stack(dir: direction, spacing: 1em, 
      text(counter(page).display()), 
      [|],
      text(body))
  }
  context {
    if(has-heading()){none}
    else{
      let heading1 = query(selector(heading.where(level: 1)).before(here())).last()
     let heading2 = query(selector(heading.where(level: 2)).before(here())).last()
      if calc.even(counter(page).get().first()) {
        print(left, ltr, heading1.body)
      } else {
        print(right, rtl, document.title)
      }
    }
  }
}

//Heading stylings
#let heading-original(it) = {
  pagebreak(weak: true, to: "odd")
  set text(
    font: font_secondary,
    weight: "regular",
    fill: colour_heading,
    hyphenate: false
  )
  set align(right)
  set block(below: 15mm)
  let has-numbering = it.numbering != none
  if true {
    v(size_chapter_nbr)
    block()[
      #stack(dir: ttb, spacing: 7.5mm,
        [#box(width: 1fr, line()) #box([
            #if has-numbering {
              text(size: size_main, it.supplement)
            }
        #text(size: size_chapter_nbr, font: font_chapter_nbr, weight: "regular", 
          if it.numbering != none {counter(heading).display(it.numbering)})])],
        text(size: size_heading, it.body),
        line()
      )
    ]
  }
}

#let heading-modified(it) = {
  pagebreak(weak: true, to: "odd")
  set text(
    font: font_main,
    fill: colour_heading,
    hyphenate: false
  )
  set align(center)
  set par(leading: 1em)
  set block(width: 100%, height: 3cm, below: 3cm)
  block(align(bottom)[
    #text(size: size_sub_sub_heading)[#if it.numbering != none [#it.supplement #counter(heading).display(it.numbering)]] \ \
    #text(size: size_heading, it.body)
  ]) 
}

//Figure captions
#let figure-caption(it) = {
  set text(font: font_secondary, size: size_secondary)
  block(width: 75%)[
    #strong([#it.supplement #context{it.counter.display(it.numbering)}#it.separator])
    #text(fill: colour_secondary)[#it.body]
  ]
}

//Helper functions, to keep the main file clean. Use for example "#show: mainmatter" to begin the main part of the document.
#let frontmatter(body) = {
  set page(numbering: "i", header: none, footer: front_footer())
  set heading(outlined: false, bookmarked: true)
  body
}

#let mainmatter(body) = {
  pagebreak(weak: true, to: "odd")
  set heading(numbering: chapternumbering, outlined: true)
  set page(header: context state("header").get(), numbering: "1", footer: main_footer())
  counter(page).update(1)
  counter(heading).update(0)
  body
}

#let backmatter(body) = {
	set heading(numbering: "A.1")
	set figure(numbering: appendix-figure-numbering)
	show heading.where(level: 1): set heading(supplement: [Appendix])
	counter(heading).update(0)
	body
}

//Function for resetting counters for new chapters. Called everytime a chapter is started with a show rule. If adding new kinds of figures, include a reset here
#let resetCounters() = {
	counter(figure.where(kind: table)).update(0)
	counter(figure.where(kind: raw)).update(0)
	counter(figure.where(kind: image)).update(0)
	counter(math.equation).update(0)
}

//Custom captions, used when wanting two different texts from the main body and the outline
#let flexCaption(long, short) = context if state("in-outline").get() { short } else { long }

//Creates a different style of outline for figures with field kind, otherwise shows the ordinary outline. The ordinary outline is customized with set and show rules
#let outline-entry(it) = {
  let a = 0
	context {
    	if it.element.has("kind") {
      		let loc = it.element.location()
	      	if counter(figure.where(kind: it.element.kind)).at(loc).last() == 1 {block(above: 1em)}
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
  thesis_title: [The Thesis title],
  subtitle: none,
  short_title: [A shorter title],
  authors: (),
  supervisors: (),
  examinor: none,
  affiliations: (),
  degree: none,
  front_images: (),
  description: none,
  keywords: (),
  print: false,
  header_style: "original",
  heading_style: "original",
  date: datetime.today(),
  body
  ) = {
  
  //Panics, checks for correct types on variables.
  if header_style not in("original", "mod", "alternating"){panic("Variable header-style must be either original (default) or mod")}
  if heading_style not in ("original", "mod"){panic("Variable heading-style must be either original (defualt) or mod")}

  if type(authors) != array {panic("Variable authors must be of type array.")}
  if type(supervisors) != array {panic("Variable supervisors must be of type array.")}
  if type(affiliations) != array {panic("Variable affiliations must be of type array.")}
  if type(front_images) != array {panic("Variable front_images must be of type array.")}
  if type(keywords) != array {panic("Variable keywords must be of type array.")}
  if type(print) != bool {panic("Variable print must be of type boolean.")}
  if type(date) != datetime {panic("Variable date must be of type datetime.")}

  //Selecting which header is used
  if header_style == "original" {state("header").update(header-original())}
  else if header_style == "mod" {state("header").update(header-simple())}
  else if header_style == "alternating" {state("header").update(header-alternating())}

  //Selecting which heading is used
  if heading_style == "original" {
    state("heading-numbering").update(_ => chapter-numbering)
    state("heading").update(_ => heading-original)
    
  }
  else if heading_style == "mod" {
    state("heading").update(_ => heading-modified)
  }
  
	//Set rules
  set document(
    title: thesis_title,
    author: authors.map(author => author.name),
    description: description,
    keywords: keywords,
    date: date
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
    header-ascent: 0% + 7.5mm,
  )

  //Gives an a4 page but with margins matching G5
  set page(
    paper: "a4",
    margin: (
      inside: 29.5mm + 5.5mm,
      outside: 210mm - 125mm - 29.5mm - 5.5mm,
      rest: (297mm - 200mm)/2,
      ),
    binding: left,
    numbering: none
  )

  // Sets only if print == false, adds a G5 box to the pages and some information on top
  set page(
    binding: right,
		background: [
			#set text(size: 12pt)
			#place(center, dy: 22.5mm)[
			#emph(short_title) - #date.display("[year]/[month padding:none]/[day padding:none]") - page #context(counter(page).display()) - #sym.hash#context(here().page())]
			#rect(stroke: 0.2mm, width: 169mm, height: 239mm)
		]) if print == false
	
  //Text
  set text(
   font: font_main,
   fill: colour_main,
   weight: "regular",
   size: size_main,
   hyphenate: true,
   lang: "en",
   ligatures: true,
   bottom-edge: "baseline",
   top-edge: "cap-height",
   number-type: "lining"
  )
  
  // Line
  set line(length: 100%,
    stroke: (thickness: 0.75pt, paint: colour_tertiary, cap: "round"))

  //Footnotes
  show footnote.entry: set text(fill: colour_secondary)
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.5pt + colour_secondary),
    gap: 0.8em
  )

  //Figures
  set figure(supplement: [Fig.],numbering: figure-numbering)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: [Table])
  show figure: block.with(above: 3em, below: 3em)
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
  set math.equation(supplement: none, numbering: equation-numbering)
  show math.equation: set text(font: font_math)
  
  //Raw text (Code)
  set raw(block: true, align: start, tab-size: 4, theme: "theme.tmTheme")
  show raw: set text(fill: luma(5%), font: "Source Code Pro")
  show raw.where(block: true): block.with(fill: luma(98%), inset: 20pt, radius: 2pt, width: 100%)
  show raw.where(block: true): it => {
    show raw.line: line => {
      box(grid(columns: (1em, 2em, 1fr), text(fill: luma(25%), [#line.number]), none, line))
    }
    it
  }

  //Outline
  set outline(depth: 2, indent: 1em)
  show outline.entry.where(level: 1): set outline.entry(fill: [#align(center, line(length: 100% - 5mm))])
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
  set heading(supplement: [Section])
  show heading: set text(font: font_main, fill: colour_heading, weight: "medium")
  show heading: set par(leading: 1em)
  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 2): set block(above: 2em, below: 1em)
  show heading.where(level: 2): set text(size: size_sub_heading)
  show heading.where(level: 3): set block(above: 1.5em, below: 1em)
  show heading.where(level: 3): set text(size: size_sub_sub_heading)
 
  //Figures out which heading to place depending on the state of the document
  show heading.where(level: 1): it => {
    resetCounters()
    state("heading").get()(it)
  }

  //Bibliography
  set bibliography(style: "ieee")

  //Quotes
  set quote(block: true)
  show quote: set block(inset: 2.5mm)

  //Main title page
  page([
    #set align(horizon + center)
    #set stack(dir: ttb)
    #set par(leading: 1em)
    #set text(size: 10pt, hyphenate: false)
    #show title: text.with(size: 20pt, font: font_main, weight: "medium")
    #context{
    grid(
      columns: 1fr,
      rows: (1fr, auto, 1fr, 1fr, 1fr, 1fr, 2fr),
      row-gutter: 2em,
      title(),
      text(size: size_sub_heading, subtitle),
      block(align(top, stack(dir: ltr, spacing: 2.5cm,
        ..authors.map(author => [
          #stack(spacing: par.leading, 
            text(size: 12pt, weight: "medium", author.name), 
            if "affiliation" not in author.keys(){v(par.leading)} else {author.affiliation},
            if "email" not in author.keys(){v(par.leading)} else {emph(link("mailto:" + str(author.email)))}
          )
        ])
      ))),
      stack(spacing: 1.5*par.leading, ..affiliations),
      stack(spacing: 1.5*par.leading, ..supervisors, if (examinor == none){par.leading} else {[Examiner: #examinor]},
      ),
      block[
        #if (degree != none) {[A thesis submitted for the degree of \ _ #degree _]} \ \
        #date.display("[month repr:long] [day padding:none], [year]")
      ],
      if front_images.len() != 0 {grid(column-gutter: 1.5cm, columns: front_images.len(), ..front_images.map(img => image(img, fit: "contain", height: 100%)))}
    )
  }])
  
  //Print page
  page()[
    #set par(leading: 0.5em)
    #place(bottom + left, [Typeset using Typst #sys.version \ \ #sym.copyright #date.year() \ Printed in Sweden \ Tryckeriet i E-huset, Lund])
  ]
  //Beginning of document
  counter(page).update(1)
  body
  }
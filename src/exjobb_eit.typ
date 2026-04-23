/*
A template of the degreeproject at EIT (Electrical and Information Technology) Lund University by Lucas Ekholm (E22).

Made in Typst 0.14.2

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#let template_version = version(1) // Change when changes are made to the template, used to distinguish from original

//---------------------------------------------|  TEXT AND COLOR DEFINITIONS  |---------------------------------------------//

// Text sizes

// Body text size
#let size-main = 10pt
// Secondary text size, used in headings, footers and figure captions
#let size-secondary = size-main * 0.9
// Level 1 headings font size
#let size-heading = size-main * 1.8
// Level 2 headings font size
#let size-sub-heading = size-main * 1.4
// Level 3 headings font size
#let size-sub-sub-heading = size-main * 1.2
#let size-chapter-nbr = size-main * 4

// Fonts

//Main font, used in body text
#let font-main = "EB Garamond"
// Secondary font, used in headers, headings, footers and figure captions
#let font-secondary = "Lato"
#let font-chapter-nbr = font-main
#let font-code = "Source Code Pro"
#let font-math = "Libertinus Math"

//Colours, taken from the official graphic profile of Lund University

#let lth-bronze = rgb(156, 97, 20) //cmyk(9%, 57%, 100%, 41%)
#let lth-blue = rgb(0, 0, 128) //cmyk(100%, 85%, 5%, 22%)
#let lth-grey = rgb(191, 184, 175)//cmyk(0%, 0%, 15%, 85%)
#let lth-light_brown = rgb(214, 210, 196) //cmyk(3%, 4%, 14%, 8%)

#let colour-main = black
#let colour-secondary = luma(25%)

//States
//Heading state, used for which style of heading to be used
//#let _ = state("heading", none)
//#let _ = state("header", none)

//Outline state, used for the flexCaption function
#let in-outline = state("in-outline", false)

//---------------------------------------------|  STYLINGS  |---------------------------------------------//

//Logic for numbering

// Chapter numbering, single digit if level 1
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

//Determines whether or not the current page has a level 1 heading
#let has-heading() = {
  return (query(heading.where(level: 1)).any(it => it.location().page() == here().page()))
}

//Footer for frontmatter
#let front-footer() = {
  set align(center)
  set text(font: font-secondary, size: size-secondary)
  context counter(page).display()
}

//Footer for mainmatter
#let main-footer() = {
  set align(center)
  set text(font: font-secondary, size: size-secondary)
  context {
    if(has-heading()){counter(page).display()}
    else{none}
  }
}

//Headers
//Header from the original LaTeX template
#let header-original() = {
  set par(spacing: 0pt)
  set text(font: font-secondary, size: size-secondary)
  context {
    if(has-heading()){none}
    else{
      let heading = query(selector(heading.where(level: 1)).before(here())).last()
      if calc.even(counter(page).get().first()) {
        box(width: 100%)[
          #text(counter(page).display())
          #h(1fr)
            #text(heading.body)
            ]
      } else {
        box(width: 100%)[
            #text(heading.body)
            #h(1fr)
            #text(counter(page).display())
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
  set text(font: font-secondary, size: size-secondary)
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

//A simple header style, but with alternating body between the last level 2 heading and the level 1 heading
#let header-alternating() = {
  set text(font: font-secondary, size: size-secondary)
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
      let heading2 = query(selector(heading.where(level: 2)).before(here())).last(default: heading1)
      if calc.even(counter(page).get().first()) {
        print(left, ltr, heading1.body)
      } else {
        print(right, rtl, heading2.body)
      }
    }
  }
}

//Heading stylings

//Heading style from the original LaTeX template
#let heading-original(it) = {
  pagebreak(weak: true, to: "odd")
  set text(
    font: font-secondary,
    weight: "regular",
    hyphenate: false
  )
  set align(right)
  set block(below: 15mm)
  let has-numbering = it.numbering != none
  if true {
    v(size-chapter-nbr)
    block()[
      #stack(dir: ttb, spacing: 7.5mm,
        [#box(width: 1fr, line()) #box([
            #if has-numbering {
              text(size: size-main, it.supplement)
            }
        #text(size: size-chapter-nbr, font: font-chapter-nbr, weight: "regular", 
          if it.numbering != none {counter(heading).display(it.numbering)})])],
        text(size: size-heading, it.body),
        line()
      )
    ]
  }
}

//A simplified heading
#let heading-modified(it) = {
  pagebreak(weak: true, to: "odd")
  set text(
    font: font-main,
    hyphenate: false
  )
  set align(center)
  set par(leading: 1em)
  set block(width: 100%, height: 3cm, below: 3cm)
  block(align(bottom)[
    #text(size: size-sub-sub-heading)[#if it.numbering != none [#it.supplement #counter(heading).display(it.numbering)]] \ \
    #text(size: size-heading, it.body)
  ]) 
}

//Document state functions, to keep the main file clean. Use for example "#show: mainmatter" to begin the main part of the document.

//Beginning of the frontmatter
#let frontmatter(body) = {
  set page(numbering: "i", header: none, footer: front-footer())
  set heading(outlined: false, bookmarked: true)
  body
}

//Beginning of the mainmatter
#let mainmatter(body) = {
  pagebreak(weak: true, to: "odd")
  set heading(numbering: chapter-numbering, outlined: true)
  set page(header: context state("header").get(), numbering: "1", footer: main-footer())
  counter(page).update(1)
  counter(heading).update(0)
  body
}

//Beginning of the backmatter (Appendix)
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

//---------------------------------------------|  DOCUMENT TEMPLATE |---------------------------------------------//

//Thesis template
#let thesis(
  thesis-title: [Thesis title],
  subtitle: none,
  short-title: [A shorter title],
  authors: (),
  supervisors: (),
  examiner: none,
  affiliations: (),
  degree: none,
  course-code: "EITM01",
  front-images: (),
  description: none,
  keywords: (),
  print: false,
  header-style: "original",
  heading-style: "original",
  front-cover-background: rect(width: 100%, height: 100%, fill: lth-light_brown),
  date: datetime.today(),
  report-id: none,
  body
  ) = {
  
  //Panics, checks for correct types on variables.
  if header-style not in("original", "mod", "alternating"){panic("Variable header-style must be either original (default) or mod")}
  if heading-style not in ("original", "mod"){panic("Variable heading-style must be either original (defualt) or mod")}
  
  if type(authors) != array {panic("Variable authors must be of type array.")}
  if type(supervisors) != array {panic("Variable supervisors must be of type array.")}
  if type(affiliations) != array {panic("Variable affiliations must be of type array.")}
  if type(front-images) != array {panic("Variable front-images must be of type array.")}
  if type(keywords) != array {panic("Variable keywords must be of type array.")}
  if type(print) != bool {panic("Variable print must be of type boolean.")}
  if type(date) != datetime {panic("Variable date must be of type datetime.")}
  if type(front-cover-background) != content {panic("Variable front-cover-background must be of type content")}
  if report-id == none and print == true {panic("Thesis must have a report-id to be printed!")}

  //Selecting which header is used
  if header-style == "original" {state("header").update(header-original())}
  else if header-style == "mod" {state("header").update(header-simple())}
  else if header-style == "alternating" {state("header").update(header-alternating())}

  //Selecting which heading is used
  if heading-style == "original" {
    state("heading").update(_ => heading-original)
    
  }
  else if heading-style == "mod" {
    state("heading").update(_ => heading-modified)
  }
  
  //Set rules
  set document(
    title: thesis-title,
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

  //Calculated necessary margins for the document depending if print == true or false
  let (g5_width, g5_height) = (169mm, 239mm)
  let (a4_width, a4_height) = (210mm, 297mm)
  let (a4_offset_width, a4_offset_height) = ((a4_width - g5_width) / 2, (a4_height - g5_height) / 2)
  
  let (body_width, body_height) = (125mm, 200mm)
  let inside = 29.5mm
  let outside = g5_width - inside - body_width
  let vertical =  (g5_height - body_height) / 2

  // Sets only if print == false, adds a G5 box to the pages and some information on top
  set page(
    paper: "a4",
    margin: (
      inside: inside + a4_offset_width,
      outside: outside + a4_offset_width,
      rest: vertical + a4_offset_height,
      ),
    binding: left,
    numbering: none,
    background: [
      #set text(size: 12pt)
      #place(center, dy: 22.5mm)[
      #emph(short-title) --- #date.display("[year]/[month padding:none]/[day padding:none]") --- page #context(counter(page).display()) --- #sym.hash#context(here().page())]
      #align(center + horizon, rect(stroke: 0.2mm, width: g5_width, height: g5_height))
    ]
  ) if print == false

  set page(
    paper: "sis-g5",
    margin: (
      inside: inside,
      outside: outside,
      rest: vertical
    ),
    binding: left
  ) if print == true
  
  //Text
  set text(
   font: font-main,
   fill: colour-main,
   weight: "regular",
   size: size-main,
   hyphenate: true,
   lang: "en",
   ligatures: true,
   bottom-edge: "baseline",
   top-edge: "cap-height",
   number-type: "lining"
  )
  
  // Line
  set line(length: 100%,
    stroke: (
      thickness: 0.75pt,
      cap: "round")
    )

  //Footnotes
  show footnote.entry: set text(fill: colour-secondary)
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.5pt + colour-secondary),
    gap: 0.8em
  )

  //Figures
  set figure(supplement: [Fig.],numbering: figure-numbering)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: [Table])
  show figure: block.with(above: 3em, below: 3em)
  show figure.caption: it => {
    set text(font: font-secondary, size: size-secondary)
    block(width: 75%)[
      #strong([#it.supplement #context{it.counter.display(it.numbering)}#it.separator])
      #text(fill: colour-secondary)[#it.body]
    ]
  }

  //Tables
  show table.cell.where(y: 0): strong
  set table(
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  {rgb("#efefef")}
  )

  //Equations
  set math.equation(supplement: none, numbering: equation-numbering)
  show math.equation: set text(font: font-math)
  
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
  show heading: set text(font: font-main, weight: "medium")
  show heading: set par(leading: 1em)
  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 2): set block(above: 2em, below: 1em)
  show heading.where(level: 2): set text(size: size-sub-heading)
  show heading.where(level: 3): set block(above: 1.5em, below: 1em)
  show heading.where(level: 3): set text(size: size-sub-sub-heading)
 
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

  //Front cover page, if print is true
  if print == true {page(
    paper: "sis-g5",
    margin: 0.5cm,
    background: rect(width: 100% - 0.65cm, height: 100% - 0.65cm, stroke: none)[#front-cover-background],
    foreground: place(bottom + right, dy: 17mm, dx: 13mm,image("LU-sigill.webp", height: 35%)))[
      #place(right + top, dy: 15%, 
        block(width: 80%, height: auto, inset: (right: 0pt, rest: 0.5cm), fill: white)[
          #set text(font: font-secondary, size: size-secondary, fill: lth-bronze, weight: "black")
          #set align(center)
          //#set par(leading: 0.75em)
          #text(font: font-main, weight: "semibold", size: size-heading, thesis-title)
          #v(0.7cm, weak: true)
          #align(right, line(stroke: (paint: lth-bronze)))
          #set align(left)
          #upper()[
            #text(authors.map(author => author.name).intersperse(" & ").join()) \
            Master's Thesis \
            Department of Electrical and Information Technology \
            Faculty of Engineering | LTH | Lund University
          ]
        ]
      )
  ]}

  //Main title page
  page([
    #set align(horizon + center)
    #set stack(dir: ttb)
    #set par(leading: 1em)
    #set text(size: 10pt, hyphenate: false)
    #show title: text.with(size: 20pt, font: font-main, weight: "medium")
    #context{
    grid(
      columns: 1fr,
      rows: auto,
      row-gutter: 1fr,
        title(),
        text(size: size-sub-heading, subtitle),
      block(align(top, stack(dir: ltr, spacing: 2.5cm,
        ..authors.map(author => [
          #stack(spacing: par.leading, 
            text(size: 12pt, weight: "medium", author.name), 
            if "affiliation" not in author.keys(){v(par.leading)} else {author.affiliation},
            if "email" not in author.keys(){v(par.leading)} else {emph(link("mailto:" + str(author.email)))}
          )
        ])
      ))),
      stack(spacing: 1.5*par.leading, ..supervisors, if (examiner == none){par.leading} else {[Examiner: #examiner]}, if course-code == none [Course code: #course-code] else []),
      stack(spacing: 1.5*par.leading, ..affiliations),
      [
        #if (degree != none) {[A thesis submitted for the degree of \ _ #degree _]} \ \
        #date.display("[month repr:long] [day padding:none], [year]")
      ],
      if front-images.len() != 0 {grid(column-gutter: 0.2fr, columns: (1fr,) * front-images.len(), ..front-images.map(img => image(img, fit: "contain", height: 4cm)))},
    )
  }])
  
  //Print page
  page()[
    #set par(leading: 0.4em)
      #place(bottom + left, [Typeset in Typst #sys.version \ \ #sym.copyright #date.year() \ Printed in Sweden \ Tryckeriet i E-huset, Lund])
  ]
  
  //Beginning of document
  counter(page).update(1)
  body

  //Backcover, if print is true
  if print == true {
    page(paper: "sis-g5", margin: (x: 1cm, rest: 2cm))[
      #set text(fill: lth-bronze, font: font-secondary, size: size-secondary, weight: "semibold")
  
      #place(top + right, rotate(90deg, reflow: true, text(weight: "regular", size: 6pt, [Printed by Tryckeriet i E-huset, Lund #date.display("[year]")])))
      #align(bottom + center)[
      #image("LU_RGB_ENG.png", height: 4cm) \  
      Series of Master's theses \
      Department of Electrical and Information Technology \
      LU/LTH-EIT #date.display("[year]")-#report-id \
      #link("http://www.eit.lth.se")]
    ]}
}
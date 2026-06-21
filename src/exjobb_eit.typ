/*
A template of the degreeproject at EIT (Electrical and Information Technology) Lund University by Lucas Ekholm (E22). This file includes templates for the thesis paper, popular science summary and goal document.

Made in Typst 0.15

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#let template_version = version(1) // Change when changes are made to the template, used to distinguish from original

//---------------------------------------------|  TEXT AND COLOR DEFINITIONS  |---------------------------------------------//

// Text sizes

// Body text size
#let size-main = 10pt
// Secondary text size, used in headers, footers and figure captions
#let size-secondary = size-main * 0.8
// Level 1 headings font size
#let size-heading = size-main * 2
// Level 2 headings font size
#let size-sub-heading = size-main * 1.4
// Level 3 headings font size
#let size-sub-sub-heading = size-main * 1.2
#let size-chapter-nbr = size-main * 4

// Fonts

// Serif font
#let font-main = "EB Garamond"
// Sans-serif font
#let font-secondary = "Lato"
#let font-chapter-nbr = font-main
#let font-code = "Source Code Pro"
#let font-math = "Libertinus Math"

// Colours, taken from the official graphic profile of Lund University
#let lth-bronze = rgb(156, 97, 20) //cmyk(9%, 57%, 100%, 41%)
#let lth-blue = rgb(0, 0, 128) //cmyk(100%, 85%, 5%, 22%)
#let lth-grey = rgb(191, 184, 175)//cmyk(0%, 0%, 15%, 85%)
#let lth-light_brown = rgb(214, 210, 196) //cmyk(3%, 4%, 14%, 8%)
#let colour-main = black
#let colour-secondary = luma(5%)

// States
#let document-state = state("doc-state", "none")

// Outline state, used for the flexCaption function
#let in-outline = state("in-outline", false)

//---------------------------------------------|  STYLINGS  |---------------------------------------------//

// Logic for numbering

// Chapter numbering, single digit if level 1
#let _chapter-numbering(.. n) = {
  let numbers = n.pos()
  
  if numbers.len() == 1 {
      numbering("1", ..numbers)
    } else {
      numbering("1.1", ..numbers) 
    }
}
// Appendix numbering, single letter if level 1
#let _appendix-chapter-numbering(.. n) = {
  let numbers = n.pos()
  
  if numbers.len() == 1 {
      numbering("A", ..numbers)
    } else {
      numbering("A.1", ..numbers)
    }
}

#let _figure-numbering(n) = numbering("1.1", counter(heading).get().first(), n)
#let _equation-numbering(n) = numbering("(1.1)", counter(heading).get().first(), n)
#let _appendix-figure-numbering(n) = numbering("A.1", counter(heading).get().first(), n)
#let _appendix-equation-numbering(n) = numbering("(A.1)", counter(heading).get().first(), n)



// Document state functions, to keep the main file clean. Use for example "#mainmatter()" to begin the main part of the document.

// Beginning of the frontmatter
#let frontmatter(body) = {
  set heading(outlined: false, bookmarked: true, numbering: none)
  document-state.update("front")
  body
}

// Beginning of the mainmatter
#let mainmatter(body) = {
  pagebreak(to: "odd")
  set heading(numbering: _chapter-numbering, outlined: true)
  set page(header: context state("header").get(), numbering: "1")
  counter(page).update(1)
  counter(heading).update(0)
  document-state.update("main")
  body
}

// Beginning of the backmatter (Appendix)
#let backmatter(body) = {
  pagebreak(to: "odd")
  set heading(numbering: _appendix-chapter-numbering)
  set figure(numbering: _appendix-figure-numbering)
  set math.equation(numbering: _appendix-equation-numbering)
  show heading.where(level: 1): set heading(supplement: [Appendix])
  counter(heading).update(0)
  document-state.update("back")
  body
  
}

// Custom captions, used when wanting two different texts from the main body and the outline
#let flexCaption(long, short) = context if state("in-outline").get() { short } else { long }

//---------------------------------------------|  THESIS  |---------------------------------------------//

// Thesis template. Inspired by a lot of different thesis templates, in particular Lund, Chalmers and Uppsala
#let thesis(
  thesis-title: none,
  authors: none,
  supervisors: none,
  examiner: none,
  thesis-subtitle: none,
  short-title: [A shorter title],
  affiliations: (),
  degree: none,
  course-code: [EITM01],
  front-images: ("LundUniversity_C_BLACK.png",),
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

  let department = "Department of Electrical and Information Technology"
  let department-short = "EIT"
  let department-link = link("http://www.eit.lth.se")

  // Headers
  // Determines whether or not the current page has a level 1 heading
  let _has-heading() = {
    return (query(heading.where(level: 1)).any(it => it.location().page() == here().page()))
  }
  // Header from the original LaTeX template
  let header-original() = {
    set par(spacing: 0pt)
    set text(font: font-secondary, size: size-secondary)
    context {
      if(_has-heading()){none}
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
  
  // A simple header style, but with alternating body between the last level 2 heading and the level 1 heading
  let header-alternating() = {
    set text(font: font-secondary, size: size-secondary)
    let print(alignment, body) = {
      
      let direction = none
      if alignment == left {direction = ltr}
      else if alignment == right {direction = rtl}
      
      set align(alignment)
      stack(dir: direction, spacing: 1em, 
        text(counter(page).display()), 
        [|],
        text(body, style: "italic"))
    }
    context {
      if(_has-heading()){none}
      else{
        let heading1 = query(selector(heading.where(level: 1)).before(here())).last(default: none)
        let heading2 = query(
          selector(heading.where(level: 2))
          .after(heading1.location())
          .before(here()))
          .last(default: heading1)
        if calc.even(counter(page).get().first()) {
          if heading1.numbering == none {
            print(left, heading1.body)
          }
          else {
            print(left, [#heading1.supplement #counter(heading).display(at: heading1.location()) #heading1.body])
          }
        } else {
          if heading2.numbering == none {
            print(right, heading2.body)
          }
          else{
            print(right, [#counter(heading).display(at: heading2.location()) #heading2.body])
          }
          
        }
      }
    }
  }

  // Footer for frontmatter
  let _front-footer() = {
    set align(center)
    set text(font: font-secondary, size: size-secondary)
    context counter(page).display()
  }
  
  // Footer for mainmatter
  let _main-footer() = {
    set align(center)
    set text(font: font-secondary, size: size-secondary, style: "italic")
    context {
      if(_has-heading()){counter(page).display()}
      else{none}
    }
  }

  // Heading stylings
  // Heading style from the original LaTeX template
  let heading-original(it) = {
    set text(
      font: font-secondary,
      weight: "regular",
      hyphenate: false
    )
    set align(right)
    set block(below: 15mm)
    let has-numbering = (it.numbering != none)
    if true {
      v(size-chapter-nbr)
      block()[
        #stack(dir: ttb, spacing: 7.5mm,
          [#box(width: 1fr, line()) #box([
              #if has-numbering {
                text(size: size-main, it.supplement)
              }
          #text(size: size-chapter-nbr, font: font-chapter-nbr, 
            if it.numbering != none {counter(heading).display(it.numbering)})])],
          text(size: size-heading, it.body),
          line()
        )
      ]
    }
  }

  // A simplified heading
  let heading-new(it) = {
    set text(
      font: font-main,
      hyphenate: false
    )
    set align(center)
    set par(leading: 1em)
    set block(width: 100%, height: 3cm, below: 2cm)
    block(align(bottom)[
      #text(size: size-main)[#if it.numbering != none [#it.supplement #counter(heading).display(it.numbering)]] \ \
      #text(size: size-heading, it.body)
    ]) 
  }

  // Function for resetting counters for new chapters. Called everytime a chapter is started with a show rule. If adding new kinds of figures, include a reset here
  let resetCounters() = {
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(math.equation).update(0)
  }

  // Panics
  if thesis-title == none {panic("Missing required argument 'thesis-title'")}
  if authors == none {panic("Missing required argument 'authors'")}
  if supervisors == none {panic("Missing required argument 'supervisors'")}
  if examiner == none {panic("Missing required argument 'examiner'")}
  
  if type(authors) != array {panic("Variable 'authors' must be of type array.")}
  if type(supervisors) != array {panic("Variable 'supervisors' must be of type array.")}
  if type(affiliations) != array {panic("Variable 'affiliations' must be of type array.")}
  if type(front-images) != array {panic("Variable 'front-images' must be of type array.")}
  if type(keywords) != array {panic("Variable 'keywords' must be of type array")}
  if type(print) != bool {panic("Variable 'print' must be of type boolean.")}
  if type(date) != datetime {panic("Variable 'date' must be of type datetime.")}
  if type(front-cover-background) != content {panic("Variable 'front-cover-background' must be of type content")}
  if report-id == none and print == true {panic("Thesis must have a report-id to be printed!")}

  if header-style not in("original", "novel"){panic("Variable header-style must be either original (default) or novel.")}
  if heading-style not in ("original", "novel"){panic("Variable heading-style must be either original (defualt) or novel.")}

  //Selecting which header is used
  if header-style == "original" {state("header").update(header-original())}
  else if header-style == "novel" {state("header").update(header-alternating())}

  // Selecting which heading is used
  if heading-style == "original" {
    state("heading").update(_ => heading-original)
    
  }
  else if heading-style == "novel" {
    state("heading").update(_ => heading-new)
  }
  
  // Set rules
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
    footer: context {
      let doc-state = document-state.get()
      if doc-state == "front" {_front-footer()}
      else if doc-state in ("main", "back") {_main-footer()}
      else {none}},
    header: context {
      let doc-state = document-state.get()
      if doc-state == "front" {none}
      else if doc-state == "main" {state("header").get()}
    },
    numbering: (..num) => context {
      let doc-state = document-state.get()
      if doc-state == "front" {numbering("i", ..num)}
      else if doc-state == "main" {numbering("1", ..num)}
      else if doc-state == "back" {numbering("1", ..num)}
      else {numbering("1", ..num)}
    },
  )

  // Calculated necessary margins for the document depending if print == true or false. sis-g5 has dimensions 169x239mm
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
  
  // Text
  set text(
    lang: "en",
    font: font-main,
    fill: colour-main,
    weight: "regular",
    size: size-main,
  )

  show smallcaps: text.with(tracking: 0.5pt)
  
  // Line
  set line(length: 100%,
    stroke: (
      thickness: 0.75pt,
      cap: "round")
    )

  // Footnotes
  show footnote.entry: set text(fill: colour-secondary)
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.5pt + colour-secondary),
    gap: 0.8em
  )

  // Figures
  set figure(supplement: [Fig.], numbering: _figure-numbering)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: [Table])
  show figure.where(kind: raw): set block(breakable: true)
  show figure: block.with(above: 3em, below: 3em)
  show figure.caption: it => {
    set text(font: font-secondary, size: size-secondary)
    block(width: 75%)[
      #strong([#it.supplement #context{it.counter.display(it.numbering)}#it.separator])
      #text(fill: colour-secondary)[#it.body]
    ]
  }

  // Tables
  show table.cell.where(y: 0): strong
  set table(
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  {rgb("#efefef")}
  )

  // Equations
  set math.equation(supplement: none, numbering: _equation-numbering)
  show math.equation: set text(font: font-math)
  
  //Raw text (Code)
  set raw(block: true, align: start, tab-size: 4, theme: "theme.tmTheme")
  show raw: set text(fill: luma(5%), font: "Source Code Pro")
  show raw.where(block: true): block.with(fill: luma(98%), inset: 20pt, radius: 3pt, width: 100%, stroke: 0.5pt + luma(80%))
  show raw.where(block: true): it => {
    show raw.line: line => {
      box(grid(columns: (1em, 2em, 1fr), text(fill: luma(25%), [#line.number]), none, line))
    }
    it
  }

  // Outline
  // Creates a different style of outline for figures with field kind, otherwise shows the ordinary outline. The ordinary outline is customized with set and show rules
  let outline-entry(it) = {
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
  
  // Headings
  set heading(supplement: [Section])
  show heading: set text(font: font-main, weight: "medium")
  show heading: set par(leading: 1em)
  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 2): set block(above: 2em, below: 1em)
  show heading.where(level: 2): set text(size: size-sub-heading)
  show heading.where(level: 3): set block(above: 1.5em, below: 1em)
  show heading.where(level: 3): set text(size: size-sub-sub-heading)
  
  // Figures out which heading to place depending on the state of the document
  show heading.where(level: 1): it => {
    pagebreak(weak: true, to: "odd")
    resetCounters()
    state("heading").get()(it)
  }
  
  // Bibliography
  set bibliography(style: "ieee")

  // Quotes
  set quote(block: true)
  show quote: set block(inset: 2.5mm)

  // Front cover page, if print is true
  if print == true {page(
    paper: "sis-g5",
    margin: 5mm,
    background: box(width: 100%-10mm, height: 100%-10mm, stroke: none)[#front-cover-background],
    foreground: place(bottom + right, dy: 17mm, dx: 13mm,image("LU-sigill.webp", width: 50%)))[
      #place(right + top, dy: 15%, 
        block(width: 4*20%, height: auto, inset: 5mm, outset: (right: 5mm), fill: white)[
          #set par(leading: 2mm)
          #set text(font: font-secondary, size: size-secondary, fill: lth-bronze, weight: "black")
          #set align(center)
          #text(font: font-main, weight: "semibold", size: size-heading, thesis-title) 
          #linebreak()
          #set align(left)
          #line(length: 100% + 5mm, stroke: (paint: lth-bronze))
          #upper()[
            #text(authors.map(author => author.name).intersperse(" & ").join()) \
            Master's Thesis \
            #department \
            Faculty of Engineering | LTH | Lund University
          ]
        ]
      )
  ]
  pagebreak(to: "odd")
}

  // Title page
  page()[
    #set align(center + horizon)
    #set stack(dir: ttb)
    #let print-authors = context {
      align(top, grid(rows: 1, columns: authors.len(), column-gutter: 2cm,..authors.map(author => [
            #stack(spacing: par.leading, 
              text(size: size-sub-sub-heading, weight: "regular", author.name), 
              if "affiliation" not in author.keys(){v(par.leading)} else {author.affiliation},
              if "email" not in author.keys(){par.leading} else {link("mailto:" + str(author.email))}
            )
          ])))
    }
    #show link: emph
    #show title: text.with(size: size-heading, font: font-main, weight: "semibold")
    #context{
      block(height: 90%, 
        grid(
          columns: 1,
          row-gutter: (1fr, 1fr, 0.5fr),
          
          [#smallcaps(text("Master's thesis"/* + " " + str(date.year())*/, size: size-main)) /*#if (degree == none) {[#parbreak() Submitted for the degree of #linebreak() _ #degree _]}*/],
          
          grid(row-gutter: (3em), 
            title(),
            text(thesis-subtitle, size: size-sub-sub-heading),
            print-authors,
          ),

          date.display("[month repr:long] [day padding:none], [year]"),
  
          //if affiliations.len() != 0 {[Thesis work conducted at #affiliations.join(" & ")]},
          
          if front-images.len() != 0 {grid(column-gutter: 0.2fr, columns: (1fr,) * front-images.len(), ..front-images.map(img => image(img, fit: "contain", height: 3cm)))},
          
          smallcaps([#department \ Faculty of Engineering | LTH | Lund University]),
        )
      )
    }
  ]
  
  // Print page
  page()[
    #set align(bottom)
    #set par(first-line-indent: 0pt)
    #show link: emph
    #v(0.5fr)
    #thesis-title \ #thesis-subtitle \ #authors.map(author => author.name).join(" & ") \ \ 
    #supervisors.join([ \ ]) \
    Examiner: #examiner /* \ #affiliations.join([, ])*/ \ \ #course-code \ #report-id \ \ #department \ Faculty of Engineering, LTH, Lund University \ SE-221 00 Lund, Sweden
    #v(1fr)
    Typeset in Typst #sys.version \ \ #sym.copyright /*#authors.map(author => author.name).join(" & "), */ #authors.map(author => author.name).join(" & "), #date.year() \ Printed by Tryckeriet i E-huset \ Lund, Sweden
  ]
  
  // Beginning of document
  counter(page).update(1)
  body

  // Backcover, if print is true
  if print == true {
    page(paper: "sis-g5", margin: (x: 1cm, rest: 2cm))[
      #set text(fill: lth-bronze, font: font-secondary, size: size-secondary, weight: "semibold")

      #place(top + right, rotate(90deg, reflow: true, text(weight: "regular", size: 6pt, [Printed by Tryckeriet i E-huset, Lund #date.display("[year]")])))
      #align(bottom + center)[
      #image("LU_RGB_ENG.png", height: 4cm) \  
      Series of Master's theses \
      #department \
      LU/LTH-#department-short #date.display("[year]")-#report-id \
      #department-link
    ]]}
}

//---------------------------------------------|  POPULAR SCIENCE SUMMARY |---------------------------------------------//

// Template for the popular science summary paper. Based on the LaTeX version from department of computer science (CS) at LTH.
#let popular-science-summary(
  summary-title: none,
  original-title: none,
  authors: none,
  supervisor: none,
  examiner: none,
  lead-paragraph: none,
  thesis-link: none,
  presentation-date: datetime.today(),
  lang: "sv",
  body
) = {
  
  // Panics
  if summary-title == none {panic("Missing required argument 'summary-title'.")}
  if original-title == none {panic("Missing required argument 'original-title'.")}
  if authors == none {panic("Missing required argument 'authors'.")}
  if supervisor == none {panic("Missing required argument 'superivsor'.")}
  if examiner == none {panic("Missing required argument 'examiner'.")}
    
  if lang not in ("sv", "en") {panic("Variable 'lang' must be either 'en' or 'sv' ('sv' by default)")}
  if type(authors) != array {panic("Variable 'authors' must be of type array")}
  if type(supervisor) != array {panic("Variable 'supervisor' must be of type array")}
  if type(presentation-date) != datetime {panic("Variable 'presentation-date' must be of type datetime")}

  // Dictionary containing predetermined words and sentences in both english and swedish.
  let language-fields = (
    sv: (
      department: "Institutionen för elektro- och informationsteknik",
      faculty: "LTH | Lunds Universitet",
      degree-project: "Examensarbete",
      student-singular: "Student",
      students-plural: "Studenter",
      supervisor-singular : "Handledare",
      supervisors-plural : "Handledare",
      examiner: "Examinator",
      popular-science-summary: "Populärvetenskaplig Sammanfattning",
      presented: "Presenterad",
      availability: "Tillgänglig vid",
      figure-supplement: "Figur"
    ),
    
    en: (
      department: "Department of Electrical and Information Technology",
      faculty : "LTH | Lund University",
      degree-project : "Degree Project",
      student-singular : "Student",
      students-plural: "Students",
      supervisor-singular : "Supervisor",
      supervisors-plural : "Supervisors",
      examiner: "Examiner",
      popular-science-summary: "Popular Science Summary",
      presented: "Presented",
      availability: "Available at",
      figure-supplement: "Figure"
    )
  )

  // Information box about the degree project found in the top of the paper
  let information() = {
    set align(top)
    set par(spacing: 1em)
    set text(size: size-secondary)
    let spacing = 0.5em
    let students = ""
    let supervisor-label = ""
    if authors.len() > 1 {students = "students-plural"} else {students = "student-singular"}
    if supervisor.len() > 1 {supervisor-label = "supervisors-plural"} else {supervisor-label = "supervisor-singular"}
    box(stroke: (left: (thickness: 1.5pt, paint: lth-bronze, cap: "round")), outset: 3mm)[
      
      #language-fields.at(lang).at("department") | #language-fields.at(lang).at("faculty") | #language-fields.at(lang).at("presented") #presentation-date.display("[day padding:none] [month repr:long] [year]")
      \ \
      #block[
        #strong(upper(language-fields.at(lang).at("degree-project"))) #h(spacing) #original-title #linebreak()
        #strong(upper(language-fields.at(lang).at(students))) #h(spacing) #authors.map(author => author.name).join(" & ") #linebreak()
        #strong(upper(language-fields.at(lang).at(supervisor-label))) #h(spacing) #supervisor.join(", ") #linebreak()
        #strong(upper(language-fields.at(lang).at("examiner"))) #h(spacing) #examiner
        #if thesis-link != none [#parbreak() #language-fields.at(lang).at("availability") #link(thesis-link)]
      ]
    ]
  }
  
  set text(size: size-main, font: font-secondary, lang: lang)
  set heading(level: 2, outlined: false, bookmarked: false)
  set par(spacing: 0.5em)
  set figure(supplement: language-fields.at(lang).at("figure-supplement"), numbering: "1")
  set document(author: authors.map(author => author.name), date: presentation-date, title: summary-title)
  show link: set text(fill: lth-blue)

  // The paper itself
  page(paper: "a4", margin: (rest: 2.5cm))[
    #block(below: 1.5em+ 3mm, information())
    #par([#language-fields.at(lang).at("popular-science-summary") | *#authors.map(author => author.name).join(" & ")*])
    \
    #par(text(size: size-heading, font: font-main, weight:  "semibold",  fill: lth-bronze, summary-title)) \
    #set par(justify: true, first-line-indent: 1em)
    #par(strong(text(lead-paragraph, font: font-main, size: size-main*1.1)))
    #v(1em)
    #columns(2, gutter: 5%, body)
  ]
}

//---------------------------------------------|  GOAL DOCUMENT |---------------------------------------------//

// Template for the goal document. Based on the docx template provided by Peter Nilsson at EIT.
#let goal-document(
  tentative-title: none,
  authors: none,
  start-date: none,
  end-date: none,
  course-code: none,
  academic-supervisor: none,
  examiner: none,
  lang: "en",
  body
) = {

  // Panics
  if tentative-title == none {panic("Missing required argument 'tentative-title'.")}
  if authors == none {panic("Missing required argument 'authors'.")}
  if start-date == none {panic("Missing required argument 'start-date'.")}
  if end-date == none {panic("Missing required argument 'end-date'.")}
  if course-code == none {panic("Missing required argument 'course-code'.")}
  if academic-supervisor == none {panic("Missing required argument 'academic-supervisor'.")}
  if examiner == none {panic("Missing required argument 'examiner'.")}

  if type(authors) != array {panic("Variable 'authors' must be of type array.")}
  if type(start-date) != datetime {panic("Variable 'start-date' must be of type datetime.")}
  if type(end-date) != datetime {panic("Variable 'end-date' must be of type datetime.")}

  if lang not in ("sv", "en") {panic("Variable lang must be either 'sv' or 'en' ('en' by default).")}

  // Dictionary containing predetermined words and sentences in both english and swedish.
  let language-fields = (
    sv : (
      subtitle-phrase: "Ett Måldokument för Examensarbete på Avancerad Nivå",
      by-phrase: "Av",
      department-phrase: [Instutitionen för elektro- och informationteknik \ Lunds Tekniska Högskola, LTH, Lunds Universitet \ SE-221 00 Lund, Sverige],
      student-singular: "Student",
      student-plural: "Studenter",
      civic-number-singular: "Personnummer",
      civic-number-plural: "Personnummer",
      email: "Mailadress",
      academic-supervisor: "Huvudhandledare",
      examiner: "Examinator",
      project-start: "Arbetet börjar",
      project-end: "Arbetet avslutas",
      course-code: "Kurskod",
      and-label: " och ",
      signing-line: "Detta måldokument är godkänt av",
    ),
    en: (
      subtitle-phrase: "A Goal Document for Master's Thesis Work",
      by-phrase: "By",
      department-phrase: [Department of Electrical and Information Technology \ Faculty of Engineering, LTH, Lund University \ SE-221 00 Lund, Sweden],
      student-singular: "Student",
      student-plural: "Students",
      civic-number-singular: "Civic registration number",
      civic-number-plural: "Civic registration numbers",
      email: "Email address",
      academic-supervisor: "Main supervisor",
      examiner: "Examiner",
      project-start: "Project start",
      project-end: "Project end",
      course-code: "Course code",
      and-label: " and ",
      signing-line: "This goal document is approved by"
    )
  )

  // Prints information about the degree project
  let information() = {
    let student-label = ""
    let civic-number-label = ""
    if authors.map(author => author.name).len() > 1 {student-label = "student-plural"} else {student-label = "student-singular"}
    if authors.map(author => author.civic-number).len() > 1 {civic-number-label = "civic-number-plural"} else {civic-number-label = "civic-number-singular"}
    
    block(stroke: (left: (thickness: 1pt)), outset: 2mm)[
      #set par(leading: 0.75em)
      #language-fields.at(lang).at(student-label): #authors.map(author => author.name).join(language-fields.at(lang).at("and-label")) 
      #linebreak()
      #language-fields.at(lang).at(civic-number-label): #authors.map(author => author.civic-number).join(language-fields.at(lang).at("and-label")) #linebreak()
      #language-fields.at(lang).at("email"): #authors.map(author => author.email).join(language-fields.at(lang).at("and-label"))
      #linebreak()
      #language-fields.at(lang).at("academic-supervisor"): #academic-supervisor
      #linebreak()
      #language-fields.at(lang).at("examiner"): #examiner
      #linebreak()
      #language-fields.at(lang).at("project-start"): #start-date.display()
      #linebreak()
      #language-fields.at(lang).at("project-end"): #end-date.display()
      #linebreak()
      #language-fields.at(lang).at("course-code"): #course-code
    ]
  }

  // Area used for signing the document
  let signing() = {
    language-fields.at(lang).at("signing-line") + ":"
    v(0.5em)
    grid(columns: (1fr, 1fr), rows: (auto, 1cm, auto), row-gutter: 1em, column-gutter: 2cm,
      language-fields.at(lang).at("academic-supervisor"),
      language-fields.at(lang).at("examiner"),
      box(height: 100%, width: 90%, stroke: (bottom: (thickness: 1pt))),
      box(height: 100%, width: 90%, stroke: (bottom: (thickness: 1pt))),
      academic-supervisor,
      examiner)
  }
  set heading(numbering: "1. ")
  show heading: set text(font: font-main)
  set text(font: font-secondary, lang: lang)
  set figure(supplement: [Fig])
  set page(numbering: "1/1")

  set document(
    author: authors.map(author => author.name),
    title: tentative-title,
  )
  
  //Title page
  page(numbering: none)[
    #set text(font: font-main, size: size-sub-sub-heading)
    #set align(horizon + center)
    #show title: set text(size: size-heading + 2pt)
    #place(top + left, image("LU_RGB_ENG.png", width: 3cm))
    #block(height: 40%,
      grid(columns: 1, rows: auto, row-gutter: 1fr,
        title(),
        text(size: size-sub-heading, language-fields.at(lang).at("subtitle-phrase")),
        [#language-fields.at(lang).at("by-phrase") \
        #stack(dir: ltr, spacing: 2em, ..authors.map(author => author.name))],
        language-fields.at(lang).at("department-phrase"),
        text(size: size-sub-heading, str(start-date.year()))
      )
    )
  ]

  counter(page).update(1)
  block(below: 3em, information())
  
  body
  
  block(above: 2cm, signing())
}

//---------------------------------------------|  PROJECT PLAN  |---------------------------------------------//

// Template for the project plan, used after the goal document but in the same .typ file. Based on the docx template by Peter Nilsson at EIT
#let project-plan(
  academic-supervisor: none,
  examiner: none,
  lang: "en",
  body
) = {
  
  //Panics
  if academic-supervisor == none {panic("Missing required argument 'academic-supervisor'.")}
  if examiner == none {panic("Missing required argument 'examiner'.")}

  if lang not in ("sv", "en") {panic("Variable lang must be either 'sv' or 'en' ('en' by default).")}

  let language-fields = (
    sv : (
      academic-supervisor: "Huvudhandledare",
      examiner: "Examinator",
      signing-line: "Denna projektplan är godkänd av"
    ),
    en: (
      academic-supervisor: "Main Supervisor",
      examiner: "Examiner",
      signing-line: "This project plan is approved by"
    )
  )

  // Area used for signing the docuemnt
  let signing() = {
    language-fields.at(lang).at("signing-line") + ":"
    v(0.5em)
    grid(columns: (1fr, 1fr), rows: (auto, 1cm, auto), row-gutter: 1em, column-gutter: 2cm,
      language-fields.at(lang).at("academic-supervisor"),
      language-fields.at(lang).at("examiner"),
      box(height: 100%, width: 90%, stroke: (bottom: (thickness: 1pt))),
      box(height: 100%, width: 90%, stroke: (bottom: (thickness: 1pt))),
      academic-supervisor,
      examiner)
  }
  set text(font: font-secondary, lang: lang)
  set figure(supplement: [Fig])

  body 

  block(above: 2cm, signing())
}
/*
A template of the degreeproject at EIT (Electrical and Information Technology) Lund University by Lucas Ekholm (E22). This file includes templates for the thesis paper, popular science summary and goal document.

Made in Typst 0.15

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

//---------------------------------------------|  GLOBAL VARIABLES  |---------------------------------------------//

#let template_version = version(1) // Change when changes are made to the template, used to distinguish from original

#let debug = false

#let degree-level-en = "Master"
#let degree-level-sv = "Avancerad nivå"

#assert(degree-level-en in ("Master", "Bachelor"), message: "Variable 'degree-level-en' must be either 'Master' or 'Bachelor'")
#assert(degree-level-sv in ("Avancerad nivå", "Grundnivå"), message: "Variable 'degree-level-sv' must be either 'Avancerad nivå' or 'Grundnivå'")

#let department-en = "Department of Electrical and Information Technology"
#let department-short-en = "EIT"
#let department-sv = "Insitutionen för elektro- och informationsteknik"
#let department-short-sv = "EIT"
#let department-link = link("http://www.eit.lth.se")

//---------------------------------------------|  TEXT AND COLOR DEFINITIONS  |---------------------------------------------//

// Text sizes

// Body text size
#let size-main = 10pt
// Secondary text size, used in headers, footers and figure captions
#let size-secondary = size-main * 0.8
// Level 1 headings font size
#let size-heading = size-main * 1.8
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
#let lu-bronze = color.spot("PANTONE 1395 U", rgb(156, 97, 20)).tint(100%) //cmyk(9%, 57%, 100%, 41%)
#let lu-blue = color.spot("PANTONE 280 U", rgb(0, 0, 128)).tint(100%) //cmyk(100%, 85%, 5%, 22%)
#let lu-grey = color.spot("PANTONE BLACK 7 C", rgb(77, 76, 68)).tint(100%) //cmyk(0%, 0%, 15%, 85%)
#let lu-light-brown = color.spot("PANTONE 7527 C", rgb(214, 210, 196)).tint(100%) //cmyk(3%, 4%, 14%, 8%)
#let colour-main = black
#let colour-secondary = lu-grey

//---------------------------------------------|  STYLINGS  |---------------------------------------------//

// Custom captions, used when wanting two different texts from the main body and the outline
#let flexCaption(long, short) = context if state("in-outline").get() { short } else { long }

// Headers

// Determines whether or not the current page has a level 1 heading
#let _has-heading() = {
  return (query(heading.where(level: 1)).any(it => it.location().page() == here().page()))
}

// A simple header style, but with alternating body between the last level 2 heading and the level 1 heading
#let _header-alternating() = {
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
          print(left, [#heading1.supplement #counter(heading).display(at: heading1.location()). #heading1.body])
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

// Header from the original LaTeX template
#let _header-original() = {
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

// Footers
  
// Footer for frontmatter
#let _front-footer() = {
  set align(center)
  set text(font: font-main, size: size-secondary)
  context counter(page).display()
}

// Footer for mainmatter
#let _main-footer() = {
  set align(center)
  set text(font: font-secondary, size: size-secondary)
  context {
    if(_has-heading()){counter(page).display()}
    else{none}
  }
}
  
// Headings

// Heading style from the original LaTeX template
#let _heading-original(it) = {
  set text(
    font: font-secondary,
    hyphenate: false
  )
  set align(right)
  let has-numbering = (it.numbering != none)
  if true {
    v(size-chapter-nbr)
    block()[
      #stack(dir: ttb, spacing: 7.5mm,
        [
          #box(width: 1fr, line())
          #box([
            #if has-numbering {
              text(size: size-main, it.supplement)
            }
            #text(size: size-chapter-nbr,weight: "regular", font: font-chapter-nbr, if has-numbering {counter(heading).display(it.numbering)})
          ])
        ],
        text(size: size-heading, it.body),
        line()
      )
    ]
  }
}

// A simplified heading
#let _heading-new(it) = {
  set text(
    font: font-main,
    hyphenate: false
  )
  set par(leading: 1em)

  block(
    width: 100%,
    align(center + horizon, 
      grid(
        rows: (1cm, auto, auto),
        row-gutter: 2em,
        if it.numbering != none [#text(size: size-main)[#it.supplement #counter(heading).display(it.numbering)]],
        text(size: size-heading, it.body),
        // line(length: 10%)
      )
    )
  )
}

//---------------------------------------------|  NUMBERING  |---------------------------------------------//

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

// Function for resetting counters for new chapters. Called everytime a chapter is started with a show rule. If adding new kinds of figures, include a reset here
#let _resetCounters() = {
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: raw)).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(math.equation).update(0)
}

//---------------------------------------------|  PRINT  |---------------------------------------------//

#let _front-cover-page(
  title,
  background,
  authors,
  degree,
  department,
) = page(
  paper: "sis-g5",
  margin: 5mm,
  background: box(
    width: 100%-10mm,
    height: 100%-10mm,
    stroke: none
  )[
    #set image(width: 100%, height: 100%)
    #background
  ],
  foreground: place(
    bottom + right,
    dy: 17mm, dx: 13mm,
    image("LU-sigill.webp", width: 50%))
  )[
    #set par(justify: true, leading: 0.7em)
    #set text(font: font-secondary, size: size-secondary, fill: lu-bronze, weight: "bold", hyphenate: false)
    #place(
      right + top,
      dy: (1/7)*100%,
      block(
        width: 100%*(4/5),
        height: auto,
        inset: 5mm,
        outset: (right: 5mm),
        fill: white,
        align(
          left,
          grid(
            rows: 3,
            gutter: 1.5em,
            text(font: font-main, weight: "semibold", size: size-heading, title),
            line(length: 100%, stroke: (paint: lu-bronze)),
            upper()[
              #text(authors.map(author => author.name).join(", ", last: " & ")) \
              #degree's Thesis \
              #department \
              Faculty of Engineering | LTH | Lund University
            ]
          )
        )   
      )
    )
    #if debug {place(center + horizon, grid(rows: 7*(1fr,), columns: 5*(1fr,), stroke: 1pt))} // Used for debugging)
  ]

#let _title-page(
  thesis-title,
  subtitle,
  authors,
  supervisors,
  examiner,
  degree,
  department,
  images,
  date
) = page()[
  #let print-authors = context {
    align(top, grid(rows: 1, columns: authors.len(), column-gutter: 2cm,..authors.map(author => [
          #stack(spacing: par.leading,
            text(weight: "regular", size: size-sub-sub-heading, {
              author.name
            }), 
            if "affiliation" not in author.keys(){v(par.leading)} else {author.affiliation},
            if "email" not in author.keys(){par.leading} else {link("mailto:" + str(author.email))}
          )
        ])))
  }
  #set align(center + horizon)
  #set text(hyphenate: false)
  #set stack(dir: ttb)
  #set par(justify: false, leading: 1em)
  #set line(length: 60%)
  #show link: emph
  #show title: set text(size: size-heading, font: font-main, weight: "semibold")
  #context{
    block(height: 100%, 
      grid(
        row-gutter: (1.25fr, 1.25fr, 1fr, 1fr),
        stroke: 0pt,
        smallcaps[#degree's thesis #date.year() #linebreak() #department],
        grid(row-gutter: 3em,
          line(),
          title(),
          line(),
          ..if subtitle != none {(text(subtitle, size: size-sub-heading),)},
        ),
        print-authors,
        date.display("[month repr:long] [day padding:none], [year]"), 
        {
          let images-filtered = images.filter(img => type(img) == type(""))
          
          if images-filtered.len() != 0 {
            grid(column-gutter: 0.2fr,
              columns: (1fr,) * images-filtered.len(),
              ..images-filtered.map(img => image(img, fit: "contain", height: 3cm)))
          }
        },
      )
    )
  }
]

#let _information-page(
  title,
  title-sv,
  subtitle,
  subtitle-sv,
  authors,
  company,
  supervisors,
  examiner,
  course-code,
  issn,
  department,
  date
) = page()[
  // #set align(top)
  #set par(first-line-indent: 0em, leading: 0.8em)
  #set block(below: 1fr)
  #v(4cm)
  #block()[
    #text(size: size-sub-heading, weight: "semibold", title) \ \
    #text(size: size-sub-sub-heading, subtitle)
  ]

  #block()[
    #sym.copyright #h(1em) #authors.map(author => author.name).join(", ", last: " & "), #date.year()
  ]

  #block(grid(
    columns: 2,
    gutter: 1.5em,
    ..if title-sv != none {
      (
        [Swedish title],
        [#title-sv#if subtitle-sv != none [: \ #subtitle-sv]],
      )
    },
    "Supervisor" + if supervisors.len() > 1 {"s"}, grid(
      row-gutter: 1em, ..supervisors.values().map(supervisor => [
        #supervisor.name  (#supervisor.affiliation)#if supervisor.email != none [, #link("mailto:" + supervisor.email)]
      ])
    ),
    "Examiner", [#examiner.name#if examiner.email != none [, #link("mailto:" + examiner.email)]],
    "Course code", [#course-code],
    ..if issn != none {
      (
        "ISSN",
        issn,
      )
    }
  ))

  #block(if company != none [Degree project carried out at #company.join(", ", last: " and ")])
  
  #block()[
      #department \ Faculty of Engineering, LTH \ Lund University #parbreak() Box 118 \ SE-221 00 Lund \ Sweden
  ]


  Typeset in Typst #sys.version \
  Printed by #link("https://www.ehuset.lth.se/tryckeriet/", [Tryckeriet i E-huset])
]

#let _back-cover(
  degree,
  department,
  department-abbreviation,
  link,
  id,
  date
) = page(
    paper: "sis-g5",
    margin: 5mm,
  )[
    #set text(fill: lu-bronze, font: font-secondary, size: size-secondary, weight: "semibold")
    #if debug {place(center + horizon, grid(rows: 7*(1fr,), columns: 5*(1fr,), stroke: 1pt))} // Used for debugging
    #place(top + right, dx: -5mm, dy: 0.5/7*100%, rotate(90deg, reflow: true, text(size: 6pt, [Printed by Tryckeriet i E-huset, Lund #date.display("[year]")])))
    #place(center + bottom, dy: -1/7*100% , image("LU_RGB_ENG.png", height: 1/7*100%))
    #place(center + bottom, dy: -1/7*100% + 2cm , [
      Series of #degree's theses \
      #department \
      LU/LTH-#department-abbreviation #date.display("[year]")-#id \
      #link
    ]
  )]
    
//---------------------------------------------|  LOGIC  |---------------------------------------------//

// States
#let document-state = state("doc-state", "none")

// Outline state, used for the flexCaption function
#let _in-outline = state("in-outline", false)

// Document state functions help keep the main file clean. Use for example "#show: mainmatter" to begin the main part of the document.
// Beginning of the frontmatter
#let frontmatter(body) = {
  pagebreak(weak: true, to: "odd")
  set page(numbering: "I", footer: _front-footer())
  set heading(outlined: false, bookmarked: true, numbering: none)
  document-state.update("front")
  body
}

// Beginning of the mainmatter
#let mainmatter(body) = {
  pagebreak(weak: true, to: "odd")
  set heading(numbering: _chapter-numbering, outlined: true)
  set page(header: context state("header").get(), numbering: "1", footer: _main-footer())
  counter(page).update(1)
  counter(heading).update(0)
  document-state.update("main")
  body
}

// Beginning of the backmatter (Appendix)
#let backmatter(body) = {
  pagebreak(weak: true, to: "odd")
  set heading(numbering: _appendix-chapter-numbering)
  set figure(numbering: _appendix-figure-numbering)
  set math.equation(numbering: _appendix-equation-numbering)
  show heading.where(level: 1): set heading(supplement: [Appendix])
  counter(heading).update(0)
  document-state.update("back")
  body
}

//---------------------------------------------|  THESIS  |---------------------------------------------//

// Thesis template
#let thesis(
  thesis-title: none,
  thesis-title-sv: none,
  thesis-subtitle: none,
  thesis-subtitle-sv: none,
  short-title: [#degree-level-en's thesis],
  authors: none,
  supervisors: none,
  examiner: none,
  course-code: [EITM01],
  affiliations: none,
  description: none,
  keywords: (),
  document-style: "original",
  front-cover-background: rect(width: 100%, height: 100%, fill: lu-light-brown),
  date: datetime.today(),
  report-number: none,
  issn: none,
  print: false,
  body
  ) = {

// Assertions for required arguments
  assert(thesis-title != none, message: "Missing required argument 'thesis-title'.")
  assert(authors != none, message: "Missing required argument 'authors'.")
  assert(supervisors != none, message: "Missing required argument 'supervisors'.")
  assert(examiner != none, message: "Missing required argument 'examiner'.")

  // Assertions for variable types
  assert(type(authors) == array, 
    message: "Variable 'authors' must be of type array ((name, email),)."
  )
  assert(type(supervisors) == dictionary, 
    message: "Variable 'supervisors' must be of type dictionary (academic: (name, email, affiliation), company: (name, email, affiliation))."
  )
  assert(type(examiner) == dictionary,  
    message: "Variable 'examiner' must be of type dictionary (name, email)."
  )
  assert(type(keywords) == array, 
    message: "Variable 'keywords' must be of type array."
  )
  assert(type(print) == bool, 
    message: "Variable 'print' must be of type boolean."
  )
  assert(type(date) == datetime, 
    message: "Variable 'date' must be of type datetime."
  )
  assert(type(front-cover-background) == content, 
    message: "Variable 'front-cover-background' must be of type content."
  )

  // Assertions for logic and specific values
  assert(not (report-number == none and print), message: "Thesis must have a report-id to be printed!")
  
  assert(document-style in ("original", "novel"), 
    message: "Variable 'doucument-style' must be either 'original' (default) or 'novel'."
  )

  if document-style == "original"{
    state("header").update(_header-original())
    state("heading").update(_ => _heading-original)
  }
  else if document-style == "novel"{
    state("header").update(_header-alternating())
    state("heading").update(_ => _heading-new)
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
    first-line-indent: 1.5em, 
    spacing: 1.5em,
    leading: 0.5em
  )

  set page(
    number-align: center + bottom,
    footer-descent: 0% + 7.5mm,
    header-ascent: 0% + 7.5mm,
    binding: left
  )

  // Calculated necessary margins for the document depending if print == true or false. sis-g5 has dimensions 169x239mm
  let (g5-width, g5-height) = (169mm, 239mm)
  let (a4-width, a4-height) = (210mm, 297mm)
  let (a4-offset-width, a4-offset-height) = ((a4-width - g5-width) / 2, (a4-height - g5-height) / 2)
  
  let (body_width, body_height) = (125mm, 200mm)
  let inside = 1in
  let outside = g5-width - inside - body_width
  let vertical =  (g5-height - body_height) / 2

  // Sets only if print == false, adds a G5 box to the pages and some information on top
  set page(
    paper: "a4",
    margin: (
      inside: inside + a4-offset-width,
      outside: outside + a4-offset-width,
      rest: vertical + a4-offset-height,
      ),
    background: [
      #set text(size: 12pt)
      #place(center, dy: 22.5mm, stack(
        dir: ltr,
        spacing: 1cm,
        emph(short-title),
        date.display("[year]/[month padding:none]/[day padding:none]"),
        [page #context(counter(page).display())],
        [#sym.hash #context(here().page())]
      ))
      #align(center + horizon, rect(stroke: 0.2mm, width: g5-width, height: g5-height))
    ]
  ) if print == false

  set page(
    paper: "sis-g5",
    margin: (
      inside: inside,
      outside: outside,
      rest: vertical
    ),
  ) if print == true
  
  // Text
  set text(
    lang: "en",
    font: font-main,
    fill: colour-main,
    weight: "regular",
    size: size-main,
  )

  show smallcaps: set text(tracking: 0.5pt)
  
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
    gap: 1em
  )

  // Figures
  show figure.where(kind: table): set figure.caption(position: top)
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

  // Terms, used mainly in the abbreviations or nomenclature section
  set terms(tight: false, spacing: 5mm)

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
    _in-outline.update(true)
    it
    _in-outline.update(false)
  }
  show outline.entry: outline-entry
  
  // Headings
  set heading(supplement: [Section])
  show heading: set text(weight: "semibold")
  show heading: set par(leading: 1em, justify: false)
  show heading.where(level: 1): set heading(supplement: [Chapter])
  show heading.where(level: 1): set block(below: 3em)
  show heading.where(level: 2): set block(above: 2em, below: 1em)
  show heading.where(level: 2): set text(size: size-sub-heading)
  show heading.where(level: 3): set block(above: 1.5em, below: 1em)
  show heading.where(level: 3): set text(size: size-sub-sub-heading)
  
  // Figures out which heading to place depending on the state of the document
  show heading.where(level: 1): it => context{ pagebreak(weak: true, to: "odd") + _resetCounters() + state("heading").get()(it)}
  
  // Bibliography
  set bibliography(title: "References" ,style: "ieee")

  // Quotes
  set quote(block: true)
  show quote: set block(inset: 2mm)

  // Beginning of document
  
  // Front cover page, if print is true
  if print == true {_front-cover-page(
    thesis-title,
    front-cover-background,
    authors,
    degree-level-en,
    department-en,
  )}

  // Blank page
  if print == true {
    page(align(bottom + left, text(style: "italic", "Blank page — remove in final print.")))
    pagebreak(to: "odd")
  }
  
  // Title page
  _title-page(
    thesis-title, 
    thesis-subtitle,
    authors,
    supervisors,
    examiner,
    degree-level-en,
    department-en,
    ("LundUniversity_C_BLACK.png",) + if affiliations != none {
      affiliations.map(affiliation => affiliation.logo)
    },
    date
  )
  
  // Information of thesis, on verso of title page
  _information-page(
    thesis-title,
    thesis-title-sv,
    thesis-subtitle,
    thesis-subtitle-sv,
    authors,
    if affiliations != none {affiliations.map(affiliation => affiliation.name)},
    supervisors,
    examiner,
    course-code,
    issn,
    department-en,
    date
  )

  counter(page).update(1)
  body

  // Backcover, if print is true
  if print == true {_back-cover(
    degree-level-en,
    department-en,
    department-short-en,
    department-link,
    report-number,
    date)}
}

//---------------------------------------------|  POPULAR SCIENCE SUMMARY |---------------------------------------------//

// Template for the popular science summary paper. Based on the LaTeX version from department of computer science (CS) at LTH.
#let popular-science-summary(
  summary-title: none,
  original-title: none,
  authors: none,
  supervisors: none,
  examiner: none,
  lead-paragraph: none,
  thesis-link: none,
  presentation-date: datetime.today(),
  lang: "sv",
  body
) = {
  
  // Assertions for required arguments
  assert(summary-title != none, message: "Missing required argument 'summary-title'.")
  assert(original-title != none, message: "Missing required argument 'original-title'.")
  assert(authors != none, message: "Missing required argument 'authors'.")
  assert(supervisors != none, message: "Missing required argument 'supervisors'.")
  assert(examiner != none, message: "Missing required argument 'examiner'.")
    
  // Assertions for logic and specific values
  assert(lang in ("sv", "en"), 
    message: "Variable 'lang' must be either 'en' or 'sv' ('sv' by default)."
  )
  
  // Assertions for variable types
  assert(type(authors) == array, 
    message: "Variable 'authors' must be of type array."
  )
  assert(type(supervisors) == dictionary, 
    message: "Variable 'supervisors' must be of type dictionary (academic: (name, email, affiliation), company: (name, email, affiliation))."
  )
  assert(type(examiner) == dictionary, 
    message: "Variable 'examiner' must be of type dictionary (name, email)."
  )
  assert(type(presentation-date) == datetime, 
    message: "Variable 'presentation-date' must be of type datetime.")

  // Dictionary containing predetermined words and sentences in both english and swedish.
  let language-fields = (
    sv: (
      department: department-sv,
      faculty: "LTH | Lunds Universitet",
      degree-project: "Examensarbete",
      student-singular: "Student",
      students-plural: "Studenter",
      supervisor-singular : "Handledare",
      supervisors-plural : "Handledare",
      examiner: "Examinator",
      popular-science-summary: "Populärvetenskaplig sammanfattning",
      presented: "Presenterad",
      availability: "Tillgänglig vid",
      figure-supplement: "Figur",
      and-label: "och"
    ),
    
    en: (
      department: department-en,
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
      figure-supplement: "Figure",
      and-label: "and"
    )
  )

  // Information box about the degree project found in the top of the paper
  let information() = {
    set text(size: size-secondary)
    set par(first-line-indent: 0pt, spacing: 5mm)
    
    let spacing = 0.5em
    let students = ""
    let supervisor-label = ""
    
    if authors.len() > 1 {students = "students-plural"} else {students = "student-singular"}
    if supervisors.len() > 1 {supervisor-label = "supervisors-plural"} else {supervisor-label = "supervisor-singular"}
    box(
      stroke: (left: (thickness: 1pt, paint: lu-bronze, cap: "round")),
      outset: 3mm,
      [
        #language-fields.at(lang).at("department") | #language-fields.at(lang).at("faculty") | #language-fields.at(lang).at("presented") #presentation-date.display("[day padding:none] [month repr:long] [year]") 
        
        #parbreak()
        
        #strong(upper(language-fields.at(lang).at("degree-project"))) #h(spacing) #original-title #linebreak()
        #strong(upper(language-fields.at(lang).at(students))) #h(spacing) #authors.map(author => author.name).join(", ", last: " & ")
        #linebreak()
        #strong(upper(language-fields.at(lang).at(supervisor-label))) #h(spacing) #supervisors.values().map(supervisor => [#supervisor.name (#supervisor.affiliation)]).join(", ", last: " " + language-fields.at(lang).at("and-label") + " ") #linebreak()
        #strong(upper(language-fields.at(lang).at("examiner"))) #h(spacing) #examiner.name

        #parbreak()

        #if thesis-link != none [#language-fields.at(lang).at("availability") #link(thesis-link)]
      ]
    )
  }

  set text(size: size-main, font: font-secondary, lang: lang)
  
  set heading(level: 2, outlined: false, bookmarked: false)
  show heading: it => context {h(- par.first-line-indent.amount); it.body + [ ]}
  show heading: set text(font: font-main, fill: lu-bronze)
  show heading: smallcaps
  
  set figure(supplement: language-fields.at(lang).at("figure-supplement"), numbering: "1")
  set document(
    author: authors.map(author => author.name),
    date: presentation-date,
    title: summary-title
  )
  set par(justify: true, first-line-indent: (amount: 1em, all: true))
  
  show title: set text(size: size-heading, font: font-main,  fill: lu-bronze)
  
  show link: set text(fill: lu-blue)
  
  // The paper itself
  page(margin: (top: 1.5cm, rest: 2cm))[
    #block(below: 2em, 
      grid(
        rows: 4,
        gutter: 1.5em,
        information(),
        [#language-fields.at(lang).at("popular-science-summary") | *#authors.map(author => author.name).join(", ", last: " & ")*],
        title(),
        par(first-line-indent: 0pt, strong(text(lead-paragraph, font: font-main, size: size-sub-sub-heading)))
      )
    )
    #columns(2, gutter: 2em, body)
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

  // Assertions for required arguments
  assert(tentative-title != none, message: "Missing required argument 'tentative-title'.")
  assert(authors != none, message: "Missing required argument 'authors'.")
  assert(start-date != none, message: "Missing required argument 'start-date'.")
  assert(end-date != none, message: "Missing required argument 'end-date'.")
  assert(course-code != none, message: "Missing required argument 'course-code'.")
  assert(academic-supervisor != none, message: "Missing required argument 'academic-supervisor'.")
  assert(examiner != none, message: "Missing required argument 'examiner'.")

  // Assertions for logic and specific values
  assert(lang in ("sv", "en"), 
    message: "Variable 'lang' must be either 'sv' or 'en' ('en' by default)."
  )

  // Assertions for variable types
  assert(type(authors) == array, 
    message: "Variable 'authors' must be of type array."
  )
  assert(type(start-date) == datetime, 
    message: "Variable 'start-date' must be of type datetime."
  )
  assert(type(end-date) == datetime, 
    message: "Variable 'end-date' must be of type datetime."
  )

  // Dictionary containing predetermined words and sentences in both english and swedish.
  let language-fields = (
    sv : (
      subtitle-phrase: "Ett Måldokument för Examensarbete på " + str(degree-level-sv),
      by-phrase: "Av",
      department-phrase: [#department-sv \ Lunds Tekniska Högskola, LTH, Lunds Universitet \ SE-221 00 Lund, Sverige],
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
      subtitle-phrase: "A Goal Document for " + str(degree-level-en) +  "'s Thesis Work",
      by-phrase: "By",
      department-phrase: [#department-en \ Faculty of Engineering, LTH, Lund University \ SE-221 00 Lund, Sweden],
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
      #language-fields.at(lang).at(student-label): #authors.map(author => author.name).join(", ", last: language-fields.at(lang).at("and-label")) 
      #linebreak()
      #language-fields.at(lang).at(civic-number-label): #authors.map(author => author.civic-number).join(", ", last: language-fields.at(lang).at("and-label")) #linebreak()
      #language-fields.at(lang).at("email"): #authors.map(author => author.email).join(",", last: language-fields.at(lang).at("and-label"))
      #linebreak()
      #language-fields.at(lang).at("academic-supervisor"): #academic-supervisor.name, #link("mailto:" + academic-supervisor.email )
      #linebreak()
      #language-fields.at(lang).at("examiner"): #examiner.name, #link("mailto:" + examiner.email)
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
      academic-supervisor.name,
      examiner.name)
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
  
  // Assertions for required arguments
  assert(academic-supervisor != none, 
    message: "Missing required argument 'academic-supervisor'.")
  assert(examiner != none,
    message: "Missing required argument 'examiner'.")

  // Assertions for logic and specific values
  assert(lang in ("sv", "en"),
    message: "Variable lang must be either 'sv' or 'en' ('en' by default).")

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
      academic-supervisor.name,
      examiner.name)
  }
  set text(font: font-secondary, lang: lang)
  set figure(supplement: [Fig])

  body 

  block(above: 2cm, signing())
}
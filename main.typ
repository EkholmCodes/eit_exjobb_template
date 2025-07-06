#import "./src/exjobb_eit.typ": *
#import "./src/style.typ": *

//Document settings and template
#show: doc.with(
	final: true
)

//Begining of document
#counter(page).update(1)

//Frontmatter
#set pagebreak(weak: true, to: "odd")
#set heading(outlined: false, bookmarked: true)
#show heading.where(level: 1): front-matter-heading
#set page(numbering: "i")

#include "./content/front-matter.typ"

//Formatting and styling for chapters
#pagebreak()
#set page(numbering: "1", header: [#header()], footer: footer())
#counter(page).update(1)
#set heading(numbering: chapter-numbering, outlined: true)

#show heading.where(level: 1): chapter-heading
#show heading.where(level: 1): set heading(supplement: [Chapter])

//Chapters
#include "./content/chapters/introduction.typ"
#include "./content/chapters/theory.typ"
#include "./content/chapters/about_typst.typ"

//References
#show heading.where(level: 1): front-matter-heading
#bibliography("./content/bibliography.bib", title: "References", style: "ieee")

//Appendix
#set pagebreak(weak:false, to: none)
#pagebreak()
#show heading.where(level: 1): appendix-heading
#show heading.where(level: 1): set heading(supplement: [Appendix])
#set heading(numbering: "A.1")
#counter(heading).update(0)
#include "./content/appendix.typ"
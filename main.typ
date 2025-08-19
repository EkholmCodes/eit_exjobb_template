#import "./src/exjobb_eit.typ": *
#import "./src/style.typ": *

//Document settings and template
#show: doc.with(
	print: true,
	thesis_description: "Hej hej!",
	thesis_keywords: "Halloj!"
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
#set page(numbering: "1", header: header(), footer: footer())
#counter(page).update(1)
#set heading(numbering: chapter-numbering, outlined: true)
#show heading.where(level: 1): chapter-heading

//Chapters
#include "./content/chapters/introduction.typ"
#include "./content/chapters/theory.typ"
#include "./content/chapters/about_typst.typ"

//References
#show heading.where(level: 1): front-matter-heading
#bibliography("./content/bibliography.bib", title: "References", style: "ieee")

//Appendix
#pagebreak()
#set pagebreak(to: none)
#show heading.where(level: 1): appendix-heading
#show heading.where(level: 1): set heading(supplement: [Appendix])
#set heading(numbering: "A.1")
#set figure(numbering: appendix-figure-numbering)
#counter(heading).update(0)
#include "./content/appendix.typ"
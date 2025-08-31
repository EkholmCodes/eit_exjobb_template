#import "./src/exjobb_eit.typ": *
#import "./src/style.typ": *

//Document settings and template
#show: doc.with(
	print: false,
	title: "A Test of EIT_exjobb.typ",
	description: "Hej hej!",
	keywords: "Halloj!",
	examinor: "Some examinor",
	supervisor: "Some supervisor",
	authors: (
		(
			name: "Student A",
			affiliation: none,
			email: "Student.A@mail.com"
		),
		(
			name: "Student B",
			affiliation: "Lund University",
			email: "Student.B@mail.com"
		),
		(
			name: "Student C",
			affiliation: "SAAB",
			email: "Student.C@mail.com"
		)
	),
	company: "Some company",
	front_images: (("../content/media/LTH_RGB_ENG.png"), ("../content/media/LTH_BLACK_ENG.png"), ("../content/media/Lunds_universitet_C2r_RGB.png"))
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
#counter(heading).update(0)
#set pagebreak(to: none)
#show heading.where(level: 1): appendix-heading
#show heading.where(level: 1): set heading(supplement: [Appendix])
#set heading(numbering: "A.1")
#set figure(numbering: appendix-figure-numbering)
#pagebreak()
#include "./content/appendix.typ"
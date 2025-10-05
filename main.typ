#import "./src/exjobb_eit.typ": *

//Document settings and template
#show: doc.with(
	print: false,
	title: "A Test of exjobb_eit.typ",
	short-title: "A shorter title",
	description: "Hej hej!",
	keywords: "Halloj!",
	examinor: "Some examinor",
	supervisors: ("Academic Supervisor: Some Supervisor", "Company Supervisor: Another Supervisor"),
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
			affiliation: none,
			email: "Student.C@mail.com"
		)
	),
	affiliations: ([Department of Electrical and Information Technology \ Lund University], [Some company?], [Another affiliation]),
	front_images: (("../content/media/LTH_RGB_ENG.png"), ("../content/media/LTH_BLACK_ENG.png")),
	date: datetime(year: 2021, month: 10, day: 12)
)

//Frontmatter
#show: frontmatter
#include "./content/front-matter.typ"

//Chapters
#show: mainmatter
#include "./content/chapters/introduction.typ"
#include "./content/chapters/theory.typ"
#include "./content/chapters/about_typst.typ"

//References
#bibliography("./content/bibliography.bib", title: "References", style: "ieee")

//Appendix
#show: backmatter
#include "./content/appendix.typ"
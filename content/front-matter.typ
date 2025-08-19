= The Frontmatter

Welcome to the template for the exjobbsreport at EIT! Made by Lucas Ekholm (E22). My motivation for making this is simple: I don't like LaTeX and I love Typst, simple as that.

To start I will introduce some basic concepts. To write in this template you (the writer) only have to do basic styling, everything else is taken care of. The heading above ("The Frontmatter") is of depth 1. All headings inside the the frontmatter have this styling. How do you determine the depth of your heading? Simply by looking at how many "=" appears in the code. The frontmatter in this template only has a level 1 headings. Meaning you can only use "=" for these, all other levels do not have styling. 

Here is a quote:
#align(center)[
	#quote(block: true, quotes: true, attribution: [Markus Törmänen, spring 2025])[
		To mature as an electrical engineer is to realize everything is about impedances.
	]
]

Example of some abbreviations or acronyms:

#set terms(tight: false, spacing: 5mm)
#for (abb, des) in (
	"EIT": "Department of Electrical and Information Technology",
	"LED": "Let's Emit Dazzle",
	"MOSFET" : "Mostly Our Small Friend Enabling Transistor",
	"EITF80": "Energy Isn’t Truly Free",
	"AC" : "Actually Confusing",
	"CODE" : "Computers Only Do Exactly (what you tell them)",
	"PING" : "Packet Is Now Going"
).pairs().sorted() [/ #abb: #des]

#pagebreak()
#outline(title: [Table of Contents], target: heading)

#pagebreak()
#outline(title: [List of Figures], target: figure.where(kind: image))
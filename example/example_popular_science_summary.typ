#import "../src/exjobb_eit.typ": popular-science-summary
#import "metadata.typ": *
#import "@preview/droplet:0.3.1": dropcap

#show: popular-science-summary.with(
  summary-title:[The title should contain a maximum of 100 characters #lorem(7)],
  original-title: title,
  authors: authors,
  supervisors: supervisors,
  examiner: examiner,
  lead-paragraph: [The lead paragraph (abstract) should contain a maxmimum of 200 characters/35 words given the maximum is reached on the title. #lorem(35 - 12)],
  thesis-link: "https://www.student.lth.se/english/masters-students/degree-project/popular-science-readership/",
  presentation-date: end-date,
  lang: "en"
)

#dropcap(
    height: 3,
    gap: 4pt,
    hanging-indent: 1em,
    overhang: 10pt,
    font: "EB Garamond")[
      #lorem(115) 
]

= In total, there are exactly 3118 characters in the body and should be a maximum of 3000

#lorem(150)
#parbreak()
#lorem(150)
#parbreak()
#lorem(30)
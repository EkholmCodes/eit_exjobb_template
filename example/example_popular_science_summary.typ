#import "../src/exjobb_eit.typ": popular-science-summary
#import "@preview/droplet:0.3.1": dropcap

#show: popular-science-summary.with(
  summary-title:[The title should contain a maximum of 100 characters #lorem(7)],
  original-title: [Test of exjobb_eit.typ],
  authors: ("Student A", "Student B"),
  supervisor: ("Some supervisor",),
  examiner: "Some examiner",
  lead-paragraph: [The lead paragraph (abstract) should contain a maxmimum of 200 characters/35 words given the maximum is reached on the title. #lorem(35 - 12)],
  thesis-link: "https://www.student.lth.se/english/masters-students/degree-project/popular-science-readership/",
  presentation-date: datetime(day: 22, month: 10, year: 2022),
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

= In total, there are exactly 3061 characters in the body and should be a maximum of 3000
#lorem(91)
#colbreak()
#lorem(95)
#parbreak()
#lorem(138)
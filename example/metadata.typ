/* Metadata for the thesis project */

#let title = [Test of exjobb_eit.typ #lorem(10)]
#let subtitle = [An unofficial Typst template for degree project at LTH]
#let authors = (
    (
      name: "Student Alpha",
      email: "Student.A@mail.com",
      civic-number: "010101-0101",
    ),
    (
      name: "Student Beta",
      affiliation: "Lund University",
      email: "Student.B@mail.com",
      civic-number: "020202-0202",
    ),
  )
#let supervisors = (
  academic: (
    name: "Academic Supervisor",
    email: "academic.supervisor@eit.lth.se",
    affiliation: "LTH"
  ),
  company : (
    name: "Company Superisor",
    email: "company.supervisor@company.com",
    affiliation: "Company name"
  ),
)
#let examiner = (
  name: "Examiner",
  email: "academic.examiner@eit.lth.se"
)
#let affiliations = ([Some company],)

#let start-date = datetime(year: 2004, month: 3, day: 21)
#let end-date = datetime(year: 2022, month: 10, day: 22)
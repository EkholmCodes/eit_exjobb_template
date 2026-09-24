/* Metadata for the degree project */

#let title = [Test of exjobb_eit.typ]
#let subtitle = [An unofficial Typst template for degree project at LTH]

#let authors = (
    (
      name: "John Doe",
      email: "john.doe@examplemail.com",
      civic-number: "010101-0101",
    ),
    (
      name: "Jane Doe",
      affiliation: "Lund University",
      email: "jane.doe@examplemail.com",
      civic-number: "020202-0202",  
    ),
  )
 
#let supervisors = (
  academic: (
    name: "Academic Supervisor",
    email: "academic.supervisor@eit.lth.se",
    affiliation: "LTH"
  ),
  company: (
    name: "Company Superisor",
    email: "company.supervisor@company.com",
    affiliation: "Company name"
  ),
  company2: (
    name: "A second supervisor",
    email: "company.supervisor2@company.com",
    affiliation: "Company"
  )
)

#let examiner = (
  name: "Examiner",
  email: "academic.examiner@eit.lth.se"
)

#let affiliation = (
  (
    name: "Some company",
    logo: none
  ),
)

#let keywords = ("Keyword 1", "Keyword 2")
#let start-date = datetime(year: 2004, month: 3, day: 21)
#let end-date = datetime(year: 2022, month: 10, day: 22)
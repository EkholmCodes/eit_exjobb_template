#import "../src/exjobb_eit.typ": goal-document, project-plan

#let supervisor = "Your Supervisor"
#let examiner = "Your Examiner"
#let lang = "sv"

#show: goal-document.with(
  thesis-title:[Title],
  authors: ((
    name: "Student A",
    civic-number: "010101-0101",
    email: "StudentA@student.lu.se"
  ),
  (
    name: "Student B",
    civic-number: "020202-0202",
    email: "StudentB@student.lu.se"
  )),
  start-date: datetime(day: 1, month: 1, year: 2022),
  end-date: datetime(day: 22, month: 10, year: 2022),
  course-code: "ETIM01",
  academic-supervisor: supervisor,
  examiner: examiner,
  lang: lang,
)

= Introduction

= Background and Motivation

= Project Aims and Main Challenges

= Approach and Methodology

= Previous work

= Advancements and Outcome

= Resources

#show: project-plan.with(
  academic-supervisor: supervisor,
  examiner: examiner,
  lang: lang
)
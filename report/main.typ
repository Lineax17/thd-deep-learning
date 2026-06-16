#import "@preview/charged-ieee:0.1.4": ieee

// ===================================
// Thesis Title Page & Front Matter
// ===================================
#let titleDE = "Projektarbeit\nDeep Learning und Big Data"
#let titleEN
#let student = "Nico Dilger"
#let matrnr = "22302719"
#let student2 = "Peter Okruhlica"
#let matrnr2 = "22300246"
#let student3 = "Philipp Hartmann"
#let matrnr3 = "22209467"
#let student4 = "Bojidar Ivanov"
#let matrnr4 = "00000000"
#let submissiondate = "28. Juni 2026"
#let supervisor = "Prof. Dr. Isabel Hübener"
#let secsupervisor
#let studies = "Bachelor Künstliche Intelligenz"
#let faculty = "Angewandte Informatik"

#set page("a4", numbering: "1")
#set text(font: "Libertinus Serif", lang: "de", size: 11pt)
#show heading: set block(above: 1.4em, below: 1em)

#align(center)[
  #v(3cm)
  #text(size: 20pt, weight: "bold")[#titleDE]
  
  #v(1cm)
  #text(size: 16pt)[#titleEN]
  
  #v(2.5cm)
  #text(size: 14pt)[
    Prüfungsstudienarbeit \
    
    im Studiengang #studies \
    an der Fakultät #faculty
  ]
  
  #v(2.5cm)
  #text(size: 14pt)[
    Vorgelegt von: \
    *#student* — Matrikelnummer: #matrnr \
    *#student2* — Matrikelnummer: #matrnr2 \
    *#student3* — Matrikelnummer: #matrnr3 \
    *#student4* — Matrikelnummer: #matrnr4 \
  ]
  
  #v(1.5cm)
  #text(size: 14pt)[
    Betreuer: #supervisor \
    #if secsupervisor != none [Zweitprüfer: #secsupervisor \ ]
  ]
  
  #v(1.5cm)
  #text(size: 14pt)[
    Eingereicht am: #submissiondate
  ]
]

#pagebreak()

// ===================================
// Declaration of originality
// ===================================
#heading(level: 1, outlined: false)[Eigenständigkeitserklärung]

Wir erklären hiermit, dass wir die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet haben. \ \

#v(2cm)
#line(length: 100%, stroke: 0.5pt)
Ort, Datum #h(1fr) Unterschriften

#pagebreak()

// ===================================
// Table of Contents
// ===================================
#outline(title: "Inhaltsverzeichnis", depth: 3, indent: auto)

#pagebreak()
#set page(numbering: "1")

// ===================================
// IEEE Paper Content
// ===================================
#show: ieee.with(
  title: titleDE,
  abstract: [
    The abstract goes here.
  ],
  authors: (
    (
      name: student,
      department: studies,
      organization: faculty,
      location: [Deggendorf, Germany],
      email: "nico.dilger@stud.th-deg.de"
    ),
    (
      name: student2,
      department: studies,
      organization: faculty,
      location: [Deggendorf, Germany]
    ),
    (
      name: student3,
      department: studies,
      organization: faculty,
      location: [Deggendorf, Germany]
    ),
    (
      name: student4,
      department: studies,
      organization: faculty,
      location: [Deggendorf, Germany]
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 {
    numbering("I.", n.at(0))
  } else if n.len() == 2 {
    numbering("1.", n.at(1))
  } else if n.len() <= 4 {
    n.slice(1).map(str).join(".")
  } else {
    none
  }
})

#show heading.where(level: 3): it => block(above: 1.2em, below: 0.6em)[
  #set text(weight: "bold", style: "normal", size: 10pt)
  #if it.numbering != none [
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #h(0.5em)
  ]
  #it.body
]

#show heading.where(level: 4): it => block(above: 1.0em, below: 0.4em)[
  #set text(weight: "bold", style: "italic", size: 10pt)
  #if it.numbering != none [
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #h(0.5em)
  ]
  #it.body
]

#show heading.where(level: 5): it => block(above: 0.8em, below: 0.4em)[
  #set text(weight: "regular", style: "italic", size: 10pt)
  #if it.numbering != none [
    #numbering(it.numbering, ..counter(heading).at(it.location()))
    #h(0.5em)
  ]
  #it.body
]


#include "01_problem.typ"
#include "02_dataset.typ"
#include "03_from_scratch.typ"
#include "04_transferlearning.typ"
#include "05_results.typ"
#include "06_comparision.typ"
#include "07_discussion.typ"

//#include "text.typ"
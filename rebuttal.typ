#set page(margin: 3cm)
#set text(font: "New Computer Modern", size: 11pt)

// --- Colors ---
#let mygray = luma(230)
#let mygreen = rgb(102, 204, 102)

// --- Rebuttal box helpers ---
#let _rebuttal-box(fill: white, label: none, body) = {
  v(0.5em)
  block(
    width: 100%,
    fill: fill,
    inset: 10pt,
    radius: 0pt,
    {
      if label != none {
        align(right, text(size: 0.8em, style: "italic", label))
        v(0.5em)
      }
      body
    },
  )
}

#let issue(body) = _rebuttal-box(fill: white, body)

#let answer(body) = _rebuttal-box(
  fill: mygray,
  label: "Response",
  body,
)

#let changed(body) = _rebuttal-box(
  fill: mygreen,
  label: "Quote from new version of manuscript",
  body,
)

#let issuetodo(body) = _rebuttal-box(
  fill: aqua.lighten(20%),
  label: "TODO (main author)",
  body,
)

#let issueothers(body) = _rebuttal-box(
  fill: orange.lighten(40%),
  label: "TODO (co-authors)",
  body,
)

// --- Document ---

#align(center)[
  #text(size: 17pt, weight: "bold")[
    Point-by-point reply to the reviewer comments
  ]
  #v(5mm)
  #text(size: 12pt)[Manuscript ID: LOREM-IPSUM-1234569] \
  #text(size: 12pt)[Title: A Paper about Things and Stuff]
]

#v(1em)

// Just in case editor has written something
// = Associate Editor
// #issue[Dear Dr. NAME,]

= Reviewer 1

#issue[The thing is bad in ways because of stuff]

#answer[
  We fixed the thing about the stuff.
  As the reviewer noted, #quote[the thing is bad], and we have addressed this.

  #changed[
    Our stuff has a variety of things, and also stuff.
  ]
]

// If you want to separate reviewers cleanly
// #pagebreak()

= Reviewer 2

#issue[I don't like your face]

#answer[
  Oh no

  #issuetodo[
    Get face replacements
  ]
]

#issue[I don't like everyone elses's face]

#answer[
  Oh no as well

  #issueothers[
    Move to Guatemala and become sheep herders
  ]
]

#set page(margin: 3cm, numbering: "1")
#set text(font: "New Computer Modern", size: 11pt)
#set par(spacing: 0.65em)
#show heading.where(level: 1): set block(above: 1.2em, below: 0.5em)

// --- Colors ---
#let mygray = luma(230)
#let mygreen = rgb(102, 204, 102)

// --- Counters ---
#let _reviewer-counter = counter("reviewer")
#let _question-counter = counter("question")

#let _current-label() = {
  let r = _reviewer-counter.get().first()
  let q = _question-counter.get().first()
  "R" + str(r) + "-Q" + str(q)
}

// --- Rebuttal box helpers ---
#let _rebuttal-box(fill: white, label: none, label-align: right, body) = {
  v(0.3em)
  block(
    width: 100%,
    fill: fill,
    inset: 8pt,
    radius: 2pt,
    {
      if label != none {
        align(label-align, text(size: 0.8em, style: "italic", label))
      }
      body
    },
  )
}

// #reviewer(n: 1) auto-increments, #reviewer(N) sets explicit number
#let reviewer(n: none) = {
  if n == none {
    _reviewer-counter.step()
  } else {
    _reviewer-counter.update(n)
  }
  _question-counter.update(0)
  context heading(level: 1, numbering: none, "Reviewer " + str(_reviewer-counter.get().first()))
}

#let issue(body) = {
  _question-counter.step()
  v(0.3em)
  context block(
    width: 100%,
    fill: white,
    inset: 8pt,
    radius: 0pt,
    {
      text(weight: "bold", size: 0.9em, _current-label())
      v(0.2em)
      body
    },
  )
}

#let answer(body) = {
  context _rebuttal-box(
    fill: mygray,
    label: _current-label() + " — Response",
    label-align: left,
    body,
  )
}

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
  #v(3mm)
  #text(size: 12pt)[Manuscript ID: LOREM-IPSUM-1234569] \
  #text(size: 12pt)[Title: A Paper about Things and Stuff]
  #v(2mm)
  #datetime.today().display("[month repr:long] [day], [year]")
]

#v(0.5em)

// Just in case editor has written something
// = Associate Editor
// #issue[Dear Dr. NAME,]

#reviewer(n: 1)

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

#reviewer(n: 2)

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

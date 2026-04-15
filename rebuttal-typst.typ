#set page(margin: 3cm, numbering: "1")
#set text(font: "New Computer Modern", size: 11pt)
#set par(spacing: 0.65em)
#show heading.where(level: 1): set block(above: 1.2em, below: 0.5em)
// Issue figures: no caption, no extra spacing, left-aligned
#show figure.where(kind: "issue"): set figure(gap: 0pt)
#show figure.where(kind: "issue"): set align(left)
#show figure.where(kind: "issue"): it => it.body
// Cross-references: @R1-Q1 prints "R1-Q1" as link
#show ref: it => {
  if it.element != none and it.element.func() == figure and it.element.has("kind") and it.element.kind == "issue" {
    link(it.element.location(), it.element.counter.display(it.element.numbering))
  } else {
    it
  }
}

// --- Colors (matching LaTeX version) ---
#let mygray = rgb("#EBEBEB")
#let mygreen = rgb("#75D279")
#let mycyan = rgb("#00C6F5")        // custom cyan
#let myorange = rgb("#FFB300")

// --- Counters ---
#let _reviewer-counter = counter("reviewer")
#let _question-counter = counter("question")

#let _current-label() = {
  let r = _reviewer-counter.get().first()
  let q = _question-counter.get().first()
  "R" + str(r) + "-Q" + str(q)
}

// --- Rebuttal box helpers ---

// Radius for issue and answer boxes
#let box-radius = 3pt

#let _rebuttal-box(fill: white, label: none, label-align: right, body) = {
  v(0.3em)
  block(
    width: 100%,
    fill: fill,
    inset: 8pt,
    radius: box-radius,
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

#let issue(lbl: none, body) = {
  _question-counter.step()
  v(0.3em)
  context {
    let tag = _current-label()
    let fig = figure(
      kind: "issue",
      supplement: none,
      numbering: _ => tag,
      block(
        stroke: 0.1pt,
        width: 100%,
        fill: white,
        inset: 8pt,
        radius: box-radius,
        {
          text(weight: "bold", size: 0.9em, tag)
          v(0.2em)
          body
        },
      ),
    )
    if lbl != none { [#fig #lbl] } else { fig }
  }
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
  fill: mycyan,
  label: "TODO (main author)",
  body,
)

#let issueothers(body) = _rebuttal-box(
  fill: myorange,
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
  #v(1em)
  #datetime.today().display("[month repr:long] [day], [year]")
]

#v(1em)

// Just in case editor has written something
// = Associate Editor
// #issue[Dear Dr. NAME,]

#reviewer(n: 1)

#issue(lbl: <R1-Q1>)[The thing is bad in ways because of stuff]

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
  Oh no as well (see also our response to @R1-Q1).

  #issueothers[
    Move to Guatemala and become sheep herders
  ]
]

# Journal Review Response Template

A simple, self-contained template for writing point-by-point responses to peer review comments. Available in **LaTeX** and **[Typst](https://typst.app/)**.

## Markup helpers

Color-coded boxes distinguish reviewer comments, responses, and changes at a glance:

| Purpose | LaTeX | Typst | Color |
|---------|-------|-------|-------|
| Reviewer comment | `\issue{...}` | `#issue[...]` | White |
| Your response | `\answer{...}` | `#answer[...]` | Gray |
| Quote from revised manuscript | `\changed{...}` | `#changed[...]` | Green |
| TODO (main author) | `\issuetodo{...}` | `#issuetodo[...]` | Cyan |
| TODO (co-authors) | `\issueothers{...}` | `#issueothers[...]` | Orange |

## Files

- **LaTeX**: `rebuttal.tex` — self-contained.
- **Typst**: `rebuttal-template.typ` (the reusable library: markup helpers + `conf`) and
  `rebuttal-typst.typ` (an example document that imports it). Copy **both** into
  your project; edit only `rebuttal-typst.typ`.

> Typst cannot import a template directly from a GitHub URL — remote/git imports
> are [not supported](https://github.com/typst/typst/discussions/3125). To reuse
> this template, copy `rebuttal-template.typ` alongside your rebuttal document.

## Usage

1. Pick your format — `rebuttal.tex` (LaTeX), or `rebuttal-typst.typ` + `rebuttal-template.typ` (Typst)
2. Fill in manuscript ID, title, and responses
3. Compile locally or use an online editor (see below)

### Online editors

No local installation needed — copy the template file(s) to one of these:

- **LaTeX**: Upload `rebuttal.tex` to [Overleaf](https://www.overleaf.com/)
- **Typst**: Upload **both** `rebuttal-typst.typ` and `rebuttal-template.typ` to [typst.app](https://typst.app/)

### Local builds

Requires `latexmk` with a LaTeX distribution (e.g. TeX Live) for LaTeX, or the [`typst`](https://github.com/typst/typst) compiler for Typst.

```sh
make all                 # Build both PDFs
make rebuttal.pdf        # Build LaTeX PDF only
make rebuttal-typst.pdf  # Build Typst PDF only
make tidy                # Remove auxiliary files
make clean               # Remove all generated files
```

### LaTeX

```latex
\section*{Reviewer 1}

\issue{The reviewer's comment goes here.}

\answer{
  Your response to the comment.

  \changed{
    Quoted text from the revised manuscript showing what changed.
  }
}
```

### Typst

Import the library and apply `conf` once at the top, then write reviewers and
issues:

```typst
#import "rebuttal-template.typ": *

#show: conf.with(
  manuscript-id: "LOREM-IPSUM-1234569",
  paper-title: "A Paper about Things and Stuff",
)

#reviewer(n: 1)

#issue[The reviewer's comment goes here.]

#answer[
  Your response to the comment.

  #changed[
    Quoted text from the revised manuscript showing what changed.
  ]
]
```

`#reviewer(n: N)` sets the number used in the `RN-Q…` cross-reference tags and
prints a `Reviewer N` heading. Pass `name:` to append a parenthetical to that
heading, e.g. when reviewers are identified by the editor's comment file rather
than a plain number:

```typst
#reviewer(n: 1, name: "1-review-5")  // -> "Reviewer 1 (1-review-5)"
```

Each `#issue` takes an optional label for cross-referencing, e.g.
`#issue(lbl: <R1-Q1>)[…]`, referenced elsewhere with `@R1-Q1`. Response boxes
(`#answer`, `#changed`, `#issuetodo`, `#issueothers`) stay on a single page
rather than splitting across a page break.

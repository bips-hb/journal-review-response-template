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

## Usage

1. Pick your format — `rebuttal.tex` (LaTeX) or `rebuttal-typst.typ` (Typst)
2. Fill in manuscript ID, title, and responses
3. Compile locally or use an online editor (see below)

### Online editors

No local installation needed — copy the template file to one of these:

- **LaTeX**: Upload `rebuttal.tex` to [Overleaf](https://www.overleaf.com/)
- **Typst**: Upload `rebuttal-typst.typ` to [typst.app](https://typst.app/)

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

```typst
= Reviewer 1

#issue[The reviewer's comment goes here.]

#answer[
  Your response to the comment.

  #changed[
    Quoted text from the revised manuscript showing what changed.
  ]
]
```

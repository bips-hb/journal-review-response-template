# Journal Review Response Template

A simple, self-contained LaTeX template for writing point-by-point responses to peer review comments.

## Preview

The template provides color-coded boxes to clearly distinguish between reviewer comments, your responses, and quoted changes from the revised manuscript:

| Command | Purpose | Color |
|---------|---------|-------|
| `\issue{...}` | Reviewer comment | White |
| `\answer{...}` | Your response | Light gray |
| `\changed{...}` | Quote from revised manuscript (nest inside `\answer`) | Green |
| `\issuetodo{...}` | Unresolved issue / TODO | Cyan |
| `\issueothers{...}` | Issue delegated to co-authors | Orange |

All boxes are breakable across pages via `tcolorbox`.

## Usage

1. Clone or download this template
2. Edit `rebuttal.tex` — fill in your manuscript ID, title, and responses
3. Build with `make` (or `latexmk -pdf rebuttal.tex`)

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

## Building

```sh
make            # Build PDF
make tidy       # Remove auxiliary files
make clean      # Remove all generated files including PDF
```

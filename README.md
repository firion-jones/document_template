# Document Template

## Dependencies

- **Pandoc**: Used for converting Markdown files to PDF. Install from https://pandoc.org/
- **LaTeX**: Required for PDF generation. Install a TeX distribution such as TeX Live or MiKTeX.
- **CSL file**: The citation style file `harvard-cite-them-right.csl` must be present in the project root.

## Project Structure

- `markdown/` — Place your Markdown chapter files here.
- `images/` — Place images to be included in the document here.
- `references.bib` — Place your bibliography entries here (BibTeX format).
- `header.tex` — Custom LaTeX header for Pandoc.
- `Makefile` — Automates the build process.

## Building the Document

To build all individual PDFs for each Markdown file:

```sh
make
```

To build a single combined PDF of all chapters:

```sh
make combined
```

To build a combined PDF for submission (without table of contents):

```sh
make submission
```

To clean all generated files:

```sh
make clean
```

## Notes
- Ensure all dependencies are installed and available in your PATH.
- The Makefile expects all citation and style files to be in the project root.
- For more help, run:

```sh
make help
```
# document_template

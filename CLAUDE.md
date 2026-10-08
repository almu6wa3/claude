# File → Markdown conversion (MarkItDown)

This repo is set up to convert files to Markdown with [MarkItDown](https://github.com/microsoft/markitdown).
The SessionStart hook (`.claude/hooks/session-start.sh`) installs Python and `markitdown[all]` if missing.

When the user asks (in any language, e.g. "حوّل هذا الملف إلى Markdown") to convert a file:

1. Locate the file (repo, an attachment, a URL, or Google Drive via the connector — download it first).
2. Run: `markitdown "<input>" -o "converted/<name>.md"`
   - Missing CLI? Run `.claude/hooks/session-start.sh` first.
   - URLs (web pages, YouTube) can be passed directly: `markitdown "<url>" -o converted/<name>.md`.
   - **Arabic/RTL PDFs:** markitdown (pdfminer) outputs reversed text in presentation-form glyphs.
     Check the output; if Arabic looks garbled, extract with poppler instead and normalize:
     `pdftotext in.pdf - | python3 -c "import sys,unicodedata,re;t=unicodedata.normalize('NFKC',sys.stdin.read());print(re.sub('[\u200e\u200f\u202a-\u202e\u2066-\u2069]','',t))"`
     then fix spacing around Latin words and rebuild headings/lists by hand.
3. Show the user a short preview and send them the `.md` file.
4. Commit and push the result only if the user wants it kept.

Supported: PDF, Word (.docx), PowerPoint (.pptx), Excel (.xlsx/.xls), HTML, CSV, JSON, XML,
images (EXIF metadata), audio (transcription), ZIP (each file inside), EPUB, Outlook .msg, YouTube URLs.

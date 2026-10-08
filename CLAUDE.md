# File → Markdown conversion (MarkItDown)

This repo is set up to convert files to Markdown with [MarkItDown](https://github.com/microsoft/markitdown).
The SessionStart hook (`.claude/hooks/session-start.sh`) installs Python and `markitdown[all]` if missing.

When the user asks (in any language, e.g. "حوّل هذا الملف إلى Markdown") to convert a file:

1. Locate the file (repo, an attachment, a URL, or Google Drive via the connector — download it first).
2. Run: `markitdown "<input>" -o "converted/<name>.md"`
   - Missing CLI? Run `.claude/hooks/session-start.sh` first.
   - URLs (web pages, YouTube) can be passed directly: `markitdown "<url>" -o converted/<name>.md`.
3. Show the user a short preview and send them the `.md` file.
4. Commit and push the result only if the user wants it kept.

Supported: PDF, Word (.docx), PowerPoint (.pptx), Excel (.xlsx/.xls), HTML, CSV, JSON, XML,
images (EXIF metadata), audio (transcription), ZIP (each file inside), EPUB, Outlook .msg, YouTube URLs.

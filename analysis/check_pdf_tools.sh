#!/bin/bash
for c in libreoffice soffice pandoc xelatex wkhtmltopdf weasyprint; do
  printf '%-12s ' "$c"
  command -v "$c" || echo NO
done
echo '--- chinese fonts ---'
fc-list :lang=zh | head -10

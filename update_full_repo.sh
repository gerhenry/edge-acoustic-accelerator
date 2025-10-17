#!/data/data/com.termux/files/usr/bin/bash
set -e

GA_ID="G-XXXXXXXXXX"  # <-- replace with your GA4 Measurement ID

echo "🚀 Updating Edge Acoustic Accelerator with SEO + GA + Git push"

# Inject Google Analytics tag
inject_ga () {
  local f="$1"
  [ -f "$f" ] || return 0
  if grep -qi "googletagmanager.com/gtag/js" "$f"; then
    echo "✅ GA already present in $f"
    return 0
  fi

  GA="<script async src=\"https://www.googletagmanager.com/gtag/js?id=$GA_ID\"></script><script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','$GA_ID');</script>"

  if grep -qi "</head>" "$f"; then
    sed -i "s#</head>#$GA\n</head>#I" "$f"
  else
    tmp=$(mktemp)
    echo "$GA" | cat - "$f" > "$tmp" && mv "$tmp" "$f"
  fi
  echo "✅ GA injected into $f"
}

inject_ga "index.html"
inject_ga "prototypes/index.html"

# Git add + commit + push
git add .
git commit -m "Full update: GA, SEO, and analog prototype integration"
git push

echo "🎯 Done — everything updated and pushed successfully."

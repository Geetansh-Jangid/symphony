#!/bin/bash
# Compress wallpapers for faster clone
# Run this before committing themes

for img in themes/*/backgrounds/*.{png,jpg,jpeg,webp} 2>/dev/null; do
    [[ -f "$img" ]] || continue
    
    size=$(stat -c%s "$img" 2>/dev/null || stat -f%z "$img" 2>/dev/null)
    size_mb=$((size / 1024 / 1024))
    
    # Only compress if > 2MB
    if [[ $size_mb -gt 2 ]]; then
        echo "Compressing: $img (${size_mb}MB)"
        
        # Resize to 1080p height max, convert PNG to JPG
        if [[ "$img" == *.png ]]; then
            magick "$img" -resize x1080 -quality 85 "${img%.png}.jpg" 2>/dev/null && rm "$img"
        else
            magick "$img" -resize x1080 -quality 85 "$img.tmp" 2>/dev/null && mv "$img.tmp" "$img"
        fi
    fi
done

echo "Done. Check sizes with: du -sh themes/*/backgrounds/"

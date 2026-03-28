#!/usr/bin/env python3
"""
Update all DataTable DOM configurations across the project to the new
standardized layout with dt-scroll-body-wrapper and dt-fixed-footer.
"""
import os
import re

NEW_DOM = '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"<"col-sm-12"rt>><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>'

# Old dom patterns to replace
OLD_PATTERNS = [
    # Pattern 1: admin_panel files with 3-col footer (l|i|p)
    '<"row align-items-center mb-3"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"row"<"col-sm-12"rt>><"row align-items-center mt-3 pt-2 border-top"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-4 text-center"i><"col-sm-12 col-md-4 d-flex justify-content-end"p>>',
    # Pattern 2: admin_panel files with 2-col footer (i|pl)
    '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"row"<"col-sm-12"rt>><"row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
    # Pattern 3: simple dom string
    'Bfrtilp',
]

BASE = "/home/aarbaj_mulla/aarbaj/cims/public/js"
DIRS = [
    os.path.join(BASE, "admin_panel"),
    os.path.join(BASE, "admin"),
]

updated_files = []
skipped_files = []

for dir_path in DIRS:
    if not os.path.isdir(dir_path):
        print(f"DIR NOT FOUND: {dir_path}")
        continue
    for fname in os.listdir(dir_path):
        if not fname.endswith('.js'):
            continue
        if fname == 'global_datatable_setup.js':
            continue
        fpath = os.path.join(dir_path, fname)
        if not os.path.isfile(fpath):
            continue
        with open(fpath, 'r', encoding='utf-8') as f:
            content = f.read()

        original = content
        changed = False

        for old_pat in OLD_PATTERNS:
            if old_pat in content:
                content = content.replace(old_pat, NEW_DOM)
                changed = True

        if changed:
            with open(fpath, 'w', encoding='utf-8') as f:
                f.write(content)
            updated_files.append(fpath)
        else:
            if re.search(r'\bdom\s*:', content):
                skipped_files.append(fpath)

print(f"\n=== UPDATED {len(updated_files)} FILES ===")
for f in updated_files:
    print(f"  OK: {os.path.basename(f)}")

if skipped_files:
    print(f"\n=== SKIPPED {len(skipped_files)} (dom not matching known patterns) ===")
    for f in skipped_files:
        print(f"  WARN: {os.path.basename(f)}")

print("\nDONE!")

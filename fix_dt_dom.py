#!/usr/bin/env python3
import os

OLD = '<"row align-items-center mt-3 pt-2 border-top"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-4 text-center"i><"col-sm-12 col-md-4 d-flex justify-content-end"p>>'
NEW = '<"row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>'

DIR = "/home/aarbaj_mulla/aarbaj/cims/public/js/admin_panel"
FILES = ["stock.js", "purchase_return.js", "sales_return.js", "reports.js", "company.js", "add_customer.js", "sales_list.js"]

for fname in FILES:
    path = os.path.join(DIR, fname)
    if os.path.exists(path):
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        if OLD in content:
            content = content.replace(OLD, NEW)
            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"FIXED: {fname}")
        else:
            print(f"SKIP (not found): {fname}")
    else:
        print(f"NOTFOUND: {fname}")

print("ALL DONE")

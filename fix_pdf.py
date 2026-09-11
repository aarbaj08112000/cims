import os

filepath = 'public/js/admin/category.js'
with open(filepath, 'r') as f:
    content = f.read()

content = content.replace("widths.push('*');", "widths.push((100/colCount)+'%');")

with open(filepath, 'w') as f:
    f.write(content)
print("Done")
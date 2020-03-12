import sys
indent = 0
last = []
print("digraph G {")
for line in sys.stdin:
	count = 0
	while line.startswith("\t"):
		count += 1
		line = line[1:]
	if count > indent:
		indent += 1
		last.append(last[-1])
	elif count < indent:
		indent -= 1
		last = last[:-1]

	line = line.strip().replace('"', '\\"')
	if line.endswith("?"):
		print('"'+line+'"', "[shape=diamond]")
	elif line.endswith("."):
		print('"'+line+'"', "[shape=ellipse]")
	else:
		print('"'+line+'"', "[shape=box]")

	if len(last) > 0:
		label = ""
		if last[-1].endswith("?"):
			if len(last) > 1 and  last[-1] == last[-2]:
				label = '[label="No"]'
			else:
				label = '[label="Yes"]'
		print('"'+last[-1]+'"', '->', '"'+line+'"', label)

	last = last[:-1]
	last.append(line)
print("}")
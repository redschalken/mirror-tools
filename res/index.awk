#!/usr/bin/awk -f

BEGIN {
		has_epub = system("test -d ./epub") == 0
		has_mobi = system("test -d ./mobi") == 0
		has_pdf  = system("test -d ./pdf")  == 0

		print "<!DOCTYPE html>"
		print "<title>redtexts.org mirror</title>"
		print "<meta name=\"viewport\" content=\"width=device-width, initial-scale=0.9\" />"
		print "<meta charset=\"utf-8\" />"
		print "<link rel=\"stylesheet\" href=\"./style.css\">"
		while ((getline < "./res/header.txt") > 0)
				print;
		print "<table><thead><tr><th>Title</th><th>Date</th>"
		if (has_epub)	print "<th>Epub</th>"
		if (has_mobi)	print "<th>Kindle</th>"
		if (has_pdf)	print "<th>PDF</th>"
		print "</tr></thead><tbody>"
		FS = "\t"
}

@include "./res/idauth.awk"

{
		if ($1 != la) 
				print "<tr><th colspan=5 id=\"" idauth($1) "\"><a href=\"#" idauth($1) "\">" $1 "</a></th></tr>"
		la = $1;
		print "<tr>"
		print "<td><a href=\"./html/" $4 ".html\"><em>" $2 "</em></a></td>"
		print "<td><time>" $3 "</time></td>"
		if (has_epub)	print "<td><a href=\"./epub/" $4 ".epub\">&#x2198;</a></td>"
		if (has_mobi)	print "<td><a href=\"./mobi/" $4 ".mobi\">&#x2198;</a></td>"
		if (has_pdf)	print "<td><a href=\"./pdf/" $4 ".pdf\">&#x2198;</a></td>"
		print "</tr>"
}

END {
		print "</tbody></table>"
		while ((getline < "./res/footer.txt") > 0)
				print;
		print "<footer>"
		print "<a href=\"https://github.com/redtexts/mirror-tools\">mirror tools</a> |"
		print "<a href=\"keywords.html\">keywords</a> |"
		print "<a href=\"..\">web master</a>"
		print "</footer>"
}

run:
	swift run Run --log notice

kill-server:
       kill -9 $$(lsof -t -i :8080)

# lsof -i :8080 -sTCP:LISTEN |awk 'NR > 1 {print $2}'|xargs kill -15

MAKEFLAGS = --no-builtin-rules --no-builtin-variables --always-make
.DEFAULT_GOAL := help

SHELL  = /usr/bin/env bash


alp:
	alp -r --sum -f $(file) --aggregates '/api/users/\S+,/api/events/\S+,/api/events/\S+/sheets/\S+/\S+/reservation'

rotate:
	sh scripts/rotate_alplog.sh

restart:
	sh scripts/restart.sh

set-slow-log:
	sudo mysql -uisucon -pisucon -e "set global slow_query_log = 1"
	sudo mysql -uisucon -pisucon -e "set global long_query_time = 0"
	sudo mysql -uisucon -pisucon -e "set global log_queries_not_using_indexes = 1"
	sudo mysql -uisucon -pisucon -e "set global slow_query_log_file='/var/lib/mysql/slow.log'"

mysqldumpslow:
	sudo mysqldumpslow -s t /var/lib/mysql/slow.log > ~/tmp/slow.log
	sudo cp /dev/null /var/lib/mysql/slow.log

restart-mysql:
	sudo /etc/init.d/mysql restart

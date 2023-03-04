#!/bin/bash

api="https://api-spoiler.panfilov.tech"
sign=null
user_id=null

function authenticate() {
	# 1 - sign: (string): <sign>
	# 2 - user_id: (integer): <user_id>
	# 3 - vk_ts: (integer): <vk_ts>
	# 4 - vk_ref: (string): <vk_ref>
	sign=$1
	user_id=$2
	vk_ts=$3
	vk_ref=$4
}

function get_spoilers() {
	# 1 - limit: (integer): <limit - default: 10>
	curl --request GET \
		--url "$api/spoilers/get/all?limit=${1:-10}" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign"
}

function search_movie() {
	# 1 - query: (string): <query>
	curl --request GET \
		--url "$api/movies/search?language=ru-RU&query=$1" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign"
}

function get_movie_info() {
	# 1 - movie_id: (integer): <movie_id>
	curl --request GET \
		--url "$api/movies/get/$1" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign"
}

function get_movie_spoilers() {
	# 1 - movie_id: (integer): <movie_id>
	# 2 - limit: (integer): <limit - default: 10>
	curl --request GET \
		--url "$api/spoilers/get/film/$1?limit=${2:-10}" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign"
}

function insert_spoiler() {
	# 1 - movie_id: (integer): <movie_id>
	# 2 - text: (string): <text>
	curl --request POST \
		--url "$api/spoilers/insert" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign" \
		--data '{
			"film_id": "'$1'",
			"text": "'$2'"
		}'
}

function update_spoiler() {
	# 1 - spoiler_id: (integer): <spoiler_id>
	# 2 - movie_id: (integer): <movie_id>
	# 3 - text: (string): <text>
	curl --request POST \
		--url "$api/spoilers/update" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign" \
		--data '{
			"spoiler_id": "'$1'",
			"film_id": "'$2'",
			"text": "'$3'"
		}'
}

function delete_spoiler() {
	# 1 - spoiler_id: (integer): <spoiler_id>
	curl --request POST \
		--url "$api/spoilers/delete" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign" \
		--data '{
			"spoiler_id": "'$1'"
		}'
}

function like_spoiler() {
	# 1 - spoiler_id: (integer): <spoiler_id>
	curl --request POST \
		--url "$api/spoilers/like" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign" \
		--data '{
			"spoiler_id": "'$1'"
		}'
}

function get_spoiler_info() {
	# 1 - spoiler_id: (integer): <spoiler_id>
	curl --request GET \
		--url "$api/spoilers/get/one/$1" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign"
}

function report_user() {
	# 1 - user_id: (integer): <user_id>
	curl --request POST \
		--url "$api/users/report" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign" \
		--data '{
			"user_id: "'$1'"
		}'
}

function get_user_spoilers() {
	# 1 - user_id: (integer): <user_id>
	# 2 - limit: (integer): <limit - default: 10>
	curl --request GET \
		--url "$api/spoilers/get/user/$1?limit=${2:-10}" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: vk_access_token_settings=&vk_app_id=51515102&vk_are_notifications_enabled=0&vk_is_app_user=0&vk_is_favorite=0&vk_language=ru&vk_platform=desktop_web&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$user_id&sign=$sign"
}

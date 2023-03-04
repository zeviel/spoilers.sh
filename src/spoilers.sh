#!/bin/bash

api="https://api-spoiler.panfilov.tech"
sign=null
vk_user_id=null
vk_ts=null
vk_ref=null

function authenticate() {
	# 1 - sign: (string): <sign>
	# 2 - vk_user_id: (integer): <vk_user_id>
	# 3 - vk_ts: (integer): <vk_ts>
	# 4 - vk_ref: (string): <vk_ref>
	# 5 - access_token_settings: (string): <access_token_settings - default: >
	# 6 - are_notifications_enabled: (integer): <are_notifications_enabled: default: 0>
	# 7 - is_app_user: (integer): <is_app_user - default: 0>
	# 8 - is_favorite: (integer): <is_favorite - default: 0>
	# 9 - language: (string): <language - default: ru>
	# 10 - platform: (string): <platform - default: desktop_web>
	sign=$1
	vk_user_id=$2
	vk_ts=$3
	vk_ref=$4
	params="vk_access_token_settings=${5:-}&vk_app_id=51515102&vk_are_notifications_enabled=${6:-0}&vk_is_app_user=${7:-0}&vk_is_favorite=${8:-0}&vk_language=${9:-ru}&vk_platform=${10:-desktop_web}&vk_ref=$vk_ref&vk_ts=$vk_ts&vk_user_id=$vk_user_id&sign=$sign"
	echo $params
}

function get_spoilers() {
	# 1 - limit: (integer): <limit - default: 10>
	curl --request GET \
		--url "$api/spoilers/get/all?limit=${1:-10}" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: $params"
}

function search_movie() {
	# 1 - query: (string): <query>
	curl --request GET \
		--url "$api/movies/search?language=ru-RU&query=$1" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: $params"
}

function get_movie_info() {
	# 1 - movie_id: (integer): <movie_id>
	curl --request GET \
		--url "$api/movies/get/$1" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: $params"
}

function get_movie_spoilers() {
	# 1 - movie_id: (integer): <movie_id>
	# 2 - limit: (integer): <limit - default: 10>
	curl --request GET \
		--url "$api/spoilers/get/film/$1?limit=${2:-10}" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: $params"
}

function insert_spoiler() {
	# 1 - movie_id: (integer): <movie_id>
	# 2 - text: (string): <text>
	curl --request POST \
		--url "$api/spoilers/insert" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: $params" \
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
		--header "x-query-params: $params" \
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
		--header "x-query-params: $params" \
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
		--header "x-query-params: $params" \
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
		--header "x-query-params: $params"
}

function report_user() {
	# 1 - vk_user_id: (integer): <vk_user_id>
	curl --request POST \
		--url "$api/users/report" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: $params" \
		--data '{
			"user_id: "'$1'"
		}'
}

function get_user_spoilers() {
	# 1 - vk_user_id: (integer): <vk_user_id>
	# 2 - limit: (integer): <limit - default: 10>
	curl --request GET \
		--url "$api/spoilers/get/user/$1?limit=${2:-10}" \
		--user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36" \
		--header "content-type: application/json" \
		--header "x-query-params: $params"
}

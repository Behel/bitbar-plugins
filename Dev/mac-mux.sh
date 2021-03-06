#!/bin/bash

# <xbar.title>Mac-Mux</xbar.title>
# <xbar.version>v0.1</xbar.version>
# <xbar.image>https://i.imgur.com/7vjC2UU.jpg</xbar.image>
# <xbar.author>etopiei</xbar.author>
# <xbar.author.github>etopiei</xbar.author.github>
# <xbar.desc>This plugin makes it wasy to manage tmux from the menu bar.</xbar.desc>
# <xbar.dependencies>bash</xbar.dependencies>

# shellcheck source=/dev/null
source ~/.bash_profile
if [ "$1" = 'opensession' ]; then
		command='tmux attach -t '"$2"''
		osascript -e 'tell application "Terminal" to do script "'"$command"'"'
		osascript -e 'set window 1 of application "Terminal" to frontmost'
fi

if [ "$1" = 'newsession' ]; then
		osascript -e 'tell application "Terminal" to do script "tmux"'
		osascript -e 'tell application "Terminal" activate'
fi

output=$(tmux list-sessions &> /dev/null && tmux list-session | wc -l || echo "0")
number=$(echo "$output" | xargs)

if [ "$number" != '0' ]; then
	# here get all the session names in an array
	IFS=" " read -r -a nameArray <<< "$(tmux list-sessions | awk 'BEGIN{FS=":"}{print $1}')"
	echo "mac-mux ($number)"
	echo "---"
	echo "$number Running tmux sessions | color=white"
	echo "---"
	for i in "${nameArray[@]}"
	do
			echo "Open session: $i | bash='$0' param1=opensession param2=$i terminal=false"
	done
	echo "---"
	echo "Start new tmux session | bash='$0' param1=newsession terminal=false"
	exit
fi

echo "mac-mux"
echo "---"
echo "Start a tmux session | bash='$0' param1=newsession terminal=false"

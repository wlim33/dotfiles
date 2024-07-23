############# GLOBVAR/PREP ###############

name="$1"
Usage="\
	Usage: $(basename $0) <name> <command>
	<name>    : name the window has
	<command> : command used to launch window in case doesnt exist
	E.g.:  $(basename $0) terminal \"$TERMINAL --title=terminal\"
	"



############## USGCHECKS #################

if [[ $# -lt 1 || "$1" =~ ^(-h|--help)$ || $# -gt 2 ]]; then
	echo "$Usage"
	exit 1
fi

################ MAIN ####################

visible_wid="$(xdotool search --onlyvisible --name "^$name$" | tail -1 2> /dev/null)"

if [[ -z "$visible_wid" ]]; then # If the scratchpad window is not visible
	wid="$(xdotool search --name "^$name$" | tail -1 2> /dev/null)"
	if [[ -z "$wid" ]]; then       # If the scratchpad window does not exist
		if [[ $# -ne 2 ]]; then    # If a command to launch it was not provided
			echo "$name not found. A command was not provided to launch it."
			exit 2
		fi

		echo "$name not found. Executing: '$2'."
		if ! eval "$2 &" ; then
      echo "Provided command '$2' failed"
      exit $?
    fi
	fi

	# Wait for application to be available
	while [[ -z "$wid" ]]; do
		sleep 0.05;
		wid="$(xdotool search --name "^$name$" | tail -1 2> /dev/null)"
	done


fi

# echo "Hiding instance of $name."
# i3-msg "scratchpad show"
# exit $?

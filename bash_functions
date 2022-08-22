function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F --color=auto
}


# fuzzy find (case insensitive)
function ff() {
	local pattern="$1"
	shift
	if [ $# -eq 0 ]; then
		set -- .
	fi
	find "$@" | grep -i -- "$pattern"
}

#Function to refer .ssh/config to resolve hostname
function ping()
{
    # Process args
    local i=0
    local options=""
    local host=""
    for arg
    do
        i=$(($i+1))
        if [ "$i" -lt "$#" ]
        then
            options="${options} ${arg}"
        else
            host="${arg}"
        fi
    done

    # Find host
    local hostname=$(awk "\$1==\"Host\" {host=\$2} \$1==\"HostName\" && host==\"${host}\" {print \$2}" "$HOME/.ssh/config")
    if [ -z "$hostname" ]
    then
        hostname="$host"
    fi

    # Run ping
    /bin/ping $options $hostname
}

function hexmask()
{
    python3 hexmask.py $@
}

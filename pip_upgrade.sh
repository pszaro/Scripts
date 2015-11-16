#!/usr/bin/env bash
#
# Description: Upgrade all outdated python modules.
#
# ==============================================================================
usage() { cat <<- DOCUMENT

    usage: pip_upgrade [-h] [3]

    AUTHOR:      Sang Han
    CREATED:     08/23/2014
    REVISION:    1.0

    REQUIREMENTS:
        pip

    OPTIONS:
        [-h help]
            Prints this message

    COMMENTS:
        If all packages fail to install, pip might be configured to
        install in a root directory and will require sudo.

        But if need to use sudo, youre probaby doing it wrong in the first place.

	DOCUMENT
}


# Python Version
if (($#)) && (($1==3)); then readonly VERSION=3; else readonly VERSION=2; fi

# PIP Command
readonly PIP=pip"${VERSION}"

# ==============================================================================
# Command Line Arguments
# ==============================================================================
while getopts ":h" OPTION; do
    case ${OPTION} in
        h) usage
           exit 0
           ;;
       \?) echo "Invalid option: -${OPTARG}" >&2
           exit 1
           ;;
    esac
done
    shift $(($OPTIND-1))

# ==============================================================================
# Functions
# ==============================================================================
package_msg() {
    # Replace the status of package installation message with the result
    local status="$1" erase=$(sed 's/[A-z]/\\b/g' <<< "Installing")

    if [ "$status" = Success ]; then
        color=2
    fi

    printf "${erase}"

    printf "$(tput setaf ${color:-1})%-11s$(tput sgr0)\n" "${status}"
}

outdated() {
    # Unpack old modules and ignore external ones
    PIP list --outdated | sed -e 's/(.*//g' \
                              -e '/^Could/ d' \
                              -e '/^Some/ d'
}

# ==============================================================================
# Main
# ==============================================================================
main() {
    # Pack outdated modules into a list
    echo "Unpacking outdated packages for Python ${VERSION:=2}"

    local list=( $(outdated) )

    for ((i=0; i<"${#list[@]}"; i++)); do

        # Print package name
        printf "Package: %-20s $(tput setaf 6)Installing$(tput sgr0)" "${list[i]}"

        # Print Success Status
        if PIP install --upgrade "${list[i]}" &>/dev/null; then
            package_msg "Success"
        else
            package_msg "Fail"
        fi

    done
}

# ==============================================================================
# Entry Point
# ==============================================================================
if [ "${0}" = "${BASH_SOURCE}" ]; then
    main
fi


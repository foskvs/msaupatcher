#!/bin/zsh

RESULT=0
STATUS="false"
NO_ARG=1
SCRIPT_NAME=$0
ARG=$1
MSAU="Microsoft AutoUpdate"

check_status () {
    STATUS=$(launchctl print-disabled gui/$(id -u) | grep "microsoft.update" | cut -d ">" -f2- | cut -c2-)
}

enable_updater () {
    launchctl enable gui/$(id -u)/com.microsoft.update.agent
    check_status
        if [[ ${STATUS} == "false" ]];
        then
            RESULT=1
        fi
}

disable_updater () {
    launchctl disable gui/$(id -u)/com.microsoft.update.agent
    check_status
        if [[ ${STATUS} == "true" ]];
        then
            RESULT=1
        fi
}

no_args () {
    if [[ -z "$ARG" ]];
    then
        NO_ARG=1
    else
        NO_ARG=0
    fi
}

help_message () {
    echo Usage: "${SCRIPT_NAME} [arg]"
    echo
    echo Arguments:
    echo " -h, --help     Print help message"
    echo " -e, --enable   Enable $MSAU"
    echo " -d, --disable  Disable $MSAU"
    echo " -s, --status   Check $MSAU status (enabled/disabled)"
    echo
    echo "The script automatically enables/disables $MSAU if no arguments are provided"
    exit
}

print_status () {
    check_status
    if [[ ${STATUS} == "false" ]];
    then
        echo "Enabled"
    elif [[ ${STATUS} == "true" ]];
    then
        echo "Disabled"
    fi
    exit
}

invalid_argument () {
    echo Invalid argument. For more information use
    echo "${SCRIPT_NAME} -h"
}

no_args

if [ ${NO_ARG} -eq 1 ];
then
    check_status
    if [[ ${STATUS} == "false" ]];
    then
        echo "Disabling the updater..."
        disable_updater
    elif [[ ${STATUS} == "true" ]];
    then
        echo "Enabling the updater..."
        enable_updater
    fi
elif [[ ${1:0:2} == "--" ]];
then
    COMMAND_TO_RUN=$(echo $1 | cut -c3-)
    if [[ $COMMAND_TO_RUN == "enable" ]];
    then
        enable_updater
    elif [[ $COMMAND_TO_RUN == "disable" ]];
    then
        disable_updater
    elif [[ $COMMAND_TO_RUN == "help" ]];
    then
        help_message
    elif [[ $COMMAND_TO_RUN == "status" ]];
    then
        print_status
    else
        invalid_argument
    fi
elif [[ ${1:0:1} == "-" ]];
then
    COMMAND_TO_RUN=$(echo t$1 | cut -c3-)
    if [[ $COMMAND_TO_RUN == "e" ]];
    then
        enable_updater
    elif [[ $COMMAND_TO_RUN == "d" ]];
    then
        disable_updater
    elif [[ $COMMAND_TO_RUN == "h" ]];
    then
        help_message
    elif [[ $COMMAND_TO_RUN == "s" ]];
    then
        print_status
    else
        invalid_argument
    fi
fi



if [ ${RESULT} -eq 1 ];
then
    echo success
else
    echo failed
fi

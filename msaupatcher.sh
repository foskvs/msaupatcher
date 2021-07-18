#!/bin/zsh

RESULT=0
STATUS="false"
NO_ARG=1

check_status () {
    STATUS=$(launchctl print-disabled gui/$(id -u) | grep microsoft | cut -d ">" -f2- | cut -c2-)
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
    if [[ $1 == "" ]];
    then
    NO_ARG=1
    else
    NO_ARG=0
    fi
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
    fi
fi



if [ ${RESULT} -eq 1 ];
then
echo success
else
echo failed
fi

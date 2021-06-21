#!/bin/zsh

RESULT=0

if [[ ${1:0:2} == "--" ]];
then
COMMAND_TO_RUN=$(echo $1 | cut -c3-)
    if [[ $COMMAND_TO_RUN == "enable" ]];
    then
    launchctl enable gui/$(id -u)/com.microsoft.update.agent
    FFF=$(launchctl print-disabled gui/$(id -u) | grep microsoft | cut -d ">" -f2- | cut -c2-)
        if [[ ${FFF} == "false" ]];
        then
        RESULT=1
        fi
    elif [[ $COMMAND_TO_RUN == "disable" ]];
    then
    launchctl disable gui/$(id -u)/com.microsoft.update.agent
    FFF=$(launchctl print-disabled gui/$(id -u) | grep microsoft | cut -d ">" -f2- | cut -c2-)
        if [[ ${FFF} == "true" ]];
        then
        RESULT=1
        fi
    fi
fi

if [ ${RESULT} -eq 1 ];
then
echo success
else
echo failed
fi

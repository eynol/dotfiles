#!/bin/bash

# 保证shell只有一个实例运行
scriptNum=$(ps aux | grep monitNPM | grep -v grep | grep -v npmKiller | wc -l)
if [ $scriptNum -gt 2 ]; then
    echo $(ps aux | grep monitNPM | grep -v grep)
    echo "awsl. ScriptNum: $scriptNum"
    exit 0
fi
COMMAND="npm"      #命令名称
COMMAND_PATH="npm" # 命令在执行时执行的路径
MEMO=0
CPU_LIMIT="40"
LIMIT_PER_SECOND=30
IGNORE_COUNT=0

function monitExactProcess() {

    npmUsage=$(ps aux | grep $COMMAND | grep -v grep)
    if [ "$npmUsage" = "" ]; then
        if [ $MEMO -gt 0 ]; then let MEMO--; fi
        if [ $IGNORE_COUNT -gt 0 ]; then let IGNORE_COUNT--; fi
        return
    fi
    cpu=$(echo "$npmUsage" | awk '{print $3}')
    cpu=($cpu)

    pid=$(echo "$npmUsage" | awk '{print $2}')
    pid=($pid)

    count=(${#pid[*]})

    pname=$(echo "$npmUsage" | awk '{print $NF}')
    pname=($pname)

    # echo -e "${pid[@]}" #|awk '{print $1}'
    # echo ""
    # echo $count
    # echo -ne "$pid"
    # echo ""

    for i in $(seq 0 $(expr $count - 1)); do
        echo ${pname[$i]}
        echo $COMMAND_PATH
        if [ ${pname[$i]} = $COMMAND_PATH ]; then

            echo ${cpu[$i]}

            compa=$(echo "scale=4; ${cpu[$i]} > ${CPU_LIMIT} " | bc)
            if [ "$compa" = "0" ]; then
                if [ $MEMO -gt 0 ]; then let MEMO--; fi
                echo 未达到水平
            elif [ "$compa" = "1" ]; then
                echo 达到水平
                let MEMO++
            fi

            if [ $MEMO -ge $LIMIT_PER_SECOND ] && [ $IGNORE_COUNT -eq 0 ] ; then
                ans=$(npmKillWarning $MEMO)
                if [ "$ans" = "YES" ]; then
                    if kill ${pid[$i]}; then
                        osascript -e "display notification \"shell: good job! \" with title \"${COMMAND}: awsl!\" "
                    fi
                elif [ "$ans" = "IGNORE" ] ;then
                    let IGNORE_COUNT=15
                fi


            fi
            echo $compa
        fi
    done
}

function notify() {
    osascript -e 'display notification "hello world!" with title "This is the title"'
}

# error "Message"
function error() {
    osascript <<EOT
    tell app "System Events"
      display dialog "$1" buttons {"OK"} default button 1 with icon caution with title "$(basename $0)"
      return  -- Suppress result
    end tell
EOT
}

# prompt "Question" "Default value"
function prompt() {
    osascript <<EOT
    tell app "System Events"
      text returned of (display dialog "$1" default answer "$2" buttons {"OK"} default button 1 with title "$(basename $0)")
    end tell
EOT
}

function npmKillWarning() {
    osascript <<EOT
     button returned of ( display alert "Oooops! " message "A npm process is going crazy for $1 times, eterminate it ?" buttons ["YES", "NO", "IGNORE"] default button 2 giving up after 5 )
EOT
}


while :; do
    monitExactProcess
    sleep 1
done

#display dialog theDialogText buttons {"Don't Continue", "Continue"} default button "Continue" cancel button "Don't Continue"

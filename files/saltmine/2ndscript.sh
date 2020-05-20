#!/bin/bash

USERNAME="minecraft"
MAXRAM=1024
MINRAM=1024
OPTIONS='nogui'
SERVICE='server.jar'
INVOCATION="java -Xmx${MAXRAM}M -Xms${MINRAM}M -jar ${SERVICE} ${OPTIONS}"
LOG="/home/${USERNAME}/minecraft/logs/latest.log"
SPINNER=( "@aa" "a@a" "aa@" )

srv_start(){
	if sys_status > /dev/null ; then
		echo "server.jar is already running!"
	else
		echo "Starting server.jar"
		cd /home/${USERNAME}/minecraft  
		tmux new -d -s minecraft_server ${INVOCATION}
		gfx_spin &
		PID=$!
		disown
		sleep 4
		kill $PID
		if sys_status > /dev/null ; then
			echo -e "\rserver.jar is now running!"
		else
			echo -e "\rERROR! Could not start server.jar"
		fi
		gfx_sleep
		while true; do 
			
			if grep -q ": Done" ${LOG}; then
				echo -e "\rServer ready!"
				echo -e "\n"
				echo "Use the command '$0 ctl_opentmux' to open"
				echo "administration view on tmux or use the command"
				echo "'$0 help' to view available commands"
				gfx_sleep
				break
			else
				echo -e "\rWaiting for 'Done'"
				gfx_spin &
				PID=$!
				disown
				sleep 5
				kill $PID
			fi
		done

			
	fi	
}

srv_stop(){
	if sys_status > /dev/null ; then
		echo "Stopping server.jar"
		gfx_spin &
		PID=$!
		disown
		tmux send-keys -t minecraft_server.0 "say Server shutting down, saving map" ENTER
		tmux send-keys -t minecraft_server.0 "save-all" ENTER
		sleep 10
		tmux send-keys -t minecraft_server.0 "stop" ENTER
		sleep 7
		kill $PID
		echo -e '\r   '
	else
		echo "server.jar was not running"
	
	fi
	if sys_status > /dev/null ; then
		echo "server.jar could not be stopped!"
	else
		echo "server.jar is stopped"
		gfx_sleep
	fi
}

srv_status(){
	if sys_status > /dev/null ; then
		echo "server.jar is running!"
	else
		echo "server.jar is not running"
	fi
}

ctl_opentmux(){
	if sys_status > /dev/null ; then
		echo "Opening tmux screen"
		gfx_sleep
		tmux a -t minecraft_server
	else
		echo "server.jar is not running"
	fi
}

ctl_help(){
	echo -e "\n"
	echo "Available commands for $0"
	echo "'$0 start' - Starts the server"
	echo "'$0 stop' - Stops the server"
	echo "'$0 status' - Checks if the server is running"
	echo "'$0 opentmux' - Opens tmux for manual server administration'"
	gfx_sleep
}

sys_status(){
	pgrep -f ${SERVICE}
}

gfx_spin(){
	while [ 1 ]
	do
		for i in "${SPINNER[@]}"
		do
			echo -ne "\r$i"
			sleep 0.1
		done
	done
}

gfx_sleep(){
	sleep 1.5
}

case "$1" in
	start)
		srv_start
		;; 
	status)
		srv_status
		;;
	stop)
		srv_stop
		;;
	opentmux)
		ctl_opentmux
		;;
	help)
		ctl_help
		;;
	sys)
		sys_status
		;;
	*)
		echo "Unrecognized command $1, use the command"
		echo "'$0 help' to view available commands"
		;;
esac

#!/bin/bash
#===============================================================================
#
#          FILE:  pong.sh
# 
#         USAGE:  ./catNmouse.sh
# 
#   DESCRIPTION:  simple Cat N Mouse game
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  12/12/2012 04:44:55 PM EST
#      REVISION:  ---
#===============================================================================
x=""
i=0

X=$RANDOM
let "X %= 29"
Y=$RANDOM
let "Y %= 9"

loc[0]=$X
loc[1]=$Y

agentX=$RANDOM
let "agentX %= 29"
let agentX++
agentY=$RANDOM
let "agentY %= 9"
let agentY++

screenX=30
screenY=10
worldX=30
worldY=11

reset()
{
x=""
i=0

X=$RANDOM
let "X %= 29"
Y=$RANDOM
let "Y %= 9"

loc[0]=$X
loc[1]=$Y

agentX=$RANDOM
let "agentX %= 29"
let agentX++
agentY=$RANDOM
let "agentY %= 9"
let agentY++

draw "???"
}
_key()
{
  local kp
  ESC=$'\e'
  _KEY=
  read -d '' -sn1 _KEY
  case $_KEY in
    "$ESC")
        while read -d '' -sn1 -t1 kp
        do
          _KEY=$_KEY$kp
          case $kp in
            [a-zA-NP-Z~]) break;;
          esac
        done
    ;;
  esac
  printf -v "${1:-_KEY}" "%s" "$_KEY"
}

draw()
{
 echo "" > file.txt
 clear
#logic follows pattern if(this key) do this action
  if [ "$1" == "UP" ]; then
	
     let loc[1]++

	  if [ ${loc[1]} == $worldY ]; then
		let loc[1]--
	  fi

  fi

  if [ "$1" == "DOWN" ]; then
        let loc[1]--

	if [ ${loc[1]} == 0 ]; then
                let loc[1]++
        fi
  fi

  if [ "$1" == "LEFT" ]; then
        let loc[0]--

	if [ ${loc[0]} == -1 ]; then
                let loc[0]++
        fi
  fi

  if [ "$1" == "RIGHT" ]; then
        let loc[0]++
	
	if [ ${loc[0]} == $worldX ]; then
		let loc[0]--
	fi
  fi

  for(( i=$screenX; i>0; i--  ))
  do
  	echo -n "-" >> file.txt
  done  
  
echo "" >> file.txt

  for(( i=$screenY; i>0; i--  ))
  do
        echo -n "|" >> file.txt
          for(( j=0; j<$screenX; j++  ))
          do
	         #if the location of our x is the current (x,y) pair, put a "x" rather than a space 
		  if [ $i == ${loc[1]} ] && [ $j == ${loc[0]} ]; then
			echo -n "x" >> file.txt

		  elif [ $i == $agentY ] && [ $j == $agentX ]; then
			echo -n "a" >> file.txt
		  else
			  
          	  echo -n " " >> file.txt
          	  
		  fi
          done
	  	  
        echo  "|" >> file.txt
  done

 for(( i=$screenX; i>0; i--  ))
  do
        echo -n "-" >> file.txt
  done
echo "" >> file.txt


  cat file.txt
}

agent()
{
 move=$RANDOM
 let "move %= 2"

 
 if [ $agentX -lt ${loc[0]} ] && [ $agentY -lt ${loc[1]} ]; then
	 if [ $move == 0 ]; then
		let agentX++
		return
	 else
        	let agentY++
                return
 	 fi

 fi

 if [ $agentX -lt ${loc[0]} ] && [ $agentY -gt ${loc[1]} ]; then
         if [ $move == 0 ]; then
                let agentX++
                return
        else
                let agentY--
                return
        fi

 fi

 if [ $agentX -gt ${loc[0]} ] && [ $agentY -lt ${loc[1]} ]; then
         if [ $move == 0 ]; then
                let agentX--
                return
        
	 else
        
                let agentY++
                return
         fi

 fi

 if [ $agentX -gt ${loc[0]} ] && [ $agentY -gt ${loc[1]} ]; then
         if [ $move == 0 ]; then
                let agentX--
                return
        else

                let agentY--
                return
        fi

 fi

 if [ $agentX -lt ${loc[0]} ] && [ $agentY -eq  ${loc[1]} ]; then
        let agentX++
        return
 fi

 if [ $agentX -gt ${loc[0]} ] && [ $agentY -eq  ${loc[1]} ]; then
        let agentX--
        return
 fi

 if [ $agentX -eq ${loc[0]} ] && [ $agentY -lt  ${loc[1]} ]; then
        let agentY++
        return
 fi

 if [ $agentX -eq ${loc[0]} ] && [ $agentY -gt  ${loc[1]} ]; then
        let agentY--
        return
 fi

}

check_lose()
{

x1=${loc[0]}
x2=${loc[0]}
y1=${loc[1]}
y2=${loc[1]}

let x1++
let x2--
let y1++
let y2--

	if [ $agentX == ${loc[0]} ] && [ $agentY == ${loc[1]} ]; then
	echo "YOU LOSE!!! GOOD DAY SIR!"
	echo "Would you like to play again? (Y/N)"
	fi

	if [ $agentX == $x1 ] && [ $agentY == ${loc[1]} ]; then
        echo "YOU LOSE!!! GOOD DAY SIR!"
        echo "Would you like to play again? (Y/N)"
        fi

	if [ $agentX == $x2 ] && [ $agentY == ${loc[1]} ]; then
        echo "YOU LOSE!!! GOOD DAY SIR!"
        echo "Would you like to play again? (Y/N)"
        fi

	if [ $agentX == ${loc[0]} ] && [ $agentY == $y1 ]; then
        echo "YOU LOSE!!! GOOD DAY SIR!"
        echo "Would you like to play again? (Y/N)"
        fi

	if [ $agentX == ${loc[0]} ] && [ $agentY == $y2 ]; then
        echo "YOU LOSE!!! GOOD DAY SIR!"
        echo "Would you like to play again? (Y/N)"
        fi
}

draw "???"

while [ "$x" != "q" ]; do

_key x

case $x in
  $'\e[11~' | $'\e[OP') key=F1 ;;
  $'\e[12~' | $'\e[OQ') key=F2 ;;
  $'\e[13~' | $'\e[OR') key=F3 ;;
  $'\e[14~' | $'\e[OS') key=F4 ;;
  $'\e[15~') key=F5 ;;
  $'\e[16~') key=F6 ;;
  $'\e[17~') key=F7 ;;
  $'\e[18~') key=F8 ;;
  $'\e[19~') key=F9 ;;
  $'\e[20~') key=F10 ;;
  $'\e[21~') key=F11 ;;
  $'\e[22~') key=F12 ;;
  $'\e[A' ) key=UP ;;
  $'\e[B' ) key=DOWN ;;
  $'\e[C' ) key=RIGHT ;;
  $'\e[D' ) key=LEFT ;;
  ?) key=$x ;;
  *) key=??? ;;
esac

agent
draw $key
check_lose

if [ $key == "Y" ] || [ $key == "y" ]; then
reset
fi

if [ $key == "N" ] || [ $key == "n" ]; then
exit 0
fi
done

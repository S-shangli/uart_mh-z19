#!/bin/zsh -f

CODE_GETVALUE="ff0186000000000079"
CODE_CALZERO="ff0187000000000078"
CODE_CAL2000="ff018807d0000000a0"
CODE_CAL5000="ff0188130000000064"
CODE_RETVALUE_LEN_BYTE=9

function print_usage(){
    echo "Usage: ${1} TTY_DEVICE_FILE_PATH [calzero|calspan2000|calspan5000]"
    echo "Option: calzero    : Calibrate Zero Point"
    echo "        calspan2000: Calibrate Span Point (2000ppm)"
    echo "        calspan5000: Calibrate Span Point (5000ppm)"
    echo "Exmpl: ${1} /dev/ttyUSB0"
    echo "       ${1} /dev/ttyUSB0 calzero"
    echo "       ${1} /dev/ttyUSB0 calspan2000"
}




# check arg num
if [ 1 -ne ${#} -a 2 -ne ${#} ];
then
    echo "Error: missing or too many operand\n"
    print_usage ${0}
    exit 1
fi


# check tty
if [ ! -w "${1}" ];
then
    echo "Error: not exist or permission denied: ${1}\n"
    exit 1
fi
TARGET_TTY="${1}"


# check option
if [ 2 -eq ${#} ];
then
    case "${2}" in
        "calzero"     ) CODE="${CODE_CALZERO}" ;;
        "calspan2000" ) CODE="${CODE_CAL2000}" ;;
        "calspan5000" ) CODE="${CODE_CAL5000}" ;;
        * ) echo "Error: invalid option: ${2}\n";print_usage ${0}; exit 1 ;;
    esac
else
    CODE="${CODE_GETVALUE}"
fi




# setting serial: 9600baud binary
stty -F "${TARGET_TTY}" 9600 raw



# send
( sleep 1 ; echo "${CODE}" | xxd -r -p > "${TARGET_TTY}" ) &


# recv
timeout 2 dd if="${TARGET_TTY}" bs=1 count=${CODE_RETVALUE_LEN_BYTE} 2>/dev/null |\
  xxd -p | tr a-z A-Z | sed -e 's/^.\{4\}//g' -e 's/.\{10\}$//g' -e 's/^/ibase=16;/g' | bc



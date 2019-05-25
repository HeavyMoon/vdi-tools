#!/bin/bash
#################################################
#  RaspberryPi VDI TOOL
#################################################

#################################################
# MODE RDP
function mode_startx () {
## FIXME: change to switch link
cat << XXX > ~/.xinitrc
#!/bin/bash
blackbox &
remmina -c ~/profile.remmina
XXX

    startx
}

#################################################
# MODE EDIT CONF
function mode_editconf () {
## FIXME: change to switch link
cat << XXX > ~/.xinitrc 
#!/bin/bash
blackbox &
remmina
XXX

    startx
}

#################################################
# MODE SET CONNECTION PROFILE
function mode_conprof () {
    ## MAKE LIST
    list=()
    for file in $(ls ~/.remmina/*.remmina)
    do
        list+=("$file")
        list+=("$(cat $file | grep ^name= | cut -d= -f2)")
        list+=("OFF")
    done
    ## SHOW DIALOG
    RET=$(whiptail --title "SELECT A CONNECTION PROFILE" --radiolist "Choose a connection profile" 0 0 0 \
            ${list[@]} \
            3>&1 1>&2 2>&3)
    ## ACTION
    ln -s -f $RET ~/profile.remmina
}

#################################################
# MODE TERMINAL
function mode_terminal () {
    ## SHOW DIALOG
    whiptail --title "TERMINAL MODE" --yesno "Entering Terminal" 0 0 --defaultno 3>&1 1>&2 2>&3
    RET=$?

    ## ACTION
    if [ $RET -eq 0 ]; then ## YES
        exit 0
    else                    ## NO
        : RETURN TO MENU
    fi
}

#################################################
# MODE PREFERENCE
function mode_preferences () {
    ## SHOW DIALOG
    RET=$(whiptail --title "PREFERENCES" --menu "Choose an option" 0 0 0 --ok-button "SELECT" --cancel-button "BACK" \
            "1 Remmina Menu"                "" \
            "2 Select a Connection Profile" "" \
            "3 Terminal"                    "" \
            3>&1 1>&2 2>&3)
    ## ACTION
    case "$RET" in
        1\ *)   mode_editconf ;;
        2\ *)   mode_conprof ;;
        3\ *)   mode_terminal ;;
        *)      mode_default ;;
    esac
}

#################################################
# MODE DEFAULT
function mode_default () {
    : RETURN TO MENU
}

#################################################
# MAIN LOOP

MENU_COUNT=0
MENU_COUNT_MAX=20

while :
do
    ## SHOW DIALOG
    RET=$(whiptail --title "VDI Configuration Tool" --menu "Choose an option" 0 0 0 --nocancel --ok-button "SELECT" \
            "1 Connect"     "Remote Desktop" \
            "2 Preferences" "Preference Mode" \
            "3 Shutdown"    "Shutdown Raspi" \
            3>&1 1>&2 2>&3)
    ## ACTION
    case "$RET" in
        1\ *)   mode_startx ;;
        2\ *)   mode_preferences ;;
        3\ *)   mode_shutdown ;;    ## FIXME: define mode_shutdown
        *)      mode_default ;;
    esac

    ## ESCAPE FOR TEST
    MENU_COUNT=$(( MENU_COUNT +1 ))
    if [ $MENU_COUNT -gt $MENU_COUNT_MAX ]; then
        echo "ESC COUNT MAX..."
        exit 0
    fi
done


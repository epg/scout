# scout completion :-)
# A gift from Marek Stopka <mstopka@opensuse.org>

_scout() {
    SCOUT_CMDLIST=()
    SCOUT=`which scout`
    local opts cur prev prevprev
    if test ${#SCOUT_CMDLIST[*]} = 0; then
        for foo in $(LC_ALL=C $SCOUT 2>&1 | sed -e "1,/available modules:/d" | egrep [a-z] | awk -F ' ' '{print $1}'); do
            SCOUT_CMDLIST="$SCOUT_CMDLIST $foo"
        done
        SCOUT_CMDLIST="$SCOUT_CMDLIST"
    fi
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    if [[ ${#COMP_WORDS[@]} -ge 3 ]]; then
        prevprev=${COMP_WORDS[COMP_CWORD-2]}
    fi

    case "$prev" in
        scout)
            opts=$SCOUT_CMDLIST
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        ;;
        scoutcsv)
            opts=$SCOUT_CMDLIST
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        ;;
        scoutxml)
            opts=$SCOUT_CMDLIST
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        ;;
        autoconf)
            opts=`$SCOUT autoconf 2>&1 | sed -e "1,/Options:/d" | awk -F ', ' '{print $2}' | sed -e 's/ .*//' -e 's/--repo=REPO/--repo/'`
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        ;;
        bin)
            opts=`$SCOUT bin      2>&1 | sed -e "1,/Options:/d" | awk -F ', ' '{print $2}' | sed -e 's/ .*//' -e 's/--repo=REPO/--repo/'`
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        ;;
        java)
            opts=`$SCOUT java     2>&1 | sed -e "1,/Options:/d" | awk -F ', ' '{print $2}' | sed -e 's/ .*//' -e 's/--repo=REPO/--repo/'`
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        ;;
        webpin)
            opts=`$SCOUT webpin   2>&1 | sed -e "1,/Options:/d" | awk -F ', ' '{print $2}' | sed -e 's/ .*//' -e 's/--repo=REPO/--repo/'`
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        ;;
        --repo)
            if ($SCOUT $prevprev --listrepos | egrep "\- none \-" >/dev/null); then
                echo -e "\nNo repositories are available"
            else
                opts=`$SCOUT $prevprev --listrepos | sed 's/Available repositories://' | awk -F ' - ' '{print $1}'`
                COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
            fi
        ;;
    esac
}

complete -F _scout -X -o default scout
complete -F _scout -X -o default scoutcsv
complete -F _scout -X -o default scoutxml

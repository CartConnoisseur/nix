source "$(dirname "${BASH_SOURCE[0]}")/git-prompt.sh"

PROMPT_CHAR='❯'

if [[ "$TERM" == "xterm-kitty" ]]; then
    function prompt.bubble {
        printf '\[\e[49m\e[38;5;237m\]◖\[\e[48;5;237m\e[39m\]%s\[\e[0m\e[49m\e[38;5;237m\]◗\[\e[0m\]' "$@";
    }
elif [[ "$TERM" == "xterm-256color" ]]; then
    function prompt.bubble {
        printf '\[\e[38;5;237m\](\[\e[0m\]%s\[\e[0m\e[38;5;237m\])\[\e[0m\]' "$@";
    }
else
    PROMPT_CHAR='>'
    function prompt.bubble {
        printf '\[\e[2;39m\](\[\e[0m\]%s\[\e[0m\e[2;39m\])\[\e[0m\]' "$@";
    }
fi

function prompt.git {
    GIT_PS1_STATESEPARATOR=';'
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=
    GIT_PS1_SHOWUPSTREAM=

    GIT_PS1_HIDE_IF_PWD_IGNORED=1
    
    local git_ps1="$(__git_ps1)"
    git_ps1="${git_ps1##' ('}"
    git_ps1="${git_ps1%')'}"

    IFS=';' read -r branch state _ <<< "$git_ps1"

    if [[ -n "$branch" ]]; then
        printf ' '

        if [[ "$state" == '*' ]]; then
            prompt.bubble "$(printf '\[\e[4;32m\]%s' "$branch")"
        else
            prompt.bubble "$(printf '\[\e[32m\]%s' "$branch")"
        fi
    fi
}

function prompt.prepare {
    local err=$?
    PS1="\\[\e[0m\\]\n"

    local subshell=''
    local base_shlvl=1
    local shlvl=$((SHLVL-base_shlvl))

    if [[ -n "$IN_NIX_SHELL" ]]; then
        subshell="\\[\e[33m\\]nix"
    fi
    if [[ $shlvl != 0 && ! ($shlvl == 1 && -n "$IN_NIX_SHELL") ]]; then
        if [[ -n "$subshell" ]]; then subshell+="\\[\e[39m\\] "; fi
        subshell+="\\[\e[2;37m\\]$shlvl"
    fi
    if [[ -n "$subshell" ]]; then
        PS1+="$(prompt.bubble "$subshell") "
    fi

    if [[ $EUID == 0 ]]; then
        PS1+="$(prompt.bubble "\\[\e[4m\\]\u@\H")"
    else
        PS1+="$(prompt.bubble "\u@\H")"
    fi

    PS1+=" $(prompt.bubble "\\[\e[34m\\]\w")"
    PS1+="$(prompt.git)"
    if [[ $err != 0 ]]; then
        PS1+=" $(prompt.bubble "\\[\e[31m\\]$err")"
    fi
    PS1+=" $(prompt.bubble "$PROMPT_CHAR") "

    if [[ $err != 0 ]]; then
        (exit "$err")
    fi
}

PROMPT_COMMAND='prompt.prepare'

function baller {
    printf '🮲🮳⚽︎ \n'
}

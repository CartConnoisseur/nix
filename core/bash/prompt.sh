if [[ "$TERM" == "xterm-kitty" ]]; then
    source "$(dirname "${BASH_SOURCE[0]}")/git-prompt.sh"

    function prompt.bubble {
        printf '\[\e[49m\e[38;5;237m\]◖\[\e[48;5;237m\e[39m\]%s\[\e[0m\e[49m\e[38;5;237m\]◗\[\e[0m\]' "$@";
    }

    function prompt.bubble_squared {
        printf '\[\e[48;5;237m\e[39m\] %s\[\e[0m\e[49m\e[38;5;237m\]◗\[\e[0m\]' "$@";
    }

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

        PS1='\n'

        # change these to prompt.bubble_squared for squared user/hostname
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
        PS1+=" $(prompt.bubble "❯") "

        if [[ $err != 0 ]]; then
            (exit "$err")
        fi
    }

    PROMPT_COMMAND='prompt.prepare'
fi

function baller {
    printf '🮲🮳⚽︎ \n'
}

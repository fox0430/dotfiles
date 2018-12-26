set PATH /home/fox/.nimble/bin $PATH
export TERM=rxvt-unicode-256color

screenfetch

fish_vi_key_bindings

alias vi "vim"
alias DL "cd & cd ~/Downloads"
alias x "startx"
alias py "python"
alias rm "rm -v -i"
alias DC "/bin/bash ~/.config/fish/dysplayChange.sh"
alias cp "cp -v -i"
alias nmgui "/bin/bash ~/.config/fish/nmgui.sh"

function cd
    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = "-"
        if test "$__fish_cd_direction" = "next"
            nextd
        else
            prevd
        end
        return $status
    end
    builtin cd $argv
    set -l cd_status $status
    # Log history
    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    if test $cd_status -ne 0
        return 1
    end
    ls
    return $status
end

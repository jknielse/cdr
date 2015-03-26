_cdr_complete()
{
    local compstrings=""
    if [ -e ~/.cdrrc ]
    then
        flag=0
        for i in `cat ~/.cdrrc | tr '\n' ' '`
        do
            if [ $flag -eq 0 ]
            then
                compstrings="$compstrings $i"
                flag=1
            else
                flag=0
            fi
        done
    fi

    local cur=${COMP_WORDS[COMP_CWORD]}

    COMPREPLY=( $(compgen -W '$compstrings' -- $cur) )

    return 0
}

complete -F _cdr_complete cdr

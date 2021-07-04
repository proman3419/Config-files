cdekster () {
    gcc -std=gnu11 -O2 -Wall -Wconversion -Werror -o "E:/Documents/temp/compiled.exe" "$1" -lm && echo "Compiled, running" && echo && cat ~/.sublime_text/input | "E:/Documents/temp/compiled" | tee ~/.sublime_text/output
}

c () {
    cp "E:/Documents/programing/templates/c.c" "$1"
}

alias python="winpty python.exe"
alias cd_asd_repo="cd E:/Documents/agh/semestr_2/asd/asd_repo"
alias cd_pi_repo="cd E:/Documents/agh/semestr_2/pi/pi_repo"

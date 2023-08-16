#! /bin/bash

# Git reset empty files
gref() {
  command git --no-pager diff --cached --stat | command grep "|\s&0$" | awk '{system("command git reset " $1)}'
}

twiki() {
  rake db:migrate && rake db:migrate:redo
}

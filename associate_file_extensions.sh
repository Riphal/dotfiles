#!/bin/bash

# Highly inspired by Darragh ORiordan's article "Set vscode as the default editor for text files on mac"
# See https://www.darraghoriordan.com/2021/09/15/vscode-default-text-files-mac/

function print_green {
  printf "\e[32m$1\e[0m\n"
}

function print_yellow {
  printf "\e[33m$1\e[0m\n"
}

function print_red {
  printf "\e[31m$1\e[0m\n"
}

export HOMEBREW_NO_AUTO_UPDATE=1
brew ls duti &>/dev/null || brew install duti # https://github.com/moretension/duti/

app_name=${@:-Visual Studio Code} # https://code.visualstudio.com
app_id=$(osascript -e "id of app \"${app_name}\"")

extensions=(
  "public.json"
  "public.plain-text"
  "public.python-script"
  "public.shell-script"
  "public.source-code"
  "public.text"
  "public.unix-executable"
  "public.data"
  ".c"
  ".cpp"
  ".cs"
  ".css"
  ".go"
  ".java"
  ".js"
  ".sass"
  ".scss"
  ".less"
  ".vue"
  ".cfg"
  ".json"
  ".jsx"
  ".log"
  ".lua"
  ".md"
  ".php"
  ".pl"
  ".py"
  ".rb"
  ".ts"
  ".tsx"
  ".txt"
  ".conf"
  ".yaml"
  ".yml"
  ".toml"
)

for extension in "${extensions[@]}"; do
  duti_command="duti -s ${app_id} ${extension} all"
  print_yellow "Running ${duti_command}"

  if ${duti_command}; then
    print_green "Associated ${extension} files with ${app_name}"
  else
    print_red "🚨 Error associating ${extension} files with ${app_name} 🚨"
  fi
done
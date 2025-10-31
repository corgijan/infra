if status is-interactive
    # Commands to run in interactive sessions can go here
end
source "$HOME/.cargo/env.fish"
export TERM="xterm-256color"

export PATH="/opt/homebrew/bin:$PATH"
export EDITOR=nvim
fish_vi_key_bindings

set fish_greeting "Its fishy here ...."

abbr ioctl "cd /Users/jan.vaorin/projects/core/iot-operations/saas/local"

abbr k "kubectl"
abbr r "ranger"
abbr kx "kubectx"
abbr general-data "npm run build-and-start -- --password adminadmin --tenantAdminPassword adminadmin --testData=true --masterScaleblocs=1 --scaleblocs=1 --env LOCAL --init"
abbr kget "kubectl config current-context"
abbr kset "kubectl config use-context"
abbr kap "kubectl apply -f "
abbr kapl "kubectl apply -f "
abbr kl "kubectl logs"
abbr kes "kubectl edit secret"
abbr gg "cd"

alias vim "nvim"
alias vi "lvim"
alias code "/usr/local/bin/code"

alias co "git checkout"
alias cl "clear"
alias rm "trash"
alias v "vi"
alias g "grep"
alias l "less"
alias a "ack"
alias c "cat"
alias sed "gsed"

alias ga "git add ."
alias gp "git push"
alias co "git checkout"


abbr fishcfg "vim ~/.config/fish/config.fish"
alias r "ranger"
abbr o "gio open"
alias x "exit"
abbr javaows "/Users/jan.vaorin/Applications/OpenWebStart/OpenWebStart\ javaws.app"
abbr :q "exit"


fish_vi_cursor

#set -g __sdkman_custom_dir /Users/jan.vaorin/.sdkman

function gc
    # Find all matches in the commit message using sed
    set res $(python3 -c 'import subprocess, re; branch_name=subprocess.run(["git", "rev-parse", "--abbrev-ref", "HEAD"], capture_output=True, text=True).stdout.strip(); commit_message=subprocess.run(["git", "log", "-1", "--pretty=%B", branch_name], capture_output=True, text=True).stdout.strip(); matched_forms=re.findall(r"\b([A-Z]+-[0-9]+)\b", branch_name) ; print(matched_forms[0] if matched_forms else exit(1))')
    git commit  -m"$res $argv"
end

function show
    echo "$argv[1]"
end
source /Users/jan.vaorin/.wasmer/wasmer.sh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/jan.vaorin/.rd/bin"
set --export --prepend PATH "/usr/local/bin/code"

function sdkman
    command sdk $argv

    # If JAVA_HOME is set, fix PATH
    if set -q JAVA_HOME
        set --export --prepend PATH "$JAVA_HOME/bin"
    end
end


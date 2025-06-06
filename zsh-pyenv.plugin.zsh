if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
  export PATH="$PYENV_ROOT/bin:$PATH"

  eval "$(pyenv init -)"

  () {
    local -a pyenv_cmds=(${(f)"$(pyenv commands)"})
    # Check if $pyenv_cmds contains virtualenv-init
    if (( $pyenv_cmds[(Ie)virtualenv-init] )); then
      eval "$(pyenv virtualenv-init -)"
    fi
  }

  _pyenv() {
    local words completions
    read -cA words

    if [ "${#words}" -eq 2 ]; then
      completions="$(pyenv commands)"
    else
      completions="$(pyenv completions ${words[2,-2]})"
    fi

    reply=(${(ps:\n:)completions})
  }

  compctl -K _pyenv pyenv
fi

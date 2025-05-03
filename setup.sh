#!/bin/sh

for i in curl fish; do
  if ! command -v "$i" >/dev/null 2>&1; then
    echo "$i is not installed. Please install it first."
    exit 1
  fi
done

fish -c '
if not functions -q fisher
  curl -sSL https://git.io/fisher | source
end

fisher install \
  jorgebucaran/fisher \
  jorgebucaran/autopair.fish \
  nickeb96/puffer-fish \
  jethrokuan/fzf \
  jethrokuan/z
'

fish_config_dir="$(fish -c 'echo $__fish_config_dir')"

tee "$fish_config_dir/config.fish" <<'EOF' >/dev/null
if status is-interactive
  bind \e\[3\;5~ kill-word
  bind \b backward-kill-word

  function mkcd
    mkdir -p "$argv[1]"
    cd "$argv[1]"
  end

  function mkcdtmp
    cd "$(mktemp -d)"
  end

  if type -q bat
    abbr cat 'bat -P'
  end

  if type -q eza
    abbr ls 'eza --group-directories-first'
    abbr lsa 'eza -a --group-directories-first'
    abbr ll 'eza -lh --group-directories-first'
    abbr lla 'eza -lha --group-directories-first'
    abbr lt 'eza -T --group-directories-first'
    abbr lta 'eza -Ta --group-directories-first'
  end
end
EOF

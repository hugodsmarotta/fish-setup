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
  jorgebucaran/autopair.fish
'

fish_config_dir="$(fish -c 'echo $__fish_config_dir')"

tee "$fish_config_dir/config.fish" <<'EOF' >/dev/null
if status is-interactive
  bind \e\[3\;5~ kill-word
  bind \b backward-kill-word
end
EOF

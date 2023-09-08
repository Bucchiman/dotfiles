export OPENAI_API_KEY=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

export GPIOZERO_PIN_FACTORY=mock


if [[ -n "$NVIM_LISTEN_ADDRESS" ]]; then
  export VISUAL="nvr -cc tabedit --remote-wait +'set bufhidden=wipe'"
else
  export VISUAL="nvim"
fi
alias v="$VISUAL"

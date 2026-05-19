#!/usr/bin/env bash
# estante-text :: init.bash — structured-data + plaintext wrangling.

if [ -n "${__ESTANTE_TEXT_LOADED:-}" ]; then return 0 2>/dev/null || true; fi
__ESTANTE_TEXT_LOADED=1

# ── json ───────────────────────────────────────────────────────────
alias jq.='jq .'
alias jqr='jq -r'
alias jqc='jq -c'
alias jql='jq "length"'
alias jqk='jq "keys"'
alias jqv='jq ".[]"'

jget()   { jq -r "${1:-.}"; }
jvalid() { jq empty 2>/dev/null; }
jcount() { jq 'if type == "array" then length elif type == "object" then (keys | length) else 1 end'; }

# ── yaml ───────────────────────────────────────────────────────────
alias yq.='yq .'
alias yqr='yq -r'
alias y2j='yq -o json .'
alias j2y='yq -P -o yaml .'

yget()   { yq -r "${1:-.}"; }
yvalid() { yq empty 2>/dev/null; }
ydiff()  { diff <(yq -P . "$1") <(yq -P . "$2"); }

# ── csv ────────────────────────────────────────────────────────────
cprev() {
  if   command -v qsv >/dev/null 2>&1; then qsv slice -e 10 "$1" | qsv table
  elif command -v xsv >/dev/null 2>&1; then xsv slice -e 10 "$1" | xsv table
  else head -n 11 "$1" | column -ts,; fi
}
ccols() {
  if   command -v qsv >/dev/null 2>&1; then qsv headers "$1"
  elif command -v xsv >/dev/null 2>&1; then xsv headers "$1"
  else head -n 1 "$1" | tr ',' '\n'; fi
}
cwc() {
  if command -v qsv >/dev/null 2>&1; then qsv count "$1"
  else echo $(( $(wc -l < "$1") - 1 )); fi
}
cselect() {
  if   command -v qsv >/dev/null 2>&1; then qsv select "$1" "$2"
  elif command -v xsv >/dev/null 2>&1; then xsv select "$1" "$2"
  else echo "requires qsv or xsv" >&2; return 1; fi
}

# ── text ───────────────────────────────────────────────────────────
alias lc='wc -l'
alias uc='sort | uniq -c | sort -rn'
alias ud='awk "!seen[\$0]++"'

lines()    { head -n "${1:-10}"; }
tail-fln() { tail -f -n "${1:-50}" "${2:-/dev/stdin}"; }
trim()     { awk '{$1=$1; print}'; }
cols()     { awk -v n="$1" '{print $n}'; }
len()      { wc -c -m -w; }

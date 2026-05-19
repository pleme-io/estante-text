#!/usr/bin/env bash
# tests/text_test.bash — surface smoke tests + a handful of real
# behavior checks for the text battery (which doesn't depend on
# external tools).

set -u

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "$__dir/init.bash"

__stdlib_init="$HOME/code/github/pleme-io/estante-stdlib/init.bash"
if [ -f "$__stdlib_init" ]; then
  . "$__stdlib_init"
else
  describe()     { printf '\n\033[1m%s\033[0m\n' "$1"; _ESTANTE_TEST_PASS=${_ESTANTE_TEST_PASS:-0}; _ESTANTE_TEST_FAIL=${_ESTANTE_TEST_FAIL:-0}; }
  end_describe() { :; }
  it()           { _CUR=$1; _F=0; _FR=""; }
  end_it()       { [ "${_F:-0}" -eq 0 ] && { printf '  \033[32m✓\033[0m %s\n' "$_CUR"; _ESTANTE_TEST_PASS=$((_ESTANTE_TEST_PASS+1)); } || { printf '  \033[31m✗\033[0m %s — %s\n' "$_CUR" "$_FR"; _ESTANTE_TEST_FAIL=$((_ESTANTE_TEST_FAIL+1)); }; }
  _test_fail()    { _F=1; _FR="$*"; }
  expect_truthy() { eval "$*" >/dev/null 2>&1 || _test_fail "expected truthy: $*"; }
  expect_eq()     { [ "$1" = "$2" ] || _test_fail "expected '$1' to eq '$2'"; }
  estante_test_summary() {
    local total=$((_ESTANTE_TEST_PASS+_ESTANTE_TEST_FAIL))
    [ "${_ESTANTE_TEST_FAIL:-0}" -gt 0 ] && { printf '\n\033[31m%s examples, %s failures\033[0m\n' "$total" "$_ESTANTE_TEST_FAIL"; exit 1; } || \
      printf '\n\033[32m%s examples, 0 failures\033[0m\n' "$total"
  }
fi

describe "estante-text :: json battery"

it "jq aliases + jget / jvalid / jcount defined"
  for a in jq. jqr jqc jql jqk jqv; do
    expect_truthy "alias $a >/dev/null 2>&1"
  done
  for f in jget jvalid jcount; do
    expect_truthy "declare -F $f >/dev/null 2>&1"
  done
end_it

end_describe

describe "estante-text :: yaml battery"

it "yq aliases + yget / yvalid / ydiff defined"
  for a in yq. yqr y2j j2y; do
    expect_truthy "alias $a >/dev/null 2>&1"
  done
  for f in yget yvalid ydiff; do
    expect_truthy "declare -F $f >/dev/null 2>&1"
  done
end_it

end_describe

describe "estante-text :: csv battery"

it "cprev / ccols / cwc / cselect defined"
  for f in cprev ccols cwc cselect; do
    expect_truthy "declare -F $f >/dev/null 2>&1"
  done
end_it

end_describe

describe "estante-text :: text battery (real behavior)"

it "lc / uc / ud aliases defined"
  for a in lc uc ud; do
    expect_truthy "alias $a >/dev/null 2>&1"
  done
end_it

it "lines limits to N rows"
  result=$(printf '1\n2\n3\n4\n5\n' | lines 2 | wc -l | tr -d ' ')
  expect_eq "$result" "2"
end_it

it "trim strips leading/trailing whitespace per line"
  result=$(printf '   hello   \n  world  \n' | trim)
  expect_eq "$result" "hello
world"
end_it

it "cols extracts the Nth whitespace-delimited column"
  result=$(printf 'a b c\nd e f\n' | cols 2 | tr '\n' ' ')
  expect_eq "$result" "b e "
end_it

end_describe

describe "estante-text :: idempotency"

it "re-sourcing is a no-op"
  . "$__dir/init.bash"
  . "$__dir/init.bash"
  expect_truthy '[ -n "$__ESTANTE_TEXT_LOADED" ]'
end_it

end_describe

estante_test_summary

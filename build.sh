#!/usr/bin/env bash
#
# build.sh: Concatenate Lua modules into build.lua,
# stripping 'require(' lines, interleaving code‐responsive comments,
# renaming previous build.lua to build.prev.lua, and comparing changes.

set -euo pipefail
#  -e: exit on any command failure
#  -u: treat unset variables as errors
#  -o pipefail: pipeline returns failure if any part fails

# ------------------------------------------------------------------------------
# (1) If there's an existing build.lua, rename it to build.prev.lua before proceeding.
# ------------------------------------------------------------------------------
if [[ -f "build.lua" ]]; then
  mv build.lua build.prev.lua
fi

# Templates for remarks inserted AFTER each file, referencing the filename.
FILE_MSGS=(
  "Just added %s—hope your logic is watertight."
  "%s is in; don’t let that parser bite you later."
  "Merged %s: pray those ASTs behave."
  "You included %s—brace for unexpected side effects."
  "%s makes your code richer. Or at least gout-ridden."
  "Imported %s—debuggers rejoice."
  "Glued in %s. Now question why you needed it."
  "Integrated %s: let’s hope it compiles this time."
  "%s has arrived. Prepare to blame someone."
  "Tossed %s in here—go ahead, run your tests."
)

# Remarks printed JUST BEFORE the final "Build succeeded" line.
FINAL_MSGS=(
  "Everything built? I’ll believe it when I see no red text."
  "If this works, you owe me a coffee."
  "Miracles do happen: the build didn’t explode."
  "Congrats, you survived another concatenation."
  "Now go write tests instead of blaming the script."
  "Feel free to debug by hand—said no one ever."
  "Proof that chaos can be mildly contained."
  "If it fails now, it’s on you."
  "Build’s done. Don’t celebrate too soon."
  "Hold your applause until your code actually runs."
)

# Variations on the "don't debug by hand" closing line.
CLOSING_MSGS=(
  "Don’t even think about fixing this manually."
  "Manual fixes are for amateurs—resist the urge."
  "If you edit this by hand, shame on you."
  "Leave the wrench at home; don’t debug manually."
  "Trust the code—don’t poke it yourself."
  "Avoid hand-tweaking this if you value your sanity."
  "Longest manual debug wins nothing—step away."
  "If you touch this by hand, get ready for regret."
  "Hand edits? You deserve everything that breaks."
  "Hopefully you’re not debugging this by hand."
)

# List of source Lua files
FILES=(
  "src/exact.lua"       # core exact number system first
"src/errors.lua"      # utility early
"src/ast.lua"         # core AST definitions
"src/parser.lua"      # depends on ast, errors
"src/factorial.lua"   # depends on exact, ast
"src/simplify.lua"    # depends on ast, exact, errors
"src/tensor.lua"      # depends on ast, exact
"src/trig.lua"        # depends on ast, exact
"src/derivative.lua"  # depends on ast, simplify, trig
"src/integrate.lua"   # depends on ast, simplify, derivative, trig
"src/constants.lua"   # depends on ast, exact
"src/series.lua"      # depends on ast, simplify, exact
"src/solve.lua"       # depends on ast, simplify, exact, factorial
"src/init.lua"        # main entry, depends on everything loaded
"src/gui.lua"         # UI, depends on everything loaded
)

OUT="build.lua"

# ------------------------------------------------------------------------------
# (2) Generate the new build.lua
# ------------------------------------------------------------------------------
printf '%s\n' "-- Autogenerated build. If you’re reading this, something probably broke upstream." > "$OUT"

for f in "${FILES[@]}"; do
  # Insert a blank line then a marker
  printf '\n-- Begin %s\n' "$f" >> "$OUT"

  if [[ -f "$f" ]]; then
    # Strip lines that start (possibly after whitespace) with require(
    grep -vE '^[[:space:]]*require\(' "$f" >> "$OUT"
  else
    echo "Missing file: $f" >&2
    exit 1
  fi

  # End marker for this file
  printf '\n-- End %s\n\n' "$f" >> "$OUT"

  # Pick and append a random code-responsive remark
  idx=$(( RANDOM % ${#FILE_MSGS[@]} ))
  printf '%s\n' "-- $(printf "${FILE_MSGS[$idx]}" "$f")" >> "$OUT"
done

# One final in-file remark
idx=$(( RANDOM % ${#FILE_MSGS[@]} ))
printf '\n%s\n' "-- Build wrapping up. $(printf "${FILE_MSGS[$idx]}" "$OUT")" >> "$OUT"

# ------------------------------------------------------------------------------
# (3) Print a random comment BEFORE the final user-facing echo
# ------------------------------------------------------------------------------
idx=$(( RANDOM % ${#FINAL_MSGS[@]} ))
echo "${FINAL_MSGS[$idx]}"

# User-facing message with a random closing line
idx=$(( RANDOM % ${#CLOSING_MSGS[@]} ))
echo "Build succeeded: $OUT. ${CLOSING_MSGS[$idx]}"

# ------------------------------------------------------------------------------
# (4) If there was a previous build, compare them—excluding comment lines—and count changes.
# ------------------------------------------------------------------------------
if [[ -f "build.prev.lua" ]]; then
  # Create temporary “no-comment” versions
  grep -vE '^[[:space:]]*--' build.prev.lua > /tmp/old_nocomm.lua
  grep -vE '^[[:space:]]*--' build.lua      > /tmp/new_nocomm.lua

  # diff -U0 shows only added/removed lines with zero context.
  # Filter out diff headers (---, +++) and hunk markers (@@).
  CHANGED_LINES=$(diff -U0 /tmp/old_nocomm.lua /tmp/new_nocomm.lua \
                  | grep -E '^[+-]' \
                  | grep -Ev '^(---|\+\+\+|@@)' \
                  | wc -l)

  echo "Lines changed (excluding comments) since last build: $CHANGED_LINES"
fi

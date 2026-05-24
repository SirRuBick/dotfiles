#!/usr/bin/env bash
set -euo pipefail

# Regenerate treesitter parsers from grammar source
# Usage: ./nvim/scripts/install-parsers.sh [language...]
#        ./nvim/scripts/install-parsers.sh --all
#
# Requires: gcc (or cc), tree-sitter CLI
# Install:  ./bootstrap.sh --tool gcc && ./bootstrap.sh --tool tree-sitter

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PARSER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)/parser"
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# ── Grammar definitions ──────────────────────────────────────────────────────
# Format: lang=repo_url[:subdir]
# subdir is needed when multiple parsers come from one repo (e.g. markdown)
declare -A GRAMMARS=(
  [bash]="https://github.com/tree-sitter/tree-sitter-bash"
  [c]="https://github.com/tree-sitter/tree-sitter-c"
  [c_sharp]="https://github.com/tree-sitter/tree-sitter-c-sharp"
  [cpp]="https://github.com/tree-sitter/tree-sitter-cpp"
  [css]="https://github.com/tree-sitter/tree-sitter-css"
  [csv]="https://github.com/tree-sitter-grammars/tree-sitter-csv"
  [diff]="https://github.com/tree-sitter-grammars/tree-sitter-diff"
  [gitignore]="https://github.com/shunsambon/tree-sitter-gitignore"
  [html]="https://github.com/tree-sitter/tree-sitter-html"
  [http]="https://github.com/NTBBloodbath/tree-sitter-http"
  [json]="https://github.com/tree-sitter/tree-sitter-json"
  [kdl]="https://github.com/tree-sitter-grammars/tree-sitter-kdl"
  [lua]="https://github.com/tree-sitter-grammars/tree-sitter-lua"
  [luadoc]="https://github.com/tree-sitter-grammars/tree-sitter-lua"
  [luap]="https://github.com/tree-sitter-grammars/tree-sitter-lua"
  [markdown]="https://github.com/tree-sitter-grammars/tree-sitter-markdown"
  [markdown_inline]="https://github.com/tree-sitter-grammars/tree-sitter-markdown"
  [python]="https://github.com/tree-sitter/tree-sitter-python"
  [regex]="https://github.com/tree-sitter/tree-sitter-regex"
  [rust]="https://github.com/tree-sitter/tree-sitter-rust"
  [sql]="https://github.com/DerekStride/tree-sitter-sql"
  [toml]="https://github.com/ikatyang/tree-sitter-toml"
  [tsx]="https://github.com/tree-sitter/tree-sitter-typescript"
  [xml]="https://github.com/tree-sitter-grammars/tree-sitter-xml"
  [yaml]="https://github.com/ikatyang/tree-sitter-yaml"
)

# Special handling for parsers from the same repo
# These need a subdirectory for their src/ or different branch
declare -A GRAMMAR_SUBDIR=(
  [luadoc]="luadoc"
  [luap]="luap"
  [markdown_inline]="tree-sitter-markdown-inline"
  [tsx]="tsx"
)

# ── Functions ────────────────────────────────────────────────────────────────
check_deps() {
  local missing=()
  command -v gcc &>/dev/null || command -v cc &>/dev/null || missing+=("gcc")
  command -v tree-sitter &>/dev/null || missing+=("tree-sitter")
  if [[ ${#missing[@]} -gt 0 ]]; then
    echo "Error: missing dependencies: ${missing[*]}"
    echo "Install with: ./bootstrap.sh --tool gcc --tool tree-sitter"
    exit 1
  fi
}

build_parser() {
  local lang="$1"
  local repo="${GRAMMARS[$lang]}"
  local subdir="${GRAMMAR_SUBDIR[$lang]:-}"
  local clone_dir="$TEMP_DIR/$lang"

  echo "Building $lang..."

  # Clone
  git clone --depth 1 "$repo" "$clone_dir" 2>/dev/null

  # Handle subdirectories for multi-parser repos
  local src_dir="$clone_dir"
  if [[ -n "$subdir" ]]; then
    if [[ -d "$clone_dir/$subdir" ]]; then
      src_dir="$clone_dir/$subdir"
    elif [[ -d "$clone_dir/src" && "$subdir" == *"/"* ]]; then
      src_dir="$clone_dir/$subdir"
    fi
  fi

  # Generate if grammar.js exists
  if [[ -f "$src_dir/grammar.js" ]]; then
    (cd "$src_dir" && tree-sitter generate)
  fi

  # Find parser source
  local parser_src=""
  if [[ -f "$src_dir/src/parser.c" ]]; then
    parser_src="$src_dir/src/parser.c"
  elif [[ -f "$src_dir/src/parser.h" ]]; then
    parser_src="$src_dir/src/parser.c"
  fi

  if [[ -z "$parser_src" ]]; then
    echo "  Warning: no parser.c found for $lang, skipping"
    return
  fi

  # Compile
  local ext="so"
  local cc="gcc"
  local cflags="-shared -fPIC -O2 -I $src_dir/src"
  local output="$PARSER_DIR/$lang.$ext"

  # Check for scanner.c
  local scanner=""
  if [[ -f "$src_dir/src/scanner.c" ]]; then
    scanner="$src_dir/src/scanner.c"
  elif [[ -f "$src_dir/src/scanner.cc" ]]; then
    scanner="$src_dir/src/scanner.cc"
    cc="g++"
  fi

  if [[ -n "$scanner" ]]; then
    $cc $cflags -o "$output" "$parser_src" "$scanner"
  else
    $cc $cflags -o "$output" "$parser_src"
  fi

  echo "  Built: $output"
}

# ── Main ─────────────────────────────────────────────────────────────────────
check_deps

mkdir -p "$PARSER_DIR"

if [[ $# -eq 0 || "$1" == "--all" ]]; then
  targets=("${!GRAMMARS[@]}")
else
  targets=("$@")
  # Validate
  for lang in "${targets[@]}"; do
    if [[ -z "${GRAMMARS[$lang]:-}" ]]; then
      echo "Error: unknown language '$lang'"
      echo "Available: ${!GRAMMARS[*]}"
      exit 1
    fi
  done
fi

for lang in "${targets[@]}"; do
  build_parser "$lang"
done

echo ""
echo "Done! Parsers installed to: $PARSER_DIR"
echo "Total: $(ls "$PARSER_DIR"/*.{so,dll} 2>/dev/null | wc -l) parsers"

#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <all|claude|codex|opencode|antigravity> <target-project>"
  exit 1
}

[[ $# -eq 2 ]] || usage
PLATFORM="$1"
TARGET="$(cd "$2" && pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

case "$PLATFORM" in
  all|claude|codex|opencode|antigravity) ;;
  *) usage ;;
esac

append_block() {
  local src="$1"
  local dest="$2"
  local marker="$3"
  if [[ -f "$dest" ]]; then
    if grep -Fq "$marker" "$dest"; then
      echo "Already installed in $dest"
      return
    fi
    local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    cp "$dest" "$backup"
    printf '\n\n<!-- %s -->\n' "$marker" >> "$dest"
    cat "$src" >> "$dest"
    printf '\n<!-- /%s -->\n' "$marker" >> "$dest"
    echo "Merged into $dest (backup: $backup)"
  else
    cp "$src" "$dest"
    echo "Created $dest"
  fi
}

install_memory() {
  mkdir -p "$TARGET/.agent-memory"
  for f in PROJECT_MAP.md TASK_STATE.md HANDOFF.md; do
    if [[ ! -f "$TARGET/.agent-memory/$f" ]]; then
      cp "$ROOT/templates/memory/$f" "$TARGET/.agent-memory/$f"
    fi
  done
  touch "$TARGET/.gitignore"
  if ! grep -Fxq '.agent-memory/' "$TARGET/.gitignore"; then
    printf '\n# Local AI coding task state\n.agent-memory/\n' >> "$TARGET/.gitignore"
  fi
}

if [[ "$PLATFORM" == all || "$PLATFORM" == claude ]]; then
  append_block "$ROOT/adapters/claude/CLAUDE.md" "$TARGET/CLAUDE.md" "AGENT-CONTEXT-OPTIMIZER"
fi

if [[ "$PLATFORM" == all || "$PLATFORM" == codex || "$PLATFORM" == opencode ]]; then
  src="$ROOT/adapters/codex/AGENTS.md"
  [[ "$PLATFORM" == opencode ]] && src="$ROOT/adapters/opencode/AGENTS.md"
  append_block "$src" "$TARGET/AGENTS.md" "AGENT-CONTEXT-OPTIMIZER"
fi

if [[ "$PLATFORM" == all ]]; then
  # In all mode prefer OpenCode's superset adapter in the shared AGENTS.md.
  if [[ -f "$TARGET/AGENTS.md" ]] && ! grep -Fq 'OpenCode context controls' "$TARGET/AGENTS.md"; then
    printf '\n\n## OpenCode context controls\nUse `/compact` (or `/summarize`) for a bloated same-task OpenCode session after writing a compact handoff.\n' >> "$TARGET/AGENTS.md"
  fi
fi

if [[ "$PLATFORM" == all || "$PLATFORM" == antigravity ]]; then
  mkdir -p "$TARGET/.agents/rules"
  cp "$ROOT/adapters/antigravity/production-context-discipline.md" \
     "$TARGET/.agents/rules/production-context-discipline.md"
  echo "Installed Antigravity workspace rule"
fi

install_memory

echo
echo "Agent Context Optimizer installed for: $PLATFORM"
echo "Target: $TARGET"
echo "Review INSTALLATION.md in the kit for platform-specific notes."

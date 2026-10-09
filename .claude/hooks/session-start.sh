#!/bin/bash
# Installs claude-mem and starts its worker in Claude Code cloud sessions.
set -uo pipefail

# Local machines manage their own install (npm run build-and-sync).
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

LOG="$HOME/.claude-mem-session-start.log"

# Run outside the repo so npx fetches the published package instead of this checkout.
cd "$HOME" || exit 0

if [ ! -d "$HOME/.claude/plugins/marketplaces/thedotmack" ]; then
  npx --yes claude-mem@latest install < /dev/null >> "$LOG" 2>&1 || echo "claude-mem install failed, see $LOG" >&2
fi

npx --yes claude-mem@latest start < /dev/null >> "$LOG" 2>&1 || echo "claude-mem worker failed to start, see $LOG" >&2

exit 0

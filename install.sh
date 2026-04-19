#!/usr/bin/env bash
set -e

SKILLS_DIR="${HOME}/.claude/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AVAILABLE=(front-comments front-a11y front-review front-refactor)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

usage() {
  echo "Usage: $0 <skill-name|all> [--force]"
  echo ""
  echo "Available skills:"
  for s in "${AVAILABLE[@]}"; do
    echo "  - $s"
  done
  echo ""
  echo "Examples:"
  echo "  $0 all"
  echo "  $0 front-a11y"
  echo "  $0 front-review --force"
  exit 1
}

install_skill() {
  local skill="$1"
  local force="$2"
  local src="${REPO_DIR}/${skill}"
  local dest="${SKILLS_DIR}/${skill}"

  if [[ ! -d "$src" ]]; then
    echo -e "${RED}Error: skill '$skill' not found in $REPO_DIR${NC}"
    return 1
  fi

  if [[ -d "$dest" && "$force" != "true" ]]; then
    echo -e "${YELLOW}Skipped: $skill (already installed, use --force to overwrite)${NC}"
    return 0
  fi

  mkdir -p "$dest"
  for f in "$src"/*.md; do
    name=$(basename "$f")
    if [[ "$name" != "README.md" && "$name" != "CHANGELOG.md" ]]; then
      cp "$f" "$dest/"
    fi
  done
  echo -e "${GREEN}Installed: $skill -> $dest${NC}"
}

[[ $# -lt 1 ]] && usage

TARGET="$1"
FORCE="false"
[[ "${2:-}" == "--force" ]] && FORCE="true"

mkdir -p "$SKILLS_DIR"

if [[ "$TARGET" == "all" ]]; then
  for skill in "${AVAILABLE[@]}"; do
    install_skill "$skill" "$FORCE"
  done
elif printf '%s\n' "${AVAILABLE[@]}" | grep -qx "$TARGET"; then
  install_skill "$TARGET" "$FORCE"
else
  echo -e "${RED}Error: unknown skill '$TARGET'${NC}"
  echo ""
  usage
fi

echo ""
echo "Done. Skills are now available in $SKILLS_DIR"

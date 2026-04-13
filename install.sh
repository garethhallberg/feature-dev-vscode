#!/usr/bin/env bash
set -euo pipefail

# feature-dev installer for VS Code (Copilot Agent Skills + Custom Agents)
#
# Run from wherever you unzipped the files. Pass your project path as the
# first argument, or run it from your project root with no arguments.
#
# Usage:
#   ./install.sh /path/to/your/project
#   cd /path/to/your/project && /path/to/install.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-.}"

echo "Installing feature-dev for VS Code Copilot..."
echo "Target: $(cd "$TARGET" && pwd)"
echo ""

# Skill
mkdir -p "$TARGET/.github/skills/feature-dev"
cp "$SCRIPT_DIR/SKILL.md" "$TARGET/.github/skills/feature-dev/SKILL.md"
echo "✓ Installed skill:  .github/skills/feature-dev/SKILL.md"

# Agents
mkdir -p "$TARGET/.github/agents"
for agent in "$SCRIPT_DIR"/*.agent.md; do
    name=$(basename "$agent")
    cp "$agent" "$TARGET/.github/agents/$name"
    echo "✓ Installed agent:  .github/agents/$name"
done

echo ""
echo "Done. Open this folder in VS Code with Copilot enabled."
echo ""
echo "Usage (in Copilot Chat):"
echo "  /feature-dev Add user authentication with OAuth"
echo "  /feature-dev Implement caching for the API layer"
echo "  /feature-dev"
echo ""
echo "You can also use the agents directly:"
echo "  Select 'Code Explorer' from the agents dropdown"
echo "  Select 'Code Architect' from the agents dropdown"
echo "  Select 'Code Reviewer' from the agents dropdown"
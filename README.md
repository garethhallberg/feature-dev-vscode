# feature-dev for VS Code

A structured 7-phase feature development workflow for VS Code with GitHub
Copilot, ported from the
[Mistral Vibe version](https://github.com/garethhallberg/feature-dev-vibe)
which was itself inspired by the Claude Code `feature-dev` command.

Rather than jumping straight into code, this skill guides you through
understanding the existing codebase, clarifying requirements, designing
architecture thoughtfully, and conducting quality reviews before and after
implementation.

## Prerequisites

- VS Code with GitHub Copilot (Free, Pro, or Business)
- Agent Skills support (available in recent VS Code versions)

## What's included

```
feature-dev-vscode/
├── .github/
│   ├── skills/
│   │   └── feature-dev/
│   │       └── SKILL.md              # The main workflow (invoked via /feature-dev)
│   └── agents/
│       ├── code-explorer.agent.md    # Read-only agent for codebase exploration
│       ├── code-architect.agent.md   # Design agent for architecture proposals
│       └── code-reviewer.agent.md    # Review agent for quality checking
├── install.sh                        # Copies everything into a target project
└── README.md
```

## Installation

### Option 1: Copy into your project

```bash
git clone https://github.com/garethhallberg/feature-dev-vscode.git
cd feature-dev-vscode
chmod +x install.sh
./install.sh /path/to/your/project
```

### Option 2: Manual copy

Copy the `.github/skills/` and `.github/agents/` folders into the root of any
project where you want the workflow available.

### Option 3: User-level install

To make the agents available across all projects, use VS Code's Chat
Customizations editor:

1. Open the Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`)
2. Run **Chat: Open Chat Customizations**
3. Create each agent under your user profile

The skill itself must live in the workspace `.github/skills/` folder.

## Usage

In Copilot Chat:

```
/feature-dev Add rate limiting to the public API
/feature-dev Implement on-device speech recognition
/feature-dev
```

You can also use the agents independently by selecting them from the agents
dropdown in the Chat view:

- **Code Explorer** — "Trace how authentication works in this codebase"
- **Code Architect** — "Design an approach for adding WebSocket support"
- **Code Reviewer** — "Review the files I changed in my last commit"

## The 7 Phases

| Phase | What happens | User input? |
| ----- | ------------ | ----------- |
| 1. Discovery | Understand the feature request | ✓ Confirm understanding |
| 2. Codebase Exploration | Explore existing code via Code Explorer agent | — |
| 3. Clarifying Questions | Resolve ambiguity with targeted questions | ✓ Answer questions |
| 4. Architecture Design | Propose approaches via Code Architect agent | ✓ Choose approach |
| 5. Implementation | Build the feature | — (pause if needed) |
| 6. Quality Review | Review via Code Reviewer agent | ✓ Approve fixes |
| 7. Summary | Report what was built and next steps | — |

## How it maps from Vibe

| Vibe concept | VS Code equivalent |
| ------------ | ------------------ |
| `~/.vibe/skills/feature-dev/SKILL.md` | `.github/skills/feature-dev/SKILL.md` |
| `~/.vibe/agents/*.toml` + `prompts/*.md` | `.github/agents/*.agent.md` (combined) |
| `task` tool delegation | Agent switching via dropdown or handoff |
| `ask_user_question` | `#tool:vscode/askQuestions` |
| `read_file` / `grep` / `bash` | `search/codebase`, `readFile`, `runInTerminal` |
| `safety = "safe"` (read-only) | `tools:` list limited to read-only tools |
| `install.sh` → `~/.vibe/` | Copy to `.github/` in workspace |

Key structural difference: Vibe keeps agent config (TOML), system prompts
(Markdown), and the skill (Markdown) as three separate file types. VS Code
merges the agent config and system prompt into a single `.agent.md` file with
YAML frontmatter — simpler to maintain.

## Customisation

- Edit the skill in `.github/skills/feature-dev/SKILL.md` to adjust phases
- Edit agents in `.github/agents/` to change tool permissions or behaviour
- Add project-level instructions in `.github/copilot-instructions.md` for
  coding conventions that all agents should follow

## Differences from Claude Code feature-dev

| Aspect | Claude Code | This VS Code skill |
| ------ | ----------- | ------------------ |
| Invocation | `/feature-dev` plugin command | `/feature-dev` slash command skill |
| Subagents | Built-in parallel agents | VS Code custom agents |
| Installation | Plugin marketplace | Copy to `.github/` in workspace |
| Customisation | Plugin config | Edit Markdown directly |
| Model | Claude only | Any Copilot-supported model |

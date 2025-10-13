[Let Claude Automate Your Obsidian Notes: Second Brain AI Agent (MCP) - YouTube](https://www.youtube.com/watch?v=VeTnndXyJQI&t=421s)

# Notes from the Video: "Let Claude Automate Your Obsidian Notes: Second Brain AI Agent (MCP)"

These notes are based on the video content, which demonstrates how to set up and use Claude AI with the Model Context Protocol (MCP) to automate note-taking in Obsidian. The setup allows Claude to create, edit, and manage notes directly in your Obsidian vault, turning it into an AI-powered second brain.

## Introduction: What It Can Do
- The desktop version of Claude can directly create and edit notes in Obsidian.
- No additional charges beyond communication fees (works on Claude's Free Plan).
- Enables AI automation for knowledge management without deep technical knowledge.

## Technical Stack and Environment
- Required: A Mac with internet access.
- Tools involved:
  - Shell (Terminal).
  - Python (managed via uv).
  - Git.
  - Obsidian (for note-taking).
  - Claude Desktop app.
  - MCP (Model Context Protocol) for integration.
- No need for full understanding—start from basics.
- Estimated setup time: About 15 minutes (excluding in-depth learning).

## Setup Steps

### 1. Install Claude Desktop
- Download from: https://claude.ai/download.
- Register (e.g., via Google login), enter a username, and start using.
- Compatible with Free Plan; select your preferred plan.

### 2. Install Git (via Homebrew)
- If not installed, download and install Homebrew first (instructions at: https://git-scm.com/downloads/mac).
- Open Terminal (⌘ + Shift, search for "Terminal").
- Run: `brew install git` (may take time).
- Add to PATH:
  ```
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
  source ~/.zshrc
  ```
- Verify: `git -v` (should show version like "git version 2.49.0").

### 3. Install uv (Python Management Tool)
- Run: `sudo curl -LsSf https://astral.sh/uv/install.sh | sh`.
- Verify: `which uv` (restart Terminal if error; ask Claude if issues persist).

### 4. Install Obsidian
- Download from: https://obsidian.md/.
- Create a Vault (notebook) in any location.

### 5. Install mcp-obsidian (MCP Server for Obsidian)
- In Terminal, create directory and clone repo:
  ```
  cd ~
  git clone https://github.com/MarkusPfundstein/mcp-obsidian.git
  ```
- Verify: `ls` (should show "mcp-obsidian").
- Reference repo: https://github.com/MarkusPfundstein/mcp-obsidian.

## Configuring the MCP Environment

### Obsidian Configuration
- Open Obsidian settings (⌘ + ,).
- Enable Community Plugins: Turn off Restricted mode.
- Install "Local REST API" plugin: Search "rest api", install, and enable.
- Get API Key: In plugin options, copy the key (local only, no external risk).

### MCP Server Configuration
- Navigate to repo: `cd ~/mcp-obsidian`.
- Get path: `pwd` (store for later).
- Create `.env` file: `vi .env`.
  - Press `i`, add: `OBSIDIAN_API_KEY={your API key}`.
  - Save: Press Esc, then `:wq`.
- Verify: `ls -a` (should list `.env`).

### Claude Desktop Configuration
- Open Claude settings (⌘ + ,), go to Developer > Edit Config.
- Edit `claude_desktop_config.json` (opens in editor).
- Add content (replace placeholders):
  ```
  {
    "mcpServers": {
      "mcp-obsidian": {
        "command": "{path to uvx from 'which uvx'}",
        "args": ["mcp-obsidian"],
        "env": {
          "OBSIDIAN_API_KEY": "{your API key}",
          "OBSIDIAN_HOST": "{pwd result}"
        }
      }
    }
  }
  ```
- Save, quit, and relaunch Claude.
- Verify: Check for "mcp-obsidian" in settings (restart apps if needed; ask Claude for help).

## Usage: Let Claude Write Notes
- Start a chat in Claude Desktop.
- Example prompt: Create React learning materials in Obsidian (e.g., notes on environment setup, Props, State).
- Include "Obsidian" in prompts to ensure it uses the integration.
- Grant permission when prompted (e.g., "Allow Once" or "Allow Always").
- Common instructions for Claude:
  - Create notes.
  - Add and organize links.
  - Manage folder structures.
- Benefits: Efficient searching, links, and backlinks for knowledge organization; accelerates learning.

## Troubleshooting and Tips
- If errors occur (e.g., during installation), restart Terminal/apps or ask Claude directly.
- For permission issues with uv: Use sudo in installation.
- Obsidian's local REST API is secure (no internet exposure).
- Experiment with prompts to automate workflows.

## Cleanup (If No Longer Needed)
- Uninstall uv:
  ```
  uv cache clean
  rm -r "$(uv python dir)"
  rm -r "$(uv tool dir)"
  rm ~/.local/bin/uv ~/.local/bin/uvx
  ```
- Delete apps: Remove Claude Desktop and Obsidian via standard Mac methods.
- Delete Vault folders if created.
- Git: No uninstall recommended; update with `brew upgrade git`.
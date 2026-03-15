# Contributing to cpin.nvim

Thanks for your interest in contributing! This is the Neovim plugin for [cpin](https://github.com/jonaebel/cpin), and contributions of all sizes are welcome — bug fixes, new features, docs, or packaging.

## Getting Started

### Prerequisites

- Neovim (v0.9+)
- A plugin manager (e.g. [lazy.nvim](https://github.com/folke/lazy.nvim))
- The `cpin` CLI installed and on your `$PATH`

### Install for development

Clone the repo and point your plugin manager at the local path:

```lua
-- lazy.nvim example
{ dir = "~/path/to/cpin.nvim" }
```

### Project structure

```
cpin.nvim/
├── lua/
│   └── cpin/
│       └── init.lua     # Plugin entry point (setup, commands)
├── plugin/
│   └── cpin.lua         # Auto-loaded Neovim plugin file
├── doc/
│   └── cpin.txt         # Vimdoc help page
└── README.md
```

The plugin communicates with the `cpin` CLI binary via `vim.fn.system()` or `vim.system()`. Notes are stored by the CLI in `.cpin/notes` in the project root.

## How to Contribute

### 1. Pick an issue

Check the [open issues](https://github.com/jonaebel/cpin.nvim/issues). Issues tagged `good first issue` are a great starting point if you're new to the codebase.

### 2. Fork and branch

```bash
git checkout -b feat/your-feature-name
# or
git checkout -b fix/your-bug-name
```

### 3. Make your changes

- Keep changes focused — one feature or fix per PR
- Follow the existing code style (see below)
- Test your changes manually in Neovim before submitting

### 4. Open a Pull Request

Push your branch and open a PR against `main`. Fill out the PR template and describe what you changed and why.

---

## Code Style

- Lua 5.1 (LuaJIT), compatible with Neovim's built-in runtime
- 2-space indentation
- snake_case for all functions and variables
- Keep the public API surface small — expose only what users need via `require("cpin").setup()`
- Use `vim.notify` for user-facing messages; avoid `print()`

---

## Reporting Bugs

Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md) when opening an issue.

## Requesting Features

Use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md). Check existing issues first to avoid duplicates.

---

## License

By contributing you agree that your contributions will be licensed under the [MIT License](LICENSE).

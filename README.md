# cpin.nvim

> Work in progress

Sticky notes for your code. Attach notes to specific file:line positions — visible as virtual text, never touching your source files.

Requires the [cpin CLI](https://github.com/jonaebel/cpin) to be installed.

## Requirements

- `cpin` binary on your `$PATH` (`make install` — see CLI [repo](https://github.com/jonaebel/cpin))
- Neovim 0.9+

## Setup

```lua
-- lazy.nvim
{ dir = "~/path/to/cpin.nvim" }
```

## Status

This plugin is under active development and in early development.

## Roadmap

**v0.1 — Core commands**
The plugin can talk to the `cpin` CLI. You can add a note to any line and remove it again using user commands. If the `cpin` binary isn't installed, you get a clear message telling you what to do instead of a silent failure. Notes are saved — nothing shows up in the editor yet.

- Set up the internal CLI connection — shell out to `cpin` via `vim.fn.system()` and verify it works on startup
- `:CpinAdd` command — prompts for note text via `vim.ui.input` and attaches it to the current line
- `:CpinRemove` command — deletes the note at the current line, or shows a message if there is none
- Plugin loads automatically when Neovim opens any file (no manual `:source` needed)
- Helpful error if the `cpin` binary is missing or not on `$PATH`, with install instructions

**v0.2 — See your notes in the editor**
A small indicator appears as virtual text next to every line that has a note. Hover over it or trigger a float to read the full note text. Virtual text appears when you open a file and disappears as soon as you delete a note.

- Virtual text decoration for annotated lines, shown after the line content in a dimmed color
- Decorations refresh automatically on file open, buffer enter, and save
- Floating window to read the full note under the cursor (`:CpinPeek` or a keymap)
- Decorations clear immediately after a note is removed without needing to re-open the file

**v0.3 — Notes panel**
Browse all notes across your project in one place. Either a built-in split window or a Telescope picker — click or select any note to jump straight to that file and line.

**v0.4 — Search and export**
Search notes by keyword across the whole project. Export all notes as Markdown or JSON via `:CpinExport`.

**v1.0 — Ready to release**
Polished, documented, and submitted to common plugin managers. Help docs in `doc/cpin.txt` are complete and `:h cpin` works out of the box.

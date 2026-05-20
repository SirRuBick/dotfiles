# Zellij Shortcuts

Zellij starts in **locked mode** — all keys pass through to the terminal. Press `Ctrl+space` to enter normal mode for Zellij commands.

## Mode Overview

| Mode | Entry | Purpose |
|---|---|---|
| **Locked** | Default / `esc` / `enter` | Keys pass through to terminal |
| **Normal** | `Ctrl+space` | Navigate panes, launch sub-modes |
| Pane | `p` | Create/split/close/rename panes |
| Tab | `t` | Switch/create/close/rename tabs |
| Resize | `r` | Resize panes |
| Move | `m` | Move panes |
| Scroll | `s` | Scroll backbuffer, search |
| Session | `o` | Session management, plugins |

## Normal Mode

| Shortcut | Action |
|---|---|
| `h` / `j` / `k` / `l` | Move focus left/down/up/right |
| `Alt+1`–`Alt+6` | Go to tab 1–6 |
| `p` | Pane mode |
| `t` | Tab mode |
| `r` | Resize mode |
| `m` | Move mode |
| `s` | Scroll mode |
| `o` | Session mode |
| `q` | Quit Zellij |
| `Ctrl+space` | Lock (pass through to terminal) |
| `Ctrl+q` | Quit Zellij |
| `esc` | Lock |

## Normal + Locked (always available)

| Shortcut | Action |
|---|---|
| `Alt+h` / `Alt+l` | Move focus left/right (or switch tab at boundary) |
| `Alt+j` / `Alt+k` | Move focus down/up |
| `Alt+arrows` | Move focus (same as above) |
| `Alt++` / `Alt+=` | Resize increase |
| `Alt+-` | Resize decrease |
| `Alt+[` / `Alt+]` | Previous/next swap layout |
| `Alt+f` | Toggle floating panes |
| `Alt+i` | Move tab left |
| `Alt+o` | Move tab right |
| `Alt+n` | New pane |
| `Alt+p` | Toggle pane in group |
| `Alt+Shift+p` | Toggle group marking |

## Pane Mode `p`

| Shortcut | Action |
|---|---|
| `h` / `j` / `k` / `l` or arrows | Move focus |
| `n` | New pane (default direction) |
| `d` | New pane down |
| `r` | New pane right |
| `s` | New pane stacked |
| `x` | Close focused pane |
| `f` | Toggle fullscreen |
| `e` | Toggle embed/floating |
| `w` | Toggle floating panes |
| `z` | Toggle pane frames |
| `i` | Toggle pane pinned |
| `c` | Rename pane |
| `Tab` | Switch focus |
| `p` | Back to normal |

## Tab Mode `t`

| Shortcut | Action |
|---|---|
| `h` / `l` or `left`/`right` | Previous/next tab |
| `j` / `k` | Next/previous tab |
| `1`–`9` | Go to tab 1–9 |
| `n` | New tab |
| `x` | Close tab |
| `[` | Break pane left |
| `]` | Break pane right |
| `b` | Break pane out |
| `r` | Rename tab |
| `s` | Toggle sync tab |
| `Tab` | Toggle tab |
| `t` | Back to normal |

## Resize Mode `r`

| Shortcut | Action |
|---|---|
| `h` / `j` / `k` / `l` | Resize increase (direction) |
| `H` / `J` / `K` / `L` | Resize decrease (direction) |
| `+` / `=` | Resize increase |
| `-` | Resize decrease |
| arrows | Resize increase (direction) |
| `r` | Back to normal |

## Move Mode `m`

| Shortcut | Action |
|---|---|
| `h` / `j` / `k` / `l` or arrows | Move pane (direction) |
| `n` | Move pane |
| `p` | Move pane backwards |
| `Tab` | Move pane |
| `m` | Back to normal |

## Scroll Mode `s`

| Shortcut | Action |
|---|---|
| `j` / `down` | Scroll down |
| `k` / `up` | Scroll up |
| `h` / `left` / `PageUp` / `Ctrl+b` | Page scroll up |
| `l` / `right` / `PageDown` / `Ctrl+f` | Page scroll down |
| `d` | Half page down |
| `u` | Half page up |
| `Ctrl+c` | Scroll to bottom |
| `f` | Enter search |
| `e` | Edit scrollback in editor |
| `Alt+h/j/k/l` or `Alt+arrows` | Exit scroll (move focus to adjacent pane) |
| `s` | Back to normal |

### Search Mode (from scroll `f`)

| Shortcut | Action |
|---|---|
| `n` | Next match |
| `p` | Previous match |
| `c` | Toggle case sensitivity |
| `w` | Toggle word wrap |
| `o` | Toggle whole word |

## Session Mode `o`

| Shortcut | Action |
|---|---|
| `w` | Session manager |
| `l` | Layout manager |
| `a` | About |
| `c` | Configuration |
| `p` | Plugin manager |
| `s` | Share session |
| `q` | Sequence |
| `d` | Detach session |
| `o` | Back to normal |

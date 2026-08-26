# Keybindings cheat sheet

Personal reference for this Emacs setup: **Prelude** + **evil-mode** + **CIDER**
+ **smartparens-strict** + **vertico/consult/embark** + **corfu**.

Everything below was verified against the packages actually installed in
`~/.emacs.d/elpa`, not against generic documentation. Notably CIDER is on the
2.1-dev line, where several eval commands were renamed.

`which-key` is enabled, so pressing any prefix (`C-c p`, `C-c C-v`, `C-x`) and
pausing shows the full menu. Use that instead of memorizing the long tail.

---

## Discovery

Learn the config from the config itself.

| Key | Action |
|---|---|
| `C-h C-m` | `discover-my-major` — every binding for the current major mode |
| `C-h B` | `embark-bindings` — searchable list of all active bindings |
| `C-h k` | What does this key do? |
| `C-h C-f` / `C-h C-v` | Jump to a function's / variable's source |
| `C-h C-l` | Find a library |
| `C-c I` | Open the init file |

`C-h C-m` inside a `.clj` buffer prints the entire CIDER map with descriptions.

---

## Clojure / CIDER

### Starting a REPL

`C-c C-x` opens the jack-in transient menu (the modern entry point; the old
`C-c M-j` is soft-deprecated).

| Key | Action |
|---|---|
| `C-c C-x j j` | Jack in to Clojure |
| `C-c C-x j s` | Jack in to ClojureScript |
| `C-c C-x j m` | Both |
| `C-c C-q` | Quit the connection |

### Showing / switching to the REPL

| Key | Action |
|---|---|
| `C-c C-z` | Toggle between source buffer and REPL (works both directions) |
| `C-u C-c C-z` | Switch to REPL **and** set its ns to this buffer's |
| `C-c M-z` | Load the buffer, then switch to the REPL |

### The eval loop

| Key | Action |
|---|---|
| `C-c C-e` | Eval the form at point, result in the minibuffer |
| `C-c C-c` | Eval the top-level form around point |
| `C-c C-k` | Load (compile) the whole buffer — "eval the whole namespace" |
| `C-c C-p` | Eval form and pretty-print the result in a popup |
| `C-c M-;` | Eval top-level form, insert result as a `;; =>` comment |
| `C-c C-v` | Full eval menu |
| `C-c C-v r` | Eval region |
| `C-c C-v w` | Eval and replace the form with its result |
| `C-c C-v o` | Eval the enclosing form up to point |

**Note for evil users:** in this CIDER, `C-c C-e` runs `cider-eval-form`, which
honors `cider-form-targeting` (default `smart`). On a closing delimiter it
targets the form that delimiter closes. So with evil's block cursor sitting on
the final `)`, it already evaluates the right thing — no off-by-one advice
needed (unlike the `sly-eval-last-expression` workaround in `personal.el`).

### Namespaces

`C-c M-n` opens the namespace menu in a source buffer. The `M-` variants are
kept as hidden duplicates, so `C-c M-n M-n` == `C-c M-n n`.

| Key | Action |
|---|---|
| `C-c M-n n` | Set the REPL's namespace to this one |
| `C-c M-n e` | Eval just the `(ns ...)` form (after adding a `:require`) |
| `C-c M-n r` | `cider-ns-refresh` — reload changed files and their dependents |
| `C-c M-n b` | Browse a namespace |
| `C-c M-n l` | Require and reload |

Inside the REPL buffer, `C-c M-n` is bound *directly* to `cider-repl-set-ns`
and prompts with completion over all loaded namespaces. The REPL also accepts
`,ns` at the prompt.

### Navigation and docs

| Key | Action |
|---|---|
| `M-.` / `M-,` | Jump to definition / jump back |
| `C-c C-d C-d` | Docstring for the symbol at point |
| `C-c C-d C-a` | Apropos search |
| `C-c C-m` | Macroexpand-1 |
| `C-c M-i` | Open the value in the inspector |
| `C-c C-w` | Find references to this var |
| `C-c C-o` | Clear the latest REPL output |

### Tests

| Key | Action |
|---|---|
| `C-c C-t` | Test menu |
| `C-c C-t t` | Run the test at point |
| `C-c C-t n` | Run all tests in the namespace |

---

## Structural editing (smartparens)

Prelude calls `sp-use-smartparens-bindings`, so this is the smartparens key
set, not paredit's.

| Key | Action |
|---|---|
| `C-<right>` / `C-<left>` | Slurp / barf forward |
| `s-<right>` / `s-<left>` | Same, macOS-friendly (no Spaces conflict) |
| `M-D` or `s-s` | Splice (remove surrounding parens) |
| `C-M-u` / `C-M-d` | Move out of / into the enclosing form |
| `C-M-f` / `C-M-b` | Forward / backward over a whole sexp |
| `C-M-k` | Kill the sexp forward |
| `C-M-w` | Copy the sexp |
| `M-(` | Wrap the next form in parens |

### Two evil-specific caveats

1. `smartparens-strict-mode` guards Emacs' own kill commands but **does not**
   intercept evil's operators. `x`, `dd`, `d}` will happily unbalance the
   buffer. Either use `C-M-k` / `M-D` for anything with delimiters, or install
   [evil-cleverparens](https://github.com/emacs-evil/evil-cleverparens).
2. `evil-surround` is on globally: `cs([` changes surrounding parens to
   brackets, `ds(` deletes them.

`prelude-evil.el` binds `C-S-a` to `evil-numbers/inc-at-pt` and `C-S-d` to
scroll-other-window in normal state, shadowing smartparens' `sp-end-of-sexp` /
`sp-beginning-of-sexp` there. They still work in insert state.

---

## Buffers

`C-x b` is `consult-buffer`: open buffers, recent files, and bookmarks in one
list with live preview. Type `<` then a group key to narrow (`< b` buffers,
`< f` files, `< m` bookmarks); `<` again clears it.

| Key | Action |
|---|---|
| `C-x b` | Switch buffer (with preview) |
| `C-x 4 b` | Same, in the other window |
| `C-x C-b` | `ibuffer` |
| `C-c f` or `s-r` | Open a recent file |
| `C-c k` | Kill all *other* buffers |
| `C-c r` | Rename the buffer **and** its file on disk |
| `C-c D` | Delete the buffer and its file |
| `M-y` | Browse the kill ring |
| `M-g i` | Jump to a definition in this file (`consult-imenu`) |
| `C-c i` | Same, across all open buffers (`imenu-anywhere`) |

`super-save-mode` is on: buffers save automatically on window/buffer switch, so
`C-x C-s` is mostly unnecessary.

---

## Windows

`C-x o` is remapped to `ace-window` — it labels each window and you jump
directly by pressing the letter.

| Key | Action |
|---|---|
| `C-x o` or `s-w` | Jump to a window by label |
| `S-<arrows>` | Move to the window in that direction (windmove) |
| `C-x 2` / `C-x 3` | Split below / right |
| `C-x 0` / `C-x 1` | Close this window / close all others |
| `C-c s` | Swap the contents of two windows |
| `C-c <left>` / `C-c <right>` | Undo / redo a window layout (winner-mode) |

`C-c <left>` is the one people forget: when a CIDER error buffer or help popup
wrecks your layout, it restores it.

In evil normal state, `C-S-d` / `C-S-u` scroll the *other* window — handy with
source in one window and the REPL in the other.

---

## Project (`C-c p` or `s-p`)

| Key | Action |
|---|---|
| `C-c p p` | Switch project |
| `C-c p f` | Find file in project |
| `C-c p b` | Switch to a buffer in this project |
| `C-c p s r` | Ripgrep the project |
| `C-c p k` | Kill all this project's buffers |
| `C-c p t` | Toggle between implementation and test file |
| `C-c p D` | Dired at the project root |
| `C-c p !` | Run a shell command at the project root |
| `C-c p i` | Invalidate the file cache |
| `C-c p m` | `projectile-dispatch` — transient menu of everything |
| `C-c p r` | Replace across the project (reviewable) |
| `C-c p u` | Undo the last project-wide replacement |

`projectile-enable-frecency` is on by default (hence `projectile-frecency.eld`
in the repo root), so `C-c p f` ranks candidates by how often and how recently
you've opened them.

---

## Search and bulk editing

| Key | Action |
|---|---|
| `M-s l` | Live-filter lines in this buffer |
| `M-s r` | Ripgrep the project with preview |
| `M-s k` | *Keep* only lines matching a pattern (destructive) |
| `M-s u` | Fold the buffer down to matching lines (undoable) |
| `M-%` | Query-replace |
| `C-.` | `embark-act` — context menu for the thing at point |
| `C-;` | `embark-dwim` — run the most likely action |

`M-s u` / `M-s k` are the log-reading pair, good against noisy nREPL or test
output.

**The workflow worth learning:** `M-s r` to ripgrep, then `C-.` and choose
export, which turns the results into an editable buffer whose edits write back
to the files. Project-wide refactoring without leaving Emacs.

`C-.` also works on the thing under the cursor in a normal buffer — a file path
offers to open it, a URL to browse it, a symbol to look it up.

---

## Editing

`C-=` (`expand-region`) is the highest-value key here for Lisp: press it
repeatedly to grow the selection by semantic unit — symbol, enclosing form,
next form out.

| Key | Action |
|---|---|
| `C-=` | Expand selection semantically (repeat to grow) |
| `C-c d` | Duplicate the current line or region |
| `C-c M-d` | Duplicate *and* comment out the original |
| `M-S-<up>` / `M-S-<down>` | Move the line or region up / down |
| `C-a` | Toggle between first non-whitespace char and true line start |
| `M-o` | Open an indented line below and jump to it |
| `C-c n` | Clean up buffer: reindent, untabify, strip trailing whitespace |
| `C-c e` | Eval the elisp before point and replace it with the result |
| `C-c .` then `+` `-` `*` `/` | Arithmetic on the number at point (repeatable) |

Behaviors that act like keys: `C-w` with no active region kills the whole
current line, and `M-w` is remapped to `easy-kill` — press it, then `w` word,
`s` sexp, `l` line, `f` file name, digits to extend. `C-M-SPC` is `easy-mark`,
the same thing for marking.

---

## Navigation

`SPC` in evil normal state is `avy-goto-word-1`.

| Key | Action |
|---|---|
| `C-:` | Jump to any visible character |
| `C-'` | Jump by two-character prefix (more precise) |
| `M-g f` | Jump to a visible line |
| `M-g g` | Go to line number |
| `M-g m` | Jump to a previous mark in this buffer |
| `C-x C-j` | Dired at the current file's directory |

`C-u C-SPC` jumps back to the previous mark, and since
`set-mark-command-repeat-pop` is on, plain `C-SPC` keeps walking back. That's
the "where was I five edits ago" key.

---

## Completion

`corfu-auto` is on: completion appears after 2 characters with a 0.2s delay.

| Key | Action |
|---|---|
| `TAB` | Indent if indentation is needed, otherwise complete |
| `M-/` | `hippie-expand` — complete from text in other open buffers |

`corfu-popupinfo-mode` is on, so pausing on a candidate shows its docstring —
with CIDER connected, that's live Clojure docs inline.

---

## Git

| Key | Action |
|---|---|
| `s-m m` | `magit-status` |
| `s-m b` | `magit-blame` |
| `s-m l` | Log for the current file |
| `C-c g` | `magit-file-dispatch` — Git actions scoped to this file |

---

## Odds and ends

| Key | Action |
|---|---|
| `C-c a` | Org agenda |
| `C-c c` | Org capture |
| `C-c l` | Store an org link |
| `C-c t` | Open a terminal buffer |
| `C-x m` | Start eshell |
| `C-x u` | Undo-tree visualizer (a real tree, not a linear stack) |

---

## Known conflicts

- `C-.` and `C-;` are also flyspell's auto-correct keys, so in text modes
  (Markdown, org, commit messages) flyspell wins and Embark won't fire.
  Embark works everywhere else, including the minibuffer.
- `M-y` is claimed by `browse-kill-ring` in core and `consult-yank-pop` in the
  vertico module. Modules load after core, so consult wins; `s-y` still gives
  you `browse-kill-ring`.

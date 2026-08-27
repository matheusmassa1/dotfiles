# Keybindings cheat sheet

Personal reference for this Emacs setup: **Prelude** + **evil-mode** + **CIDER**
+ **Sly** + **python-ts-mode/Eglot** + **smartparens-strict** +
**vertico/consult/embark** + **corfu**.

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

## Common Lisp / Sly

`personal.el` installs Sly with `inferior-lisp-program` set to `sbcl`
(`/usr/bin/sbcl`). Sly hangs everything off the `C-c` prefix inside `.lisp`
buffers, so `C-c` + pause shows the whole map via which-key.

### Starting and reaching the REPL

| Key | Action |
|---|---|
| `M-x sly` | Start SBCL and open the REPL |
| `C-c C-z` | Jump to the REPL (`sly-mrepl`) |
| `C-c ~` | Sync the REPL's package **and** directory to this buffer |
| `C-c C-x c` | List connections (`C-c C-x n` / `C-c C-x p` cycle them) |

### The eval loop

| Key | Action |
|---|---|
| `C-x C-e` | Eval the form before point |
| `C-M-x` | Eval the top-level form around point |
| `C-c C-c` | **Compile** the top-level form — this is the one to use, it gives compiler notes |
| `C-c C-k` | Compile and load the whole file |
| `C-c C-l` | Load the file (no compile) |
| `C-c C-r` | Eval the region |
| `C-c C-p` | Eval the form before point and pretty-print the result in a popup |
| `C-c C-e` or `C-c :` | Prompt for a form and eval it in the REPL's package |
| `C-c C-b` | Interrupt the running evaluation |
| `C-c C-u` | Undefine the function at point |

**Note for evil users:** `personal.el` advises `sly-eval-last-expression` to
step point forward one char in normal state, so `C-x C-e` with the block cursor
sitting on the closing `)` evaluates that form instead of the one before it.
The advice is on `sly-eval-last-expression` only — `C-M-x` and `C-c C-c` work on
the enclosing form and never needed it.

### Compiler notes

Compiling with `C-c C-c` / `C-c C-k` underlines warnings in place.

| Key | Action |
|---|---|
| `M-n` / `M-p` | Next / previous compiler note |
| `C-c M-c` | Clear the notes |

### Navigation and docs

| Key | Action |
|---|---|
| `M-.` / `M-,` | Jump to definition / jump back |
| `C-c C-d C-d` | Describe the symbol at point |
| `C-c C-d C-f` | Describe the function |
| `C-c C-d C-h` | Look it up in the HyperSpec |
| `C-c C-d C-a` | Apropos search (`C-c C-d C-p` limits it to one package) |
| `C-c C-d ~` | HyperSpec entry for a `format` directive |
| `C-c C-m` | Macroexpand once (`C-c M-m` expands all) |
| `C-c I` | Inspect the value of a form |
| `C-c C-t` | Toggle tracing of the function at point |
| `C-c <` / `C-c >` | List callers / callees |
| `C-c C-w C-c` | Who calls this? (`C-r` references, `C-m` macroexpands, `C-b` binds, `C-s` sets) |

### In the REPL

| Key | Action |
|---|---|
| `RET` | Send the input |
| `M-p` / `M-n` | Previous / next input from history |
| `,` | REPL shortcut menu — `cd`, `in-package`, `restart lisp`, `sayoonara` |
| `C-c C-o` | Clear the most recent output |
| `C-c M-o` | Clear the whole REPL |
| `C-c C-c` or `C-c C-b` | Interrupt |
| `TAB` | Indent, or complete the symbol |

`,` is the one worth internalizing: `,restart lisp` gives you a clean image
without leaving Emacs, and `,in-package` beats typing `(in-package :foo)`.

### The debugger (sly-db)

Any unhandled condition drops you into a backtrace buffer. It is a normal
buffer — read it, don't panic-quit it.

| Key | Action |
|---|---|
| `0`–`9` | Invoke that numbered restart |
| `a` or `q` | Abort to top level |
| `c` | Continue |
| `n` / `p` | Next / previous frame |
| `RET` or `t` | Toggle details for the frame at point |
| `v` | Show the frame's source |
| `e` | Eval a form **in that frame's lexical context** |
| `d` | Same, pretty-printed |
| `i` | Inspect a value in the frame's context |
| `s` / `x` / `o` | Step into / over / out |
| `r` | Restart the frame |
| `R` | Return a value from the frame |
| `C` | Inspect the signalled condition |

`e` on a frame is the reason to stay in the debugger instead of aborting: you
get a REPL with the failing function's locals in scope.

### In the inspector

| Key | Action |
|---|---|
| `RET` | Inspect the part at point |
| `l` / `n` | Back / forward through the inspection history |
| `e` | Eval a form with `*` bound to the inspected object |
| `g` | Re-inspect (refresh after a change) |
| `q` | Quit |

Sly's selector (`sly-selector`, the quick jump to REPL / notes / connections)
is **not** bound by default in this version — the old `C-c C-s` binding is
commented out upstream. Bind it yourself if you want it:
`(global-set-key (kbd "C-z") sly-selector-map)`.

---

## Python

`prelude-python` uses `python-ts-mode` when the tree-sitter grammar is present
and calls `prelude-lsp-enable`, which for this config means **Eglot**
(`prelude-lsp-client` defaults to `eglot`). Diagnostics reach Flycheck through
`flycheck-eglot`.

> No Python language server is on `PATH` right now (no `pylsp`, `pyright`,
> `ruff`, `jedi-language-server`), so Eglot will prompt for a command when you
> open a `.py` file. Install one — `pipx install python-lsp-server` or
> `pipx install pyright` — and the LSP keys below start working.

### The REPL loop

| Key | Action |
|---|---|
| `C-c C-p` | Start an inferior Python (`run-python`) |
| `C-c C-z` | Switch to the Python shell |
| `C-c C-c` | Send the whole buffer |
| `C-c C-e` | Send the statement at point |
| `C-c C-b` | Send the enclosing block |
| `C-c C-r` | Send the region |
| `C-M-x` | Send the def or class at point |
| `C-c C-s` | Prompt for a string and send it |

`C-c C-e` (statement) is the everyday key — the direct analogue of `C-c C-e` in
CIDER or `C-x C-e` in Sly. It sends the whole logical statement, so it works
on a multi-line call without selecting anything.

In the Python shell: `M-p` / `M-n` walk the history, `C-c C-c` interrupts,
`C-d` exits.

### LSP (Eglot)

| Key | Action |
|---|---|
| `M-.` / `M-,` | Jump to definition / jump back |
| `M-?` | Find references |
| `C-c C-l r` | Rename the symbol project-wide |
| `C-c C-l e` | Code actions at point |
| `C-c C-l f` | Format the buffer |
| `C-c C-l o` | Organize imports |
| `C-c C-d` | Describe the thing at point (`C-c C-f` for a one-line eldoc) |

### Errors

| Key | Action |
|---|---|
| `C-c ! l` | List all errors in the buffer |
| `C-c ! n` / `C-c ! p` | Next / previous error |
| `C-c ! e` | Explain the error at point |
| `C-c ! c` | Re-check the buffer |
| `C-c C-v` | `python-check` — run flake8/pylint over the file as a compilation |

### Imports and skeletons

| Key | Action |
|---|---|
| `C-c C-i a` | Add an import for the symbol at point |
| `C-c C-i f` | Add imports for every unresolved name in the buffer |
| `C-c C-i r` | Remove an import |
| `C-c C-i s` | Sort the imports |
| `C-c C-t d` / `c` / `i` / `f` / `w` / `t` / `m` | Insert a def / class / if / for / while / try / import skeleton |

`C-c C-i f` is the payoff key: write the code first, then let it resolve the
imports in one pass.

### Indentation and movement

| Key | Action |
|---|---|
| `TAB` | Cycle this line through the plausible indentation levels |
| `<backspace>` | Dedent one level (instead of deleting one char) |
| `C-c <` / `C-c >` | Shift the region left / right |
| `M-a` / `M-e` | Previous / next block (remapped from sentence motions) |
| `C-M-a` / `C-M-e` | Previous / next def or class |
| `C-M-u` | Move out to the enclosing block |
| `C-c C-j` | imenu — jump to a def or class in this file |

`prelude-python` sets a **flat** imenu index, so `C-c C-j` and `M-g i` list
`Foo.bar` rather than making you descend into `Foo` first.

Note that `smartparens-strict-mode` is *not* on here — it is enabled by
`prelude-lisp-coding-hook` only. Evil's `dd` and `x` behave normally in Python.

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
- `C-c I` opens the init file globally, but in a `.lisp` buffer Sly's prefix
  map shadows it with `sly-inspect`. Use `M-x prelude-find-user-init-file`.
- `C-c C-l` is `python-shell-send-file` in `python-mode`, but the Eglot map is
  a minor-mode map and wins, so with a server running it becomes the
  `C-c C-l r/e/f/o` prefix. Send the file with `M-x python-shell-send-file`.
- `C-c C-c` means three different things by mode: compile the top-level form
  in Sly, eval the top-level form in CIDER, send the whole buffer in Python.

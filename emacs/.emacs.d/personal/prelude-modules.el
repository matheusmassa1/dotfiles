;;; Code:

(require 'prelude-vertico) ;; A powerful, yet simple, alternative to ivy
(require 'prelude-corfu) ;; Lightweight modern alternative to Company (mutually exclusive with prelude-company)

;;; Vim emulation
(require 'prelude-evil)

;;; Org-mode (a legendary productivity tool that deserves its own category)
;;
;; Org-mode helps you keep TODO lists, notes and more.
(require 'prelude-org)

;;; Programming languages support

(require 'prelude-clojure)
(require 'prelude-emacs-lisp)
(require 'prelude-lisp) ;; Common setup for Lisp-like languages
(require 'prelude-python)
(require 'prelude-shell)
(require 'prelude-yaml)

;;; Misc
;; (require 'prelude-ai) ;; LLM-backed chat via gptel
;; (require 'prelude-erc) ;; A popular Emacs IRC client
;; (require 'prelude-forge) ;; GitHub/GitLab/Gitea PRs and issues via Magit
;; (require 'prelude-mistty) ;; MisTTY terminal (pure elisp, no native module; rebinds C-c t)

(provide 'prelude-modules)
;;; prelude-modules.el ends here

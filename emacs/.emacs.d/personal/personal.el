;; Sly for Common Lisp (sbcl at /usr/bin/sbcl)
(use-package sly
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl"))

;; Press "jk" to leave insert state and return to normal mode
(use-package evil-escape
  :ensure t
  :after evil
  :config
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2)
  (evil-escape-mode 1))

;; In evil normal state the block cursor sits on a char, so C-x C-e evals the
;; sexp before it and misses the closing paren. Bump point forward one char.
(advice-add 'sly-eval-last-expression :around
            (lambda (orig &rest args)
              (if (and (bound-and-true-p evil-mode)
                       (eq evil-state 'normal)
                       (not (eolp)))
                  (save-excursion (forward-char) (apply orig args))
                (apply orig args))))

;; floating popup for docstrings
(prelude-require-package 'eldoc-box)
;; Guard the hook: prelude-require-package installs but doesn't require, so a
;; half-installed eldoc-box leaves this function void. An erroring prog-mode-hook
;; then breaks byte-compilation of every package installed afterwards.
(add-hook 'prog-mode-hook
          (lambda ()
            (when (fboundp 'eldoc-box-hover-at-point-mode)
              (eldoc-box-hover-at-point-mode 1))))
(add-hook 'eldoc-box-hover-at-point-mode-hook
          (lambda ()
            (when eldoc-box-hover-at-point-mode
              (setq-local eldoc-display-functions
                          (remq 'eldoc-display-in-buffer
                                eldoc-display-functions)))))


;; clj-kondo
(use-package flycheck-clj-kondo
  :ensure t)

(use-package clojure-mode
  :ensure t
  :config
  (require 'flycheck-clj-kondo))

;; Evil binds M-. to evil-repeat-pop-next in normal state, and evil's state maps
;; outrank mode maps, so xref/sly/cider/eglot never see the key. nil = undefined
;; here, so lookup falls through to whatever the buffer actually provides.
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "M-.") nil))

(use-package uv-mode
  :hook (python-mode . uv-mode-auto-activate-hook))

;; Treemacs keeps its own workspace of projects and knows nothing about the
;; project projectile just switched to, so a fresh workspace renders empty.
;; treemacs-project-follow-mode keeps the workspace pointed at the current
;; project instead of requiring projects to be added by hand.
(use-package treemacs
  :ensure t
  :bind ("C-c T" . treemacs)
  :config
  (treemacs-project-follow-mode 1))

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile))

(use-package treemacs-evil
  :ensure t
  :after (treemacs evil))

(provide 'personal)
;;; personal.el ends here

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
(add-hook 'prog-mode-hook #'eldoc-box-hover-at-point-mode)

(provide 'personal)

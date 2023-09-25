(use-package eglot
  :ensure nil

  :defer t

  :bind
  (("C-c l c" . eglot-rename)
   ("C-c l a" . eglot-code-actions)
   ("C-c l f" . eglot-format-buffer))

  :custom
  (eglot-send-changes-idle-time 0.1)

  :config
  (fset #'jsonrpc--log-event #'ignore)  ; massive perf boost---don't log every event
  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '((lua-mode lua-ts-mode) . ("lua-language-server")))
  (add-to-list 'eglot-server-programs '((typescript-mode typescript-ts-mode) . ("vtsls" "--stdio")))

  :hook
  ;; Auto parenthesis matching
  ((prog-mode . electric-pair-mode))
  ((prog-mode . eglot-ensure)))

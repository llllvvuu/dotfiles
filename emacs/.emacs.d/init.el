(tool-bar-mode -1)
(menu-bar-mode -1)
(setq display-time-default-load-average nil)
(setq auto-revert-interval 1)
(setq auto-revert-check-vc-info t)
(global-auto-revert-mode)
(savehist-mode)
(windmove-default-keybindings 'control)
(setq sentence-end-double-space nil)
(setq-default indent-tabs-mode nil)

;; Don't litter file system with *~ backup files; put them all inside
;; ~/.emacs.d/backup or wherever
(defun bedrock--backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* ((backupRootDir "~/.emacs.d/emacs-backup/")
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") )))
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath))
(setq make-backup-file-name-function 'bedrock--backup-file-name)
(defvar backup-dir "~/.emacs.d/backups/")
(setq backup-directory-alist (list (cons "." backup-dir)))

(setq enable-recursive-minibuffers t)                ; Use the minibuffer whilst in the minibuffer
(setq completions-detailed t)                        ; Show annotations
(setq completion-styles '(basic initials substring)) ; Different styles to match input to candidates
(setq tab-always-indent 'complete)                   ; When I hit TAB, try to complete, otherwise, indent
(setq completion-styles '(basic initials substring)) ; Different styles to match input to candidates

(setq completion-auto-help 'always)                  ; Open completion always; `lazy' another option
(setq completions-max-height 20)                     ; This is arbitrary
(setq completions-detailed t)
(setq completions-format 'one-column)
(setq completions-group t)
(setq completion-auto-select 'second-tab)            ; Much more eager

(setq line-number-mode t)                        ; Show current line in modeline
(setq column-number-mode t)
(add-hook 'text-mode-hook 'visual-line-mode)
(global-display-line-numbers-mode)
(global-hl-line-mode)
(setq-default display-line-numbers-width 3)
(setq-default show-trailing-whitespace t)

(require 'package)
(require 'bind-key)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package
  catppuccin-theme
  :ensure t)
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'latte)
(catppuccin-reload)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; Consult: Misc. enhanced commands
(use-package consult
  :ensure t
  ;; Other good things to bind: consult-ripgrep, consult-line-multi,
  ;; consult-history, consult-outlineconsult-outlineconsult-outlineconsult-outlineconsult-outline
  :bind (("C-x b" . consult-buffer) ; orig. switch-to-buffer
         ("M-y" . consult-yank-pop) ; orig. yank-pop
         ("C-s" . consult-line)    ; orig. isearch
         ("C-c O" . consult-outline)
         ("C-c r g" . consult-ripgrep)
         ("C-C g g" . consult-git-grep)
         ("C-c M" . consult-global-mark))
  :config
  ;; Narrowing lets you restrict results to certain groups of candidates
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

(use-package consult-ls-git
  :bind
  (("C-c g f" . #'consult-ls-git)
   ("C-c g F" . #'consult-ls-git-other-window)))

(use-package avy
  :ensure t
  :bind (("M-n" . avy-goto-char)))

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-c m a" . mc/mark-all-like-this-dwim)
   ("C-c m A" . mc/mark-all-like-this)
   ("C-c m y" . mc/mark-all-dwim)
   ("C-c m n" . mc/mark-next-like-this)
   ("C-c m p" . mc/mark-previous-like-this)
   ("C-c m ." . mc/skip-to-next-like-this)
   ("C-c m ," . mc/skip-to-previous-like-this)
   ("C-c m m" . mc/edit-lines)))

(use-package consult-ls-git
  :ensure t
  :bind
  (("C-c g f" . #'consult-ls-git)
   ("C-c g F" . #'consult-ls-git-other-window)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Minibuffer and completion
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Vertico: better vertical completion for minibuffer commands
(use-package vertico
  :ensure t
  :init
  ;; You'll want to make sure that e.g. fido-mode isn't enabled
  (vertico-mode))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind (:map vertico-map
              ("M-DEL" . vertico-directory-delete-word)))

;; Marginalia: annotations for minibuffer
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; Popup completion-at-point
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 0)
  :bind
  (:map corfu-map
        ("SPC" . corfu-insert-separator)
        ("C-n" . corfu-next)
        ("C-p" . corfu-previous)))

(use-package corfu-popupinfo
  :ensure nil
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config
  (corfu-popupinfo-mode))

;; Make corfu popup come up in terminal overlay
(use-package corfu-terminal
  :if (not (display-graphic-p))
  :ensure t
  :config
  (corfu-terminal-mode))

;; Orderless: powerful completion style
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

(load-file (expand-file-name "./treesitter.el" user-emacs-directory))
(load-file (expand-file-name "./lsp.el" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(catppuccin-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

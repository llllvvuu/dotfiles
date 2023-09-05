(tool-bar-mode -1)
(menu-bar-mode -1)

(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
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
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

(load-file (expand-file-name "./treesitter.el" user-emacs-directory))

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

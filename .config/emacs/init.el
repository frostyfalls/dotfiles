  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile
    (require 'use-package))

  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  (setq inhibit-startup-screen t)

  (global-display-line-numbers-mode 1)
  (setq-default display-line-numbers-width 3)

  (global-hl-line-mode 1)

  (setq-default show-trailing-whitespace t)

  (use-package mode-line-bell
    :ensure t
    :config (mode-line-bell-mode))

  (setq mouse-wheel-progressive-speed nil)

  (electric-pair-mode 1)

  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  (setq-default use-short-answers t)

  (use-package vertico
    :ensure t
    :config
    (vertico-mode)
    (define-key vertico-map (kbd "RET") #'vertico-directory-enter)
    (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-word)
    (define-key vertico-map (kbd "M-d") #'vertico-directory-delete-char))

  (use-package orderless
    :ensure t
    :config
    (setq completion-styles '(orderless basic)
	  completion-category-overrides '((file (styles basic partial-completion)))))

  (setq read-buffer-completion-ignore-case t
	read-file-name-completion-ignore-case t
	completion-ignore-case t)

  (use-package eglot
    :hook (prog-mode-hook . eglot-ensure))

  (use-package flymake
    :hook (prog-mode-hook . flymake-mode)
    :config
    (setq help-at-pt-display-when-idle t)
    (define-key flymake-mode-map (kbd "C-c n") #'flymake-goto-next-error)
    (define-key flymake-mode-map (kbd "C-c p") #'flymake-goto-prev-error))

  (use-package corfu
    :ensure t
    :hook (prog-mode-hook . corfu-mode)
    :init
    (setq corfu-auto t))

  (use-package magit
    :ensure t
    :config
    (global-set-key (kbd "C-c g") #'magit-status))

  (use-package diff-hl
    :ensure t
    :hook (prog-mode-hook . diff-hl-mode))

  (use-package go-mode
    :ensure t)
  (use-package json-mode
    :ensure t)
  (use-package yaml-mode
    :ensure t)
  (use-package markdown-mode
    :ensure t)

  (use-package editorconfig
    :ensure t
    :config (editorconfig-mode))

  (setq custom-file (locate-user-emacs-file "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file))

  (use-package savehist
    :config (savehist-mode))

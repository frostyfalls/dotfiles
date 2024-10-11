;;; init.el --- Initialization file for Emacs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize))

(use-package emacs
  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  (setq inhibit-startup-screen t)

  (set-face-attribute 'default nil
                      :font "Fira Code"
                      :height 100
                      :weight 'regular)
  (set-face-attribute 'mode-line nil
		      :height 90)

  (global-display-line-numbers-mode)
  (setq-default display-line-numbers-width 3)

  (global-hl-line-mode)

  (setq-default show-trailing-whitespace t))

(use-package emacs
  :config
  (setq mouse-wheel-progressive-speed nil)

  (electric-pair-mode)

  (setq-default use-short-answers t)

  (add-hook 'before-save-hook 'delete-trailing-whitespace))

(use-package mode-line-bell
  :ensure t
  :init
  (mode-line-bell-mode))

(use-package vertico
  :ensure t
  :init (vertico-mode)
  :config
  (setq read-buffer-completion-ignore-case t
	read-file-name-completion-ignore-case t
	completion-ignore-case t)
  (define-key vertico-map (kbd "RET") #'vertico-directory-enter)
  (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-word)
  (define-key vertico-map (kbd "M-d") #'vertico-directory-delete-char))

(use-package which-key
  :ensure t
  :init (which-key-mode)
  :config
  (setq which-key-max-display-columns 5
        which-key-min-display-lines 6
	which-key-show-early-on-C-h t))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
	completion-category-overrides '((file (styles basic partial-completion)))))

(use-package eglot
  :hook (prog-mode-hook . eglot-ensure)
  :config
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c h") 'eldoc))

(use-package flymake
  :hook (prog-mode-hook . flymake-mode)
  :config
  (setq help-at-pt-display-when-idle t)
  (define-key flymake-mode-map (kbd "C-c n") #'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "C-c p") #'flymake-goto-prev-error))

(use-package corfu
  :ensure t
  :init (corfu-mode))

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-c g") #'magit-status))

(use-package editorconfig
  :ensure t
  :init (editorconfig-mode))

(use-package go-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package savehist
  :init (savehist-mode))

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;;; init.el ends here

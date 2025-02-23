;;; init.el --- Personal configuration  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)

(set-face-attribute 'default nil
                    :font "Liberation Mono"
                    :height 90
                    :weight 'regular)

(use-package display-line-numbers
  :hook (prog-mode emacs-lisp-mode)
  :custom
  (display-line-numbers-type 'relative))

(use-package gruber-darker-theme
  :ensure t
  :init (load-theme 'gruber-darker t))

(use-package vertico
  :ensure t
  :init (vertico-mode t)
  :bind (:map vertico-map
	      ("RET" . vertico-directory-enter)
	      ("DEL" . vertico-directory-delete-word)
	      ("M-d" . vertico-directory-delete-char)))

(use-package corfu
  :ensure t
  :hook (prog-mode emacs-lisp-mode))

(use-package magit
  :ensure t
  :custom
  (magit-diff-refine-hunk t)
  :bind (:map global-map
	      ("C-c g" . magit-status)))

(use-package which-key
  :ensure t
  :init (which-key-mode t)
  :custom
  (which-key-side-window-location 'bottom))

(use-package flymake
  :hook (emacs-lisp-mode sh-mode)
  :bind (:map flymake-mode-map
	      ("C-c n" . flymake-goto-next-error)
	      ("C-c p" . flymake-goto-prev-error)))

(use-package eglot
  :hook (c-mode go-mode . 'eglot-ensure))

(setq window-resize-pixelwise t)
(save-place-mode t)
(savehist-mode t)
(defalias 'yes-or-no #'y-or-n-p)

(setq kill-whole-line t)
(global-set-key [escape] 'keyboard-escape-quit)
(keymap-global-set "C-;" "C-a C-SPC C-n M-w C-y C-p")
(electric-pair-mode t)

(use-package go-mode
  :ensure t)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;;; init.el ends here

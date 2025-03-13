(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :noerror)

;;; Package Manager

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless package-archive-contents
  (package-refresh-contents))

;;; Interface

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)

(set-face-attribute 'default nil
                    :font "DejaVu Sans Mono"
                    :height 90
                    :weight 'regular)

(set-face-attribute 'font-lock-comment-face nil
		    :slant 'italic)

(use-package gruber-darker-theme
  :ensure t
  :init (load-theme 'gruber-darker t))

(use-package display-line-numbers
  :hook (prog-mode emacs-lisp-mode)
  :custom
  (display-line-numbers-type 'relative)
  (display-line-numbers-width 3))

(setq use-short-answers t)
(setq use-dialog-box nil)

;;; Editor Behavior

(electric-pair-mode t)
(setq kill-whole-line t)

(global-auto-revert-mode t)
(savehist-mode t)
(save-place-mode t)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

;;; Global Keymaps

(keymap-global-set "C-;" "C-a C-SPC C-n M-w C-y C-p")

;;; Org
;; TODO(frosty): Set up better binds for jumping around Org documents

;; (use-package org
;;   :hook (org-mode . org-indent-mode)
;;   :custom
;;   (org-directory "~/documents/org/")
;;   (org-journal-dir (expand-file-name org-directory "journal/"))
;;   (org-agenda-files '((expand-file-name org-directory "agenda.org")))
;;   (org-default-notes-file (expand-file-name org-directory "notes.org")))

;;; Minibuffer Completion
;; TODO(frosty): Set up better binds

(use-package vertico
  :ensure t
  :init (vertico-mode t)
  :bind (:map vertico-map
	      ("RET" . vertico-directory-enter)
	      ("DEL" . vertico-directory-delete-word)
	      ("M-d" . vertico-directory-delete-char)))

(use-package marginalia
  :ensure t
  :init (marginalia-mode t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;; Completion at Point
;; TODO(frosty): Set up snippets and spell-checking

(use-package corfu
  :ensure t
  :hook (prog-mode emacs-lisp-mode)
  :custom
  (corfu-quit-no-match 'separator))

(setq tab-always-indent 'complete)

;;; Git
;; TODO(frosty): Set up inline diff information

(use-package magit
  :ensure t
  :bind (:map global-map
	      ("C-c g" . magit-status))
  :custom
  (magit-diff-refine-hunk t))


;;; which-key
;; TODO(frosty): Tweak options

(use-package which-key
  :ensure t
  :init (which-key-mode t)
  :custom
  (which-key-side-window-location 'bottom))

;;; Syntax Checking
;; TODO(frosty): Tweak options
;; TODO(frosty): Use each major mode's package for initialization

(use-package flycheck
  :ensure t
  :hook (sh-mode c-mode go-mode))

;;; Language Servers

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :init (global-flycheck-eglot-mode t))

(use-package eglot
  :hook ((c-mode go-mode) . eglot-ensure))

(use-package editorconfig
  :ensure t
  :init (editorconfig-mode t))

;; Prevent custom from writing to init.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(add-to-list 'load-path "~/.config/emacs/scripts/buffer-move")

(require 'buffer-move)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Ensure `use-package` is available and install it if not
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Use `use-package` to manage packages and ensure they are installed
(eval-when-compile
  (require 'use-package))




;; Download and configure Doom Themes
(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

;; Download and configure Evil
(use-package evil
  :init
  (setq evil-want-integration :
	evil-want-keybinding nil
	evil-want-C-u-scroll t
	evil-want-C-i-jump nil)
  (evil-mode 1)
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join))

(use-package evil-collection
  :after evil
  :init
  (evil-collection-init))



(defun lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))


(use-package neotree)

;; Download and configure which-key
(use-package which-key
  :after evil
  :init
  (which-key-mode 1)
  :config
  (setq which-key-delay 1
	which-key-allow-evil-operators t
        which-key-show-operator-state-maps t))

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-icon nil))

(defun reload-init-file ()
  "Reloads the Emacs user init file."
  (interactive)
  (load-file user-init-file))





(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :after evil
  :config
  (general-create-definer leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "M-SPC")

  (leader-keys
    "dd" 'dired
    "dj" 'dired-jump
    "g"  'comment-line

    "bb" 'switch-to-buffer
    "bi" 'ibuffer
    "bc" 'kill-this-buffer
    "bn" 'next-buffer
    "bp" 'previous-buffer
    "br" 'revert-buffer

    "ww" 'evil-window-next
    "wh" 'evil-window-left
    "wj" 'evil-window-down
    "wk" 'evil-window-up
    "wl" 'evil-window-right

    "wH" 'buf-move-left
    "wJ" 'buf-move-down
    "wK" 'buf-move-up
    "wL" 'buf-move-right

    "="  'text-scale-increase
    "-"  'text-scale-decrease

    "fs" 'save-buffer
    "fe" 'display-line-numbers-mode
    "fj" 'visual-line-mode
    "hr" 'reload-init-file))


;; Hide UI distractions
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

;; Disable startup screen
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Display line numbers
(display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Fix scrolling speed and behavior
(setq mouse-wheel-scroll-amount '(0.04)
      mouse-wheel-progressive-speed nil)


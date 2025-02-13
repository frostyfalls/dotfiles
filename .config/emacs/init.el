;; Load configuration as an org document
(org-babel-load-file
 (expand-file-name
  "README.org"
  user-emacs-directory))

;; Move custom.el configurations to a separate file
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

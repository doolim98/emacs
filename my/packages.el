;;; packages.el -*- lexical-binding: t; -*-


;; Completion system
;; -----------------
;; Use vertico
(my/load-config "completion.el")


(use-package nyan-mode
  :disabled t
  :config
  (nyan-mode 1)
  )

;; Cursor & Window: avy, ace-window
;; --------------------------------
(use-package avy
  :config
  (global-set-key (kbd "C-j") 'avy-goto-char-2)
  (global-set-key (kbd "M-g w") 'avy-goto-word-2)
  )

(use-package ace-window
  :init
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-dispatch-always t))

(use-package expand-region
  :init
  :bind ("M-=" . er/expand-region))

;; (setq blink-cursor-delay 0.2)
(setq blink-cursor-interval 0.3)

;; (use-package find-file-in-project)

;; Editor
;; ======

(use-package eglot
  :init
  :config
  ;; (setq eglot-extend-to-xref t) ; Xref out of proj
  )

;; Completion
;; ----------


;; Git
(use-package magit
  :init
  :config)

;; FIXME: Cloning the llvm repo is tooooooo slow.
;; Do manual copy and specify `load-path'.
(use-package llvm-mode
  ;; :disabled t
  :straight (:host github
             :repo "llvm-mirror/llvm"
             :nonrecursive t
             :depth 1
             :files ("utils/emacs/llvm-mode.el" "utils/emacs/tablegen-mode.el")))

(use-package modus-themes
  :config
  (load-theme 'modus-operandi)
  )

(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t
	markdown-header-scaling t)
  )

(use-package doc-view
  :straight nil
  :hook (doc-view-mode . auto-revert-mode)
  :config
  (setq doc-view-resolution 300)
  )

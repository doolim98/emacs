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

(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  ;; Ignore some commands
  (setq keyfreq-excluded-commands
      '(self-insert-command
        forward-char
        backward-char
        previous-line
        next-line))
  )

(use-package perspective
  :disabled t
  :bind (("C-x k" . persp-kill-buffer))
  :init
  (persp-mode))

;; Cursor & Window: avy, ace-window
;; --------------------------------
(use-package avy
  :config
  (global-set-key (kbd "M-j") 'avy-goto-word-1)
  (global-set-key (kbd "M-q c r") 'avy-copy-region)
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  (global-set-key (kbd "M-g l") 'avy-goto-line)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?\;))

  ;; (setq avy-keys (number-sequence ?a ?z))
  (setq avy-timeout-seconds 0.4)
  (setq avy-orders-alist
      '((avy-goto-char . avy-order-closest)
        (avy-goto-word-0 . avy-order-closest)))
  )

(use-package ace-window
  :init
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  ;; (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-dispatch-always t))

(use-package expand-region
  :init
  :bind ("C-x =" . er/expand-region))

;; Editor
;; ======

(use-package eglot
  :init
  :config
  ;; (setq eglot-extend-to-xref t) ; Xref out of proj
  )

;; Git
(use-package magit
  :init
  :config
  (setq magit-define-global-key-bindings 'recommended)
  )

(use-package git-gutter
  :init
  :config
  (global-git-gutter-mode 1)
  (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
  (add-to-list 'git-gutter:update-commands 'other-window)
  
  ;; first character should be a space
  (custom-set-variables
    '(git-gutter:lighter " GG"))
  )


(use-package god-mode
  :disabled t
  :init
  :bind (
	 )
  :config
  ;; (define-key god-local-mode-map "q" ctl-x-map)
  ;; (define-key god-local-mode-map (kbd "f") #'avy-goto-char-2)
  ;; (define-key god-local-mode-map (kbd "h") (kbd "C-b"))
  ;; (define-key god-local-mode-map (kbd "l") (kbd "C-f"))
  ;; (define-key god-local-mode-map (kbd "j") (kbd "C-n"))
  ;; (define-key god-local-mode-map (kbd "k") (kbd "C-p"))
  ;; (define-key god-local-mode-map (kbd ".") #'repeat)
  (define-key god-local-mode-map (kbd "z") #'repeat)
  (define-key god-local-mode-map (kbd "i") #'type-something-quickly)
  (define-key god-local-mode-map (kbd "[") #'backward-paragraph)
  (define-key god-local-mode-map (kbd "]") #'forward-paragraph)
  (global-set-key (kbd "C-c C-g") #'god-mode-all)

  (defun my-god-mode-update-mode-line ()
    (cond
     (god-local-mode
      (set-face-attribute 'mode-line nil
                          :foreground "#604000"
                          :background "#fff29a")
      (set-face-attribute 'mode-line-inactive nil
                          :foreground "#3f3000"
                          :background "#fff3da"))
     (t
      (set-face-attribute 'mode-line nil
			  :foreground "#0a0a0a"
			  :background "#d7d7d7")
      (set-face-attribute 'mode-line-inactive nil
			  :foreground "#404148"
			  :background "#efefef"))))

  (add-hook 'post-command-hook #'my-god-mode-update-mode-line)
  
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (god-mode-all 1)
  (custom-set-faces
   '(god-mode-lighter ((t (:inherit error)))))
  (defun type-something-quickly ()
    (interactive)
    (run-with-idle-timer 0.7 nil
			 #'(lambda ()
			     (hl-line-mode -1)
			     (god-local-mode 1)
			     (my-god-mode-update-mode-line)))
    (my-god-mode-update-mode-line)
    (god-local-mode -1)
    (hl-line-mode 1))
)

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
  ;; (load-theme 'modus-operandi)
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

(use-package yaml-mode
  :config
  )

(use-package ein
  )

(use-package latex-preview-pane
  :config
  )

(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 2)
  )


(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  )

(use-package flymake-grammarly
  ;; :hook ((text-mode . 'flymake-grammarly-load))
  :config
  (setq flymake-grammarly-check-time 0.8)
  )

(use-package rg
  :config
  (rg-enable-default-bindings)
  )

(use-package log4j-mode
  :init
  (add-hook #'log4j-mode-hook #'view-mode)
  (add-hook #'log4j-mode-hook #'read-only-mode)
  )

(use-package buffer-ring
  :init
  )

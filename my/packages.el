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

;; Completion
;; ----------
(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :bind
  ;; Configure C-SPC for separator insertion
  (:map corfu-map ("C-SPC" . corfu-insert-separator))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-exclude-modes'.
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package corfu-terminal
  :config
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)))

;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  ;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))

;; Cape mode
;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ;; ("C-c p a" . cape-abbrev)
         ;; ("C-c p l" . cape-line)
         ;; ("C-c p w" . cape-dict)
         ;; ("C-c p \\" . cape-tex)
         ;; ("C-c p _" . cape-tex)
         ;; ("C-c p ^" . cape-tex)
         ;; ("C-c p &" . cape-sgml)
         ;; ("C-c p r" . cape-rfc1345)
	 )
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; NOTE: The order matters!
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
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

(use-package mermaid-mode
  :config
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

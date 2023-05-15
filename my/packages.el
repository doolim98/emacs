;;; packages.el -*- lexical-binding: t; -*-


;; Completion system
;; -----------------
;; Use vertico
(my/load-config "completion.el")

;; (my/load-config "ivy.el") ;; Ivy

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
  ;; (setq avy-timeout-seconds 0.1)
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
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
)


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

;; (use-package persp-mode

(use-package gruvbox-theme
  :config
  ;; (load-theme 'gruvbox-light-hard)
  )

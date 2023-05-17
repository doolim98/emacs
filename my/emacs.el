;; Some default configurations
;; TODO: native compilation
;; Install Emacs-plus -with-native-comp ??

;;; DISABLE EMACS HARSHING EMACS DEFAULTS
(auto-save-mode -1)
(setq make-backup-files nil)
(setq ring-bell-function 'ignore)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq show-paren-delay 0.0)		; No delay
(setq help-window-select t) ; Always select help window
(setq auto-save-default nil) ; No auto save
(setq dabbrev-case-fold-search nil)
(setq dabbrev-upcase-means-case-search t)

;; Enable some built-in emacs features
(recentf-mode 1)
(which-func-mode 1)
(tab-bar-mode 1)
(desktop-save-mode 1)			; TODO: desktop mode for tramp?
(savehist-mode 1)			; Save commands(e.g. M-x)
(save-place-mode 1)			; Save file cursor
(winner-mode 1)				; Window features(e.g. redo/undo window)

;; Project LLVM
(setq project-vc-merge-submodules nil)


(setq dired-listing-switches "-alh")

(defun my/comment-dwim ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line.

URL `http://xahlee.info/emacs/emacs/emacs_toggle_comment_by_line.html'
Version 2016-10-25"
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let (($lbp (line-beginning-position))
          ($lep (line-end-position)))
      (if (eq $lbp $lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) $lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region $lbp $lep)
            (forward-line )))))))

(global-set-key (kbd "M-;") 'my/comment-dwim)

;; SOME KEY BINDINGS
;; MacOS config
(when (eq system-type 'darwin)
  (setq
   mac-command-modifier 'meta
   mac-option-key-is-meta nil
   mac-command-key-is-meta t
   ;; mac-option-modifier 'meta
   ))
;; esc always quits
;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
;; (global-set-key [escape] 'keyboard-quit)


;; Seperate custom-file location




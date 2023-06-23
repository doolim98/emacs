;; Some default configurations
;; TODO: native compilation
;; Install Emacs-plus -with-native-comp ??

;;; DISABLE EMACS HARSHING EMACS DEFAULTS
(auto-save-mode -1)
(setq make-backup-files nil)
(setq ring-bell-function 'ignore)

(setq show-paren-delay 0.3)

(menu-bar-mode -1)
(tool-bar-mode -1)

(when (display-graphic-p)
  (scroll-bar-mode -1))

(setq help-window-select t) ; Always select help window
(setq auto-save-default nil) ; No auto save
(setq dabbrev-case-fold-search nil)
(setq dabbrev-upcase-means-case-search t)

;; Enable some built-in emacs features
(recentf-mode 1)
;; (which-func-mode 1)
(tab-bar-mode 1)
;; (desktop-save-mode 1)			; TODO: desktop mode for tramp?
(savehist-mode 1)			; Save commands(e.g. M-x)
(save-place-mode 1)			; Save file cursor
(winner-mode 1)				; Window features(e.g. redo/undo window)
(global-set-key (kbd "C-x w /") 'winner-undo)

(xterm-mouse-mode 1)

(setq font-lock-maximum-decoration 3)

(setq-default show-trailing-whitespace t)

;; (setq mode-line-mule-info nil
;;       mode-line-frame-identification nil
;;       mode-line-position
;;       )

(setq isearch-lazy-count t
      lazy-count-prefix-format "(%s/%s)"
      lazy-count-suffix-format nil)
(setq search-whitespace-regexp ".*?")

(setq doc-view-continuous t)

;; (setq mode-line-format
;; '("-"
;;  mode-line-mule-info
;;  mode-line-modified
;;  mode-line-frame-identification
;;  mode-line-buffer-identification
;;  (which-function-mode ("" which-func-format ""))
;;  "   "
;;  mode-line-position
;;  (vc-mode vc-mode)
;;  "   "
;;  mode-line-modes
;;  (global-mode-string ("--" global-mode-string))
;;  "-%-")
;; )

;; Project LLVM
(setq project-vc-merge-submodules nil)


(setq dired-listing-switches "-alh")
(setq auto-revert-interval 1)

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
(global-set-key (kbd "C-x ;") 'comment-line)

;; SOME KEY BINDINGS
;; MacOS config
(when (eq system-type 'darwin)
  (setq
   mac-command-modifier 'meta
   mac-option-key-is-meta nil
   mac-command-key-is-meta t
   ;; mac-option-modifier 'meta
   ))




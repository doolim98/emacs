(setq native-comp-async-report-warnings-errors nil)

;; Utils
(defun my/load-config (file)
  (interactive "sConfig file path:")
  (load (concat "~/.config/emacs/my/" file)))

(defun my/unhighlight-symbol-at-point ()
  "Remove highlight of symbol at point."
  (interactive)
  (unhighlight-regexp (concat "\\_<" (thing-at-point 'symbol) "\\_>")))

;;; LOAD CONFIGURATIONS
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(my/load-config "key.el")
(my/load-config "emacs.el")
(my/load-config "packages.el")
(my/load-config "org.el")
(my/load-config "project.el")
(my/load-config "appearance.el")

;; (my/set-font-size 12)
(set-frame-font "Fira Code 12" nil t)
;; (set-frame-font "Iosevka Term 16" nil t)

;; Dired
(setq dired-dwim-target t)

;; Eldoc config
(use-package eldoc
  :straight nil
  :init
  (setq eldoc-idle-delay 0.5)
  )

;;; Tramp configuration
(use-package tramp
  :straight nil
  :config
  (setq vc-handled-backends '(Git)
	remote-file-name-inhibit-locks t
	tramp-verbose 2
	tramp-default-method "sshx"
	tramp-use-ssh-controlmaster-options nil ;; Fix Forbidden reentrant call.
	tramp-copy-size-limit 100000
	tramp-inline-compress-start-size 4096
	)

  (add-to-list 'tramp-remote-path "~/.cargo/bin")
  (setq enable-remote-dir-locals t) ;; Enable remote dir locals!!!!
  )

;; ispell
(setq ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")
      ispell-personal-dictionary "~/.config/emacs/data/.pws"
      ;; spell-fu-directory "~/.config/emacs/dictionary"
      )


;; My Util Function

;; MY TUTORIAL FUNCTIONS
;; useless functions
(defun my/buffer (buf)
  (interactive "bBuffer :")
  (message "%s" buf))
(defun my/reload-init ()
  "reload init.el"
  (interactive)
  (load "~/.config/emacs/init.el"))

(define-minor-mode minor-mode-blackout-mode
  "Hides minor modes from the mode line."
  t)

(catch 'done
  (mapc (lambda (x)
          (when (and (consp x)
                     (equal (cadr x) '("" minor-mode-alist)))
            (let ((original (copy-sequence x)))
              (setcar x 'minor-mode-blackout-mode)
              (setcdr x (list "" original)))
            (throw 'done t)))
        mode-line-modes))

(global-set-key (kbd "C-c m") 'minor-mode-blackout-mode)

;; FIX emacs's default enter behavior in shell
(defun my-comint-send-input-maybe ()
  "Only `comint-send-input' when point is after the latest prompt.

Otherwise move to the end of the buffer."
  (interactive)
  (let ((proc (get-buffer-process (current-buffer))))
    (if (and proc (>= (point) (marker-position (process-mark proc))))
        (comint-send-input)
      (goto-char (point-max)))))

(with-eval-after-load "comint"
  (define-key shell-mode-map [remap comint-send-input] 'my-comint-send-input-maybe))

;; CONFIG END
;; Load Custom file

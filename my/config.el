;; Useful links
;; - https://robbmann.io/emacsd/

;; Utils
(defun my/load-config (file)
  (interactive "sConfig file path:")
  (load (concat "~/.config/emacs/my/" file)))

(defun my/unhighlight-symbol-at-point ()
  "Remove highlight of symbol at point."
  (interactive)
  (unhighlight-regexp (concat "\\_<" (thing-at-point 'symbol) "\\_>")))

;;; LOAD CONFIGURATIONS
(my/load-config "key.el")
(my/load-config "emacs.el")
(my/load-config "packages.el")

;; TODO
;; (set-frame-font "Iosevka 12" nil t)
(setq my/font "Fira Code")
(setq my/font-size 14)


(defun my/get-font-size()
  (interactive)
  )


(defun my/set-font-size(font-size)
  (let (fstr (format "%s %d" my/fong font-size))    
    ;; (set-frame-font fstr nil t)
    ))

;; (my/set-font-size 12)
(set-frame-font "Fira Code 13" nil t)
;; (set-frame-font "Iosevka Term 16" nil t)

;; Dired
(setq dired-dwim-target t)

;; Eldoc config
(use-package eldoc
  :straight nil
  :init
  (setq eldoc-idle-delay 10000)
  :bind
  ("C-h C-h" . eldoc)
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
  
  ;; (customize-set-variable
  ;;  'tramp-ssh-controlmaster-options
  ;;  (concat
  ;;   "-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
  ;;   "-o ControlMaster=auto -o ControlPersist=5"))

  ;; Reduce remote file open delay
  ;; WARN: Indeed, I don't know what following configurations do.
  (setq remote-file-name-inhibit-cache 10)
  ;; (setq vc-ignore-dir-regexp
  ;; 	(format "%s\\|%s"
  ;;               vc-ignore-dir-regexp
  ;;               tramp-file-name-regexp))
  )


;; ispell
(setq ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")
      ispell-personal-dictionary "~/.config/emacs/data/.pws"
      ;; spell-fu-directory "~/.config/emacs/dictionary"
      )


;; My Util Function
(defun my/project-add-dir-local-variable()
  (interactive)
  (let ((default-directory (project-root (project-current))))
  (call-interactively 'add-dir-local-variable)))


(defun my/project-add()
  (interactive)
  (project-remember-project (project-current)))


;; MY TUTORIAL FUNCTIONS
;; useless functions
(defun my/buffer (buf)
  (interactive "bBuffer :")
  (message "%s" buf))
(defun my/reload-init ()
  "reload init.el"
  (interactive)
  (load "~/.config/emacs/init.el"))


;; CONFIG END
;; Load Custom file

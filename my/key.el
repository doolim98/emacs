;; MY Func
(defun my/global-set-key (&rest k+c)
  "..."
  (let (key cmd)
    (while k+c
      (global-set-key (kbd (car k+c)) (cadr k+c))
      (setq k+c  (cddr k+c))))
)

;; Consistent OS keybindings
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "M-Z") 'redo)
(global-set-key (kbd "M-c") 'kill-ring-save)

(global-set-key (kbd "ESC ESC") 'keyboard-quit)

(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC SPC") 'project-switch-project)
(global-set-key (kbd "M-SPC b") 'project-switch-to-buffer)
(global-set-key (kbd "M-SPC f") 'project-find-file)
(global-set-key (kbd "M-SPC K") 'project-kill-buffers)


(global-unset-key (kbd "C-x e"))

(defun my/recenter ()
  (interactive)
  (recenter (/ (window-height) 3)))

(global-set-key (kbd "C-l") 'my/recenter)


(defun my/shrink-window()
  (interactive)
  (shrink-window 7))

(defun my/enlarge-window()
  (interactive)
  (enlarge-window 7))

(my/global-set-key
 "C-x e b" 'eval-buffer
 "C-x e r" 'eval-region
 "C-x e f" 'eval-defun
 "M-)" 'balance-windows
 "M-+" 'my/enlarge-window
 "M-_" 'my/shrink-window
 )

(global-set-key (kbd "C-S-k") 'kill-whole-line)



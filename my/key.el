;; MY Func
(defun my/global-set-key (&rest k+c)
  "..."
  (let (key cmd)
    (while k+c
      (global-set-key (kbd (car k+c)) (cadr k+c))
      (setq k+c  (cddr k+c))))
)


(global-unset-key (kbd "M-q"))
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
 "C-z" 'undo
 "C-S-z" 'undo-redo
 "C-x e b" 'eval-buffer
 "C-x e r" 'eval-region
 "C-x e f" 'eval-defun
 "C-x p a" 'my/project-add
 "M-)" 'balance-windows
 "M-+" 'my/enlarge-window
 "M-_" 'my/shrink-window
 )

(global-set-key (kbd "C-t") 'tab-prefix-map)



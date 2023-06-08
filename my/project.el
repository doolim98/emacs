;; Project related funtions
(defun my/project-add-dir-local-variable()
  (interactive)
  (let ((default-directory (project-root (project-current))))
  (call-interactively 'add-dir-local-variable)))

(defun my/project-add()
  (interactive)
  (project-remember-project (project-current)))

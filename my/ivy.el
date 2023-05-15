(straight-use-package 'prescient)
;; (straight-use-package 'corfu-prescient)
;; (straight-use-package 'company-prescient)


(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-height 15)
  )

(use-package ivy-prescient
  :init
  (ivy-prescient-mode 1)
  )

(use-package counsel
  :init
  :bind
  ("C-s" . 'swiper-C-s)
  ;; ("M-x" . 'counsel-M-x)
  ("M-y" . 'counsel-yank-pop)
  ("C-x C-f" . 'counsel-find-file)
  )

;; (setq project
;; (setq icomplete-vertical-mode t)
;; (setq fido-vertical-mode t)

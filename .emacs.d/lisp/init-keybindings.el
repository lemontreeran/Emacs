(global-set-key (kbd "<f2>") 'open-my-init-file)

(global-set-key "\C-s" 'swiper)
;(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-oqn-key)
;;Setup org-agenda keywords
(global-set-key (kbd "C-c a") 'org-agenda)
;;use `counsel-git` to find file in git managed project.
(global-set-key (kbd "C-c p f") 'counsel-git)
;;Setup indent in region
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)
;;hippie expand is dabbrev expand on steroids
(global-set-key (kbd "s-/") 'hippie-expand)
;;Setup key to reuse current buffer
(with-eval-after-load 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;Enable to open recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

(provide 'init-keybindings)

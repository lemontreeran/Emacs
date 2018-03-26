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
;; Setup key for expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
;;setup key for iedit
(global-set-key (kbd "M-s e") 'iedit-mode)
;;improve occur
(global-set-key (kbd "M-s o") 'occur-dwim)
;;setup key for org-capture template
(global-set-key (kbd "C-c r") 'org-capture)
;;setup key for org-capture
(define-key global-map (kbd "<f9>") 'org-capture)
;;(define-key global-map (kbd "C-c t") 'org-capture)
;;remap Company's select next and select previous keys
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;;Setup key for helm-ag
(global-set-key (kbd "C-c p s") 'helm-do-ag-project-root)

;;Setup key for backward delete one word
(global-set-key (kbd "C-w") 'backward-kill-word)

;;;; Web Development  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;setup key to toggle indent in web-mode
(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)
;;setup key to improve imenu
(add-hook 'js2-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'js2-imenu-make-index)))
(global-set-key (kbd "M-s i") 'counsel-imenu)
;;config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; Setup key for iedit
(provide 'init-keybindings)

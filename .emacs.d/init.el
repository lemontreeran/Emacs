
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'init-packages)

;Auto revert file when they are changed outside the editor
(global-auto-revert-mode t)

;Setup the F2 key to open init.el file
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)
;Enable row number
(global-linum-mode t)
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
;Highlight current line (global-hl-line-mode)
(global-hl-line-mode t)

;Hide the tool bar and scroll bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
;Add delete selection mode
(delete-selection-mode t)
;Enable to open recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
;Cancel welcome page
(setq inhibit-splash-screen t)
;Set the crusor same as the other editor
(setq-default cursor-type 'bar)
;Fix orgmode package HTTPS error
(setq dotspacemacs-elpa-https nil)
;Disable backup files
(setq make-backup-files nil)
;;Disalbe auto save
(setq auto-save-default nil)
;;Open with full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(setq cfs-keep-frame-size nil)
;;disable audio bell
(setq ring-bell-function 'ignore)

(setq-default abbrev-mode t)

(define-abbrev-table 'global-abbrev-table '(
                                            ;; signature
                                            ("8lem" "lemontreeran")
                                            ;; emacs regex
                                            ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (org company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; PACKAGE REPOSITORIES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;("marmalade" . "http://marmalade-repo.org/packages/")
                          ("melpa" . "http://melpa.milkbox.net/packages/")))
)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;(setq package-enable-at-startup nil)

(require 'cl)
 ;; Add Packages
 (defvar my/packages '(
                ;; --- Auto-completion ---
                company
                ;; --- Better Editor ---
                hungry-delete
                swiper
                counsel
                smartparens
                ;; --- Major Mode ---
                js2-mode
                ;; --- Minor Mode ---
                nodejs-repl
                exec-path-from-shell
                ;; --- Themes ---
                monokai-theme
                ;; solarized-theme
                ) "Default packages")
 (setq package-selected-packages my/packages)
 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))
 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))
 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;Install theme
(add-to-list 'my/packages 'monokai-theme)
(load-theme 'monokai 1)

;show match parents
(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)
(show-smartparens-global-mode t)

;Auto revert file when they are changed outside the editor
(global-auto-revert-mode t)

;Delete multiple spaces 
(require 'hungry-delete)
(global-hungry-delete-mode)

;Setup the F2 key to open init.el file
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)
;Enable row number
(global-linum-mode t)
;Open company mode
(global-company-mode t)
;Setup the C-x C-r key to open recent files
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
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
(setq auto-save-default nill)
;;Open with full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(setq cfs-keep-frame-size nil)
;; config js2-mode for js files
(setq auto-mode-alist
	  (append
	   '(("\\.js\\'" . js2-mode))
	   auto-mode-alist))

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


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize) 
(require 'pallet)
(pallet-mode t)

(add-to-list 'load-path "~/.emacs.d/lisp")

;Setup the F2 key to open init.el file
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'init-org)

;;Setup customize-group config
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(load custom-file 'no-error 'no-message)

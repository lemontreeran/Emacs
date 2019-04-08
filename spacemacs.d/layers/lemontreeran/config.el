;;; config.el --- Better Emacs Defaults Layer configuration variables File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Thomas de Beauchêne <thomas.de.beauchene@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; show line number 
(global-linum-mode t)

;; setup key bindings 
(global-set-key (kbd "M-s o") 'occur-dwim)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

;; (setq custom-file (expand-file-name "custom.el" dotspacemacs-directory))
;; (load custom-file 'no-error 'no-message)

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

(defvar org-agenda-dir ""
  "gtd org files location")

(defvar deft-dir ""
  "deft org files locaiton")

(defvar blog-admin-dir ""
  "blog-admin files location")

(if (spacemacs/system-is-mswindows)
    (setq
     org-agenda-dir "f:/org-notes"
     deft-dir "f:/org-notes"
     blog-admin-dir "f:/microiam.com")
  (setq
   org-agenda-dir "~/org-notes"
   deft-dir "~/org-notes"
   blog-admin-dir "~/microiam.com"))


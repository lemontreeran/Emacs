;Auto revert file when they are changed outside the editor
(global-auto-revert-mode t)

;Enable row number
(global-linum-mode t)

;Disable backup files
(setq make-backup-files nil)
;;Disalbe auto save
(setq auto-save-default nil)
;;disable audio bell
(setq ring-bell-function 'ignore)

(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
                                            ;; signature
                                            ("8lem" "lemontreeran")
                                            ;; emacs regex
                                            ))

;; Highlight parens when inside it
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
            (ignore-errors (backward-up-list))
             (funcall fn)))))

;; (require 'smartparens-config)
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)
(show-smartparens-global-mode t)

(require 'highlight-parentheses)  
(define-globalized-minor-mode global-highlight-parentheses-mode  
  highlight-parentheses-mode  
  (lambda ()  
    (highlight-parentheses-mode t)))  
(global-highlight-parentheses-mode t) 

;Add delete selection mode
(delete-selection-mode t)

(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
        (indent-buffer)
        (message "Indent buffer.")))))

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; + create Dir; c-x c-f create file; g refresh buffer; C copy; d delete file;  
;; D delete; R move; x execute; 
;; dired - reuse current buffer by pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)
;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(setq dired-dwim-target t)
(put 'dired-find-alternate-file 'disabled nil)
;; less typing when Emacs ask you yes or no
(fset 'yes-or-no-p 'y-or-n-p)
;; open dired of current buffer

(require 'dired-x)
;Enable to open recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;;improve occur
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))


;;;; Web Development  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Editing large web page
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []));;toggle indent in web-mode

(provide 'init-better-defaults)

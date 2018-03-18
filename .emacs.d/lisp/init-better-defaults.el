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

(provide 'init-better-defaults)

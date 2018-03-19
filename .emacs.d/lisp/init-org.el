;;Org-mode syntax highlight
(require 'org)
(setq org-src-fontify-natively t)
;;Setup default Org Agenda folder
(setq org-agenda-files '("~/org"))
;;Setup org-agenda keywords
(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'init-org)

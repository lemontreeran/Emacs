;;Org-mode syntax highlight
(require 'org)
(setq org-src-fontify-natively t)
;;Setup default Org Agenda folder
(setq org-agenda-files '("~/.emacs.d"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "Work Agenda")
         "* TODO [#B] %?\n  %i\n"
         :empty-lines 1)))

(provide 'init-org)
 

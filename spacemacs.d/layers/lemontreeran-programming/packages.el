;;; config.el --- lemontreeran Layer packages File for Spacemacs
;;
;; Copyright (c) 2015-2016 lemontreeran
;;
;; Author: lemontreeran
;; URL: 
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq lemontreeran-programming-packages
      '(
        css-mode
        paredit
        lispy
        caps-lock
        flycheck
        nodejs-repl
        ;; (spacemacs-solidity :location local)
        js2-mode
        js2-refactor
        json-mode
        yasnippet
        web-mode
        ;; js-doc
        lua-mode
        (cc-mode :location built-in)
        ;; flycheck-clojure
        ;; etags-select
        (python :location built-in)
        (emacs-lisp :location built-in)
        ;; clojure-mode
        company
        ;; dumb-jump
        ;; graphviz-dot-mode
        ;; cider
        ;; editorconfig
        ;; robe
        ;; exec-path-from-shell
        rego-mode
        ))

(defun lemontreeran-programming/post-init-css-mode ()
  (progn
    (dolist (hook '(css-mode-hook sass-mode-hook less-mode-hook))
      (add-hook hook 'rainbow-mode))

    (defun css-imenu-make-index ()
      (save-excursion
        (imenu--generic-function '((nil "^ *\\([^ ]+\\) *{ *$" 1)))))

    (add-hook 'css-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'css-imenu-make-index)))))

(defun lemontreeran-programming/init-paredit ()
  (use-package paredit
    :commands (paredit-wrap-round
               paredit-wrap-square
               paredit-wrap-curly
               paredit-splice-sexp-killing-backward)
    :init
    (progn

      (bind-key* "s-(" #'paredit-wrap-round)
      (bind-key* "s-[" #'paredit-wrap-square)
      (bind-key* "s-{" #'paredit-wrap-curly)
      )))

(defun lemontreeran-programming/init-lispy ()
  (use-package lispy
    :defer t
    :init
    (progn
      (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'ielm-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'inferior-emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
      ;; (add-hook 'spacemacs-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'clojure-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'scheme-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'cider-repl-mode-hook (lambda () (lispy-mode 1)))
      )
    ;; :config
    ;; (progn
    ;;   (push '(cider-repl-mode . ("[`'~@]+" "#" "#\\?@?")) lispy-parens-preceding-syntax-alist)

    ;;   (spacemacs|hide-lighter lispy-mode)
    ;;   (define-key lispy-mode-map (kbd "M-s") 'lispy-splice)
    ;;   (define-key lispy-mode-map (kbd "s-k") 'paredit-splice-sexp-killing-backward)

    ;;   (with-eval-after-load 'cider-repl
    ;;     (define-key cider-repl-mode-map (kbd "C-s-j") 'cider-repl-newline-and-indent))

    ;;   (add-hook
    ;;    'minibuffer-setup-hook
    ;;    ;; 'conditionally-enable-lispy
    ;;    )
    ;;   (define-key lispy-mode-map (kbd "s-m") 'lispy-mark-symbol)
    ;;   (define-key lispy-mode-map (kbd "s-u") 'lispy-undo)
    ;;   (define-key lispy-mode-map (kbd "s-1") 'lispy-describe-inline)
    ;;   (define-key lispy-mode-map (kbd "s-2") 'lispy-arglist-inline))
))

(defun lemontreeran-programming/init-caps-lock ()
  (use-package caps-lock
    :init
    (progn
      (bind-key* "s-e" 'caps-lock-mode))))

(defun lemontreeran-programming/init-flycheck-package ()
  (use-package flycheck-package))

(defun lemontreeran-programming/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (progn
      (setq flycheck-display-errors-delay 0.9)
      (setq flycheck-idle-change-delay 2.0)
      )))

(defun lemontreeran-programming/init-nodejs-repl ()
  (use-package nodejs-repl
    :init
    :defer t))

(defun lemontreeran-programming/post-init-js2-mode ()
  (progn
    ;; (add-hook 'js2-mode-hook 'my-setup-develop-environment)
    ;; (add-hook 'web-mode-hook 'my-setup-develop-environment)

    (spacemacs|define-jump-handlers js2-mode)
    (add-hook 'spacemacs-jump-handlers-js2-mode 'etags-select-find-tag-at-point)

    (setq company-backends-js2-mode '((company-dabbrev-code :with company-keywords company-etags)
                                      company-files company-dabbrev))

    (setq company-backends-js-mode '((company-dabbrev-code :with company-keywords company-etags)
                                     company-files company-dabbrev))

    (add-hook 'js2-mode-hook 'my-js2-mode-hook)

    ;; add your own keywords highlight here
    (font-lock-add-keywords 'js2-mode
                            '(("\\<\\(cc\\)\\>" 1 font-lock-type-face)))

    (spacemacs/declare-prefix-for-mode 'js2-mode "ms" "repl")

    (with-eval-after-load 'js2-mode
      (progn
        ;; these mode related variables must be in eval-after-load
        ;; https://github.com/magnars/.emacs.d/blob/master/settings/setup-js2-mode.el
        (setq-default js2-allow-rhino-new-expr-initializer nil)
        (setq-default js2-auto-indent-p nil)
        (setq-default js2-enter-indents-newline nil)
        (setq-default js2-global-externs '("module" "ccui" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
        (setq-default js2-idle-timer-delay 0.2)
        (setq-default js2-mirror-mode nil)
        (setq-default js2-strict-inconsistent-return-warning nil)
        (setq-default js2-include-rhino-externs nil)
        (setq-default js2-include-gears-externs nil)
        (setq-default js2-concat-multiline-strings 'eol)
        (setq-default js2-rebind-eol-bol-keys nil)
        (setq-default js2-auto-indent-p t)

        (setq-default js2-bounce-indent nil)
        (setq-default js-indent-level 4)
        (setq-default js2-basic-offset 4)
        (setq-default js-switch-indent-offset 4)
        ;; Let flycheck handle parse errors
        (setq-default js2-mode-show-parse-errors nil)
        (setq-default js2-mode-show-strict-warnings nil)
        (setq-default js2-highlight-external-variables t)
        (setq-default js2-strict-trailing-comma-warning nil)

        (add-hook 'web-mode-hook 'my-web-mode-indent-setup)

        (spacemacs/set-leader-keys-for-major-mode 'js2-mode
          "ti" 'my-toggle-web-indent)
        (spacemacs/set-leader-keys-for-major-mode 'js-mode
          "ti" 'my-toggle-web-indent)
        (spacemacs/set-leader-keys-for-major-mode 'web-mode
          "ti" 'my-toggle-web-indent)
        (spacemacs/set-leader-keys-for-major-mode 'css-mode
          "ti" 'my-toggle-web-indent)

        (spacemacs/declare-prefix-for-mode 'js2-mode "mt" "toggle")
        (spacemacs/declare-prefix-for-mode 'js-mode "mt" "toggle")
        (spacemacs/declare-prefix-for-mode 'web-mode "mt" "toggle")
        (spacemacs/declare-prefix-for-mode 'css-mode "mt" "toggle")


        ))

    (evilified-state-evilify js2-error-buffer-mode js2-error-buffer-mode-map)

    ))

(defun lemontreeran-programming/post-init-js2-refactor ()
  (progn
    
(defun js2r-toggle-object-property-access-style ()
  "Toggle js object property access style."
  (interactive)
  (js2r--guard)
  (js2r--wait-for-parse
   (save-excursion
     (let ((node (js2-node-at-point)))
       (if (js2-string-node-p node)
           (let* ((start (js2-node-abs-pos node))
                  (end (+ start (js2-node-len node))))
             (when (memq (char-before start) '(?\[))
               (save-excursion
                 (goto-char (-  end 1)) (delete-char 2)
                 (goto-char (+ start 1)) (delete-char -2) (insert "."))))
         (let* ((start (js2-node-abs-pos node))
                (end (+ start (js2-node-len node))))
           (when (memq (char-before start) '(?.))
             (save-excursion
               (goto-char end) (insert "\']")
               (goto-char start) (delete-char -1) (insert "[\'")))))))))

    (spacemacs/set-leader-keys-for-major-mode 'js2-mode
      "r>" 'js2r-forward-slurp
      "r<" 'js2r-forward-barf
      "r." 'js2r-toggle-object-property-access-style)))

(defun lemontreeran-programming/post-init-json-mode ()
  (add-to-list 'auto-mode-alist '("\\.tern-project\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.fire\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.fire.meta\\'" . json-mode))
  (spacemacs/set-leader-keys-for-major-mode 'json-mode
    "ti" 'my-toggle-web-indent))

(defun lemontreeran-programming/post-init-yasnippet ()
  (progn
    (set-face-background 'secondary-selection "gray")
    (setq-default yas-prompt-functions '(yas-ido-prompt yas-dropdown-prompt))
    (mapc #'(lambda (hook) (remove-hook hook 'spacemacs/load-yasnippet)) '(prog-mode-hook
                                                                           org-mode-hook
                                                                           markdown-mode-hook))

    (spacemacs/add-to-hooks 'lemontreeran/load-yasnippet '(prog-mode-hook
                                                            markdown-mode-hook
                                                            org-mode-hook))
    ))

(defun lemontreeran-programming/post-init-web-mode ()
  (with-eval-after-load "web-mode"
    (web-mode-toggle-current-element-highlight)
    (web-mode-dom-errors-show))
  (setq company-backends-web-mode '((company-dabbrev-code
                                     company-keywords
                                     company-etags)
                                    company-files company-dabbrev)))

(defun lemontreeran-programming/post-init-cc-mode ()
  (progn
    (setq company-backends-c-mode-common '((company-dabbrev-code :with company-keywords company-gtags company-etags)
                                           company-files company-dabbrev))
    (spacemacs/set-leader-keys-for-major-mode 'c++-mode
      "gd" 'etags-select-find-tag-at-point)


    ;; (add-hook 'c++-mode-hook 'my-setup-develop-environment)
    ;; (add-hook 'c-mode-hook 'my-setup-develop-environment)


    ;; http://stackoverflow.com/questions/23553881/emacs-indenting-of-c11-lambda-functions-cc-mode
    (defadvice c-lineup-arglist (around my activate)
      "Improve indentation of continued C++11 lambda function opened as argument."
      (setq ad-return-value
            (if (and (equal major-mode 'c++-mode)
                     (ignore-errors
                       (save-excursion
                         (goto-char (c-langelem-pos langelem))
                         ;; Detect "[...](" or "[...]{". preceded by "," or "(",
                         ;;   and with unclosed brace.
                         (looking-at ".*[(,][ \t]*\\[[^]]*\\][ \t]*[({][^}]*$"))))
                0                       ; no additional indent
              ad-do-it)))               ; default behavior


    (setq c-default-style "linux") ;; set style to "linux"
    (setq c-basic-offset 4)
    (c-set-offset 'substatement-open 0)
    (with-eval-after-load 'c++-mode
      (define-key c++-mode-map (kbd "s-.") 'company-ycmd)))
  )

(defun lemontreeran-programming/post-init-lua-mode ()
  (progn
    (add-hook 'lua-mode-hook 'evil-matchit-mode)
    ;; (add-hook 'lua-mode-hook 'smartparens-mode)
    (setq lua-indent-level 2)
    ))

(defun lemontreeran-programming/post-init-cc-mode ()
  (progn
    (setq company-backends-c-mode-common '((company-dabbrev-code :with company-keywords company-gtags company-etags)
                                           company-files company-dabbrev))
    (spacemacs/set-leader-keys-for-major-mode 'c++-mode
      "gd" 'etags-select-find-tag-at-point)


    ;; (add-hook 'c++-mode-hook 'my-setup-develop-environment)
    ;; (add-hook 'c-mode-hook 'my-setup-develop-environment)


    ;; http://stackoverflow.com/questions/23553881/emacs-indenting-of-c11-lambda-functions-cc-mode
    (defadvice c-lineup-arglist (around my activate)
      "Improve indentation of continued C++11 lambda function opened as argument."
      (setq ad-return-value
            (if (and (equal major-mode 'c++-mode)
                     (ignore-errors
                       (save-excursion
                         (goto-char (c-langelem-pos langelem))
                         ;; Detect "[...](" or "[...]{". preceded by "," or "(",
                         ;;   and with unclosed brace.
                         (looking-at ".*[(,][ \t]*\\[[^]]*\\][ \t]*[({][^}]*$"))))
                0                       ; no additional indent
              ad-do-it)))               ; default behavior


    (setq c-default-style "linux") ;; set style to "linux"
    (setq c-basic-offset 4)
    (c-set-offset 'substatement-open 0)
    (with-eval-after-load 'c++-mode
      (define-key c++-mode-map (kbd "s-.") 'company-ycmd)))
  )

(defun lemontreeran-programming/post-init-python ()
  (add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  ;; if you use pyton3, then you could comment the following line
  (setq python-shell-interpreter "python"))

(defun lemontreeran-programming/post-init-emacs-lisp ()
  (remove-hook 'emacs-lisp-mode-hook 'auto-compile-mode))

;; (defun lemontreeran-programming/init-exec-path-from-shell ()
;;   (use-package exec-path-from-shell
;;     :init
;;     (when (memq window-system '(mac ns))
;;       (exec-path-from-shell-initialize))))

(defun lemontreeran-programming/post-init-company ()
  (progn
    (setq company-minimum-prefix-length 1
          company-idle-delay 0.08)

    (when (configuration-layer/package-usedp 'company)
      (with-eval-after-load 'company
        ;; (spacemacs|add-company-hook python-mode shell-script-mode makefile-bsdmake-mode sh-mode lua-mode nxml-mode conf-unix-mode json-mode graphviz-dot-mode js2-mode js-mode)    
        ;; (spacemacs|add-company-backends
        ;;  :modes shell-script-mode makefile-bsdmake-mode sh-mode lua-mode nxml-mode conf-unix-mode json-mode graphviz-dot-mode js2-mode js-mode)
        ))
    ))

;; Activate support for Open Policy Agent
(defun lemontreeran-programming/init-rego-mode ()
  (use-package rego-mode
    :init
    :ensure t
    :custom
    (rego-repl-executable "opa")
    (rego-opa-command "opa")
    (add-to-list 'auto-mode-alist '("\\.rego\\'" . rego-mode))
    )
  )

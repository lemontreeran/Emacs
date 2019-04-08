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

;;js2-mode enhancement
(defun lemontreeran/js2-which-function ()
  ;; clean the imenu cache
  ;; @see http://stackoverflow.com/questions/13426564/how-to-force-a-rescan-in-imenu-by-a-function
  (setq imenu--index-alist nil)
  (which-function-mode t)
  (which-function))

(defun lemontreeran/load-yasnippet ()
  (interactive)
  (unless yas-global-mode
    (progn
      (yas-global-mode 1)
      (setq my-snippet-dir (expand-file-name "~/.spacemacs.d/snippets"))
      (setq yas-snippet-dirs '(my-snippet-dir))
      (yas-load-directory my-snippet-dir)
      (setq yas-wrap-around-region t)))
  (yas-minor-mode 1))

(defun my-js2-mode-hook ()
  (progn
    (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc-snippet)
    (define-key js2-mode-map "@" 'js-doc-insert-tag)
    (modify-syntax-entry ?_ "w")
    (which-function-mode t)
    (setq imenu-create-index-function 'js2-imenu-make-index)

    (setq mode-name "JS2")

    ;; (spacemacs/toggle-syntax-checking-on)
    (setq forward-sexp-function nil)
    (set (make-local-variable 'semantic-mode) nil)))

(defun js2-imenu-make-index ()
  (interactive)
  (save-excursion
    ;; this imenu generic expression aims to exclude for, while, if when aims to match functions in
    ;; es6 js, e.g. ComponentDidMount(), render() function in React
    ;; https://emacs-china.org/t/topic/4538/7
    (defun js-exception-imenu-generic-expression-regexp ()
      ;; (async)? xxx (e) { }
      (if (re-search-backward "^[ \t]*\\(async\\|get\\|set\\)?[ \t]*\\([A-Za-z_$][A-Za-z0-9_$]+\\)[ \t]*([\{a-zA-Z0-9, \\\)\(/'\"\*=\t\n\}]*) *\{ *" nil t)
          (progn
            (if (member (match-string 2) '("for" "if" "while" "switch"))
                (js-exception-imenu-generic-expression-regexp)
              t))
        nil))
    ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
    (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("Controller" "[. \t]controller([ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("Controller" "[. \t]controllerAs:[ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("Filter" "[. \t]filter([ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("State" "[. \t]state([ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("Factory" "[. \t]factory([ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("Service" "[. \t]service([ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("Module" "[. \t]module([ \t]*['\"]\\([a-zA-Z0-9_\.]+\\)" 1)
                               ("ngRoute" "[. \t]when(\\(['\"][a-zA-Z0-9_\/]+['\"]\\)" 1)
                               ("Directive" "[. \t]directive([ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("Event" "[. \t]\$on([ \t]*['\"]\\([^'\"]+\\)" 1)
                               ("Config" "[. \t]config([ \t]*function *( *\\([^\)]+\\)" 1)
                               ("Config" "[. \t]config([ \t]*\\[ *['\"]\\([^'\"]+\\)" 1)
                               ("OnChange" "[ \t]*\$(['\"]\\([^'\"]*\\)['\"]).*\.change *( *function" 1)
                               ("OnClick" "[ \t]*\$([ \t]*['\"]\\([^'\"]*\\)['\"]).*\.click *( *function" 1)
                               ("Watch" "[. \t]\$watch( *['\"]\\([^'\"]+\\)" 1)


                               ("ES6 Function" js-exception-imenu-generic-expression-regexp 2) ;; (async)? xxx (e) { }
                               ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                               ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                               ("Function" "^[ \t]*static[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)

                               ("Class" "^[ \t]*var[ \t]*\\([0-9a-zA-Z]+\\)[ \t]*=[ \t]*\\([a-zA-Z]*\\).extend" 1)
                               ("Class" "^[ \t]*cc\.\\(.+\\)[ \t]*=[ \t]*cc\.\\(.+\\)\.extend" 1)

                               ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))

;; (defun my-setup-develop-environment ()
;;   (interactive)
;;   (when (my-project-name-contains-substring "lemontreeran")
;;     (cond
;;      ((my-project-name-contains-substring "cocos2d-x")
;;       ;; C++ project don't need html tags
;;       (setq tags-table-list (list (my-create-tags-if-needed "~/cocos2d-x/cocos"))))
;;      ((my-project-name-contains-substring "Github/fireball")
;;       (message "load tags for fireball engine repo...")
;;       ;; html project donot need C++ tags
;;       (setq tags-table-list (list (my-create-tags-if-needed "~/Github/fireball/engine/cocos2d")))))))

;; (defun my-project-name-contains-substring (REGEX)
;;   (let ((dir (if (buffer-file-name)
;;                  (file-name-directory (buffer-file-name))
;;                "")))
;;     (string-match-p REGEX dir)))

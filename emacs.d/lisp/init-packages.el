;;;; PACKAGE REPOSITORIES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;("marmalade" . "http://marmalade-repo.org/packages/")
                          ("melpa" . "http://melpa.milkbox.net/packages/")))
)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;(setq package-enable-at-startup nil)


 ;; Add Packages
 (defvar my/packages '(
                ;; --- Auto-completion ---
                company
		yasnippet-snippets
		auto-yasnippet
		;; --- Better Editor ---
                hungry-delete
                swiper
                counsel
                smartparens
		highlight-parentheses
		popwin
		evil
		;; --- the finder of the current file ---
		reveal-in-osx-finder
		;; --- Batch change files ---
		expand-region
		iedit
		;; --- Search and replace ---
		helm-ag
		;; --- Agenda ---
		org-pomodoro
                ;; --- Major Mode ---
		;; --- JS highlight and Linter ---
                js2-mode
		;; --- JS refactor ---
		js2-refactor
                ;; --- Minor Mode ---
		;; --- Excute and test ---
                nodejs-repl
                exec-path-from-shell
		reveal-in-osx-finder
		;; --- Find the syntax error for JS, Python(Dynamic Programming Language). It needs eslint in NPM ---
		flycheck
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
;; this hopefully sets up path and other vars better
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;Install theme
(add-to-list 'my/packages 'monokai-theme)
(load-theme 'monokai 1)

;;Popup window Management
(require 'popwin)
(popwin-mode 1)

;; Do not pair '
(require 'smartparens)
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
;;(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

;Delete multiple spaces 
(require 'hungry-delete)
(global-hungry-delete-mode)
;Open company mode
(global-company-mode t)

;Fix orgmode package HTTPS error
(setq dotspacemacs-elpa-https nil)
;Setup the C-x C-r key to open recent files
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;;;; Web Development  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; config js2-mode for js files
(setq auto-mode-alist
	  (append
	   '(("\\.js\\'" . js2-mode))
	   '(("\\.html\\'" . web-mode))
	   auto-mode-alist))

;;toggle indent in web-mode
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))
  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))
  (setq indent-tabs-mode nil))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(require 'flycheck)

;;Open flycheck for js2-mode only
(add-hook 'js2-mode-hook 'flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;;improve imenu
(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
        ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
        (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                                   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))

;;Use yas-minor-mode on a per-buffer basis
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(require 'org-pomodoro)

(provide 'init-packages)

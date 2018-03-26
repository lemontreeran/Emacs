;Highlight current line (global-hl-line-mode)
(global-hl-line-mode t)

;;Hide the tool bar and scroll bar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;Setup the background and forground color for Highlight, region
(set-face-foreground 'highlight "white")
(set-face-background 'highlight "blue")
(set-face-foreground 'region "cyan")
(set-face-background 'region "blue")
(set-face-foreground 'secondary-selection "skyblue")
(set-face-background 'secondary-selection "darkblue")
(set-foreground-color "grey")
(set-background-color "black")

;Cancel welcome page
(setq inhibit-splash-screen t)
;;Open with full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(setq cfs-keep-frame-size nil)
;Set the crusor same as the other editor
(setq-default cursor-type 'bar)

(provide 'init-ui)

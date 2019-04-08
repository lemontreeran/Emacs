
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

(defun lemontreeran/pomodoro-notification ()
  "show notifications when pomodoro end"
  (if (spacemacs/system-is-mswindows)
      (progn (add-hook 'org-pomodoro-finished-hook '(lambda () (sound-wav-play (expand-file-name "~/.spacemacs.d/game_win.wav"))))
             (add-hook 'org-pomodoro-short-break-finished-hook '(lambda () (sound-wav-play (expand-file-name "~/.spacemacs.d/game_win.wav"))))
             (add-hook 'org-pomodoro-long-break-finished-hook '(lambda () (sound-wav-play (expand-file-name "~/.spacemacs.d/game_win.wav")))))
    (progn (add-hook 'org-pomodoro-finished-hook '(lambda () (zilongshanren/growl-notification "Pomodoro Finished" "☕️ Have a break!" t)))
           (add-hook 'org-pomodoro-short-break-finished-hook '(lambda () (zilongshanren/growl-notification "Short Break" "🐝 Ready to Go?" t)))
           (add-hook 'org-pomodoro-long-break-finished-hook '(lambda () (zilongshanren/growl-notification "Long Break" " 💪 Ready to Go?" t))))))

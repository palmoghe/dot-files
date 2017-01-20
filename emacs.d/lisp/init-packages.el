;;; init-packages.el
;;;
;;; Author: Pallavi Moghe
;;; Email: palmoghe@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;
;;; Configure installed packages. Make sure that we have
;;; the required packages installed.
;;;

;; weather forecast
(require 'sunshine)
(setq sunshine-location "94043,USA")

;; color-themes
(require 'gotham-theme)

;; auto-pair-mode
(require 'autopair)
(autopair-global-mode)
(setq autopair-autowrap t)

;; auto-complete-mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat dotfiles-dir "/extensions/auto-complete/ac-dict"))
(ac-config-default)

;; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)
(provide 'init-packages)

;; start flymake-google-cpplint-load
;; let's define a function for flymake initialization
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables 
   '(flymake-google-cpplint-command "/usr/local/bin"))
  (flymake-google-cpplint-load)
)

(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

;; start google-c-style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

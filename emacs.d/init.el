;; init.el
;;
;; Author: Pallavi Moghe
;; Email: palmoghe@gmail.com
;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;
;; Emacs configuration top level script - loads path and provides features

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))


(add-to-list 'load-path (concat dotfiles-dir "lisp"))

(require 'init-install)
(require 'init-packages)

;; Load basic configuration
(require 'init-basic)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("590759adc4a5bf7a183df81654cce13b96089e026af67d92b5eec658fb3fe22f" "cdbd0a803de328a4986659d799659939d13ec01da1f482d838b68038c1bb35e8" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

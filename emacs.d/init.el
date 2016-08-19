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

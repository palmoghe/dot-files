;; Emacs configuration top level script
;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))


(add-to-list 'load-path (concat dotfiles-dir "lisp"))

(require 'init-install)
(require 'init-packages)

;; Load basic configuration
(require 'init-basic)

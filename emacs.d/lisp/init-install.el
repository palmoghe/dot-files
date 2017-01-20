;;; init-install.el
;;;
;;; Author: Pallavi Moghe
;;; Email: palmoghe@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;
;;; Install packages
;;;

(defvar packages  '(
		;;; This is the list of packages to be installed
		;;; Add packages here
		color-theme
		auto-complete
		autopair
		gotham-theme
		markdown-mode
		sunshine
		)
  )

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

(when (not package-archive-contents) (package-refresh-contents))

(dolist (p packages)
  (when (not (package-installed-p p))
	(package-install p)))

(provide 'init-install)

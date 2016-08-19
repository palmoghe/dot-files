;;; init-basic.el
;;;
;;; Author: Pallavi Moghe
;;; Email: palmoghe@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;
;;; This file sets basic configuration parameters. Please find more details
;;; in the code.
;;;

(setq user-full-name "Pallavi Moghe")
(setq user-mail-address "palmoghe@gmail.com")


;; Scroll one line at a time
(setq scroll-step 1)

;; Show line and column numbers on minibuffer
(line-number-mode 1)
(column-number-mode 1)

;; Change font
(set-default-font "-unknown-Liberation Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")

;; By default backups (files ending in ~) are saved in current directory
(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(provide 'init-basic)

;; Maximize on statup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Unbind Pesky Sleep Button
(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])

;; Prevent silly initial splash screen
(setq inhibit-splash-screen t)

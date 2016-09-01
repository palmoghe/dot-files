;;; nlog-mode.el --- example of a CC Mode derived mode for a new language

;; Author:     2013 Tim Hinrichs
;; Maintainer: Unmaintained
;; Created:    September 2013
;; Version:    1.0
;; Keywords:   nlog languages syntax

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;; Note: The interface used in this file requires CC Mode 5.30 or
;; later.

;;; Installation: add to your ~/.emacs the following
;;; (add-to-list 'load-path "PATH/TO/CLOUDNET/doc")
;;; (autoload 'nlog-mode "nlog-mode" "Major mode for editing NLog programs." t)
;;; (add-to-list 'auto-mode-alist '("\\.n$" . nlog-mode))

;;; Code:

(require 'cc-mode)

;; These are only required at compile time to get the sources for the
;; language constants.  (The cc-fonts require and the font-lock
;; related constants could additionally be put inside an
;; (eval-after-load "font-lock" ...) but then some trickery is
;; necessary to get them compiled.)
(eval-when-compile
  (require 'cc-langs)
  (require 'cc-fonts))

(eval-and-compile
  ;; Make our mode known to the language constant system.  Use C
  ;; mode as the fallback for the constants we don't change here.
  ;; This needs to be done also at compile time since the language
  ;; constants are evaluated then.
  (c-add-language 'nlog-mode 'c-mode))

;;;;;;;;;;;;;;;;;;;;
;; CUSTOMIZE THIS

;; Variables that partition NLog keywords; change these.
;;  Change these as NLog changes; the below code highlights them as
;;  appropriate.
(defconst nlog-mode-types '("input_schema" "output_schema" "schema" "view"
          "constant" "enumeration" "function"))
(defconst nlog-mode-structures '("namespace" "using"))
(defconst nlog-mode-keywords '("unique" "index" "assert"))


(defcustom nlog-font-lock-extra-types nil
  "*List of extra types (aside from the type keywords) to recognize in NLog mode.
Each list item should be a regexp matching a single identifier.")

; Choices for faces:
; http://www.gnu.org/software/emacs/manual/html_node/elisp/Faces-for-Font-Lock.html
(defvar nlog-only-matchers
  (list
    ;; highlight all the reserved commands.
   `(,(concat "\\_<" (regexp-opt nlog-mode-types) "\\_>")
      . font-lock-type-face)
   `(,(concat "\\_<" (regexp-opt nlog-mode-structures) "\\_>")
      . font-lock-constant-face)
   `(,(concat "\\_<" (regexp-opt nlog-mode-keywords) "\\_>")
      . font-lock-builtin-name-face)
   )
  "NLog-specific syntax, i.e. everything except the C preprocessor syntax")

(defconst nlog-matchers
  (append (c-lang-const c-cpp-matchers nlog)
          nlog-only-matchers)
  "Entire NLog syntax")

; These are the calls that actually do the syntax highlighting.
; Don't understand why there are 3 levels.
; Leave since they were helpful in understanding how cc-fonts.el works

; (defconst nlog-font-lock-keywords-1 (c-lang-const c-matchers-1 nlog)
;   "Minimal highlighting for NLog mode.")

; (defconst nlog-font-lock-keywords-2 (c-lang-const c-matchers-2 nlog)
;   "Fast normal highlighting for NLog mode.")

; Can't remove this one without an error.
(defconst nlog-font-lock-keywords-3 nlog-matchers
  ;(c-lang-const c-matchers-3 nlog)
  "Accurate normal highlighting for NLog mode.")

(defvar nlog-font-lock-keywords nlog-font-lock-keywords-3
 "Default expressions to highlight in NLog mode.")

;; Define and initialize global variable for syntax highlighting
(defvar nlog-mode-syntax-table nil
  "Syntax table used in nlog-mode buffers.")
(or nlog-mode-syntax-table
    (setq nlog-mode-syntax-table
	   (funcall (c-lang-const c-make-mode-syntax-table nlog))))

(defvar nlog-mode-abbrev-table nil
  "Abbreviation table used in nlog-mode buffers.")
(c-define-abbrev-table 'nlog-mode-abbrev-table
  ;; Keywords that if they occur first on a line might alter the
  ;; syntactic context, and which therefore should trig reindentation
  ;; when they are completed.
  nil)
  ; '(("else" "else" c-electric-continued-statement 0)
  ;   ("while" "while" c-electric-continued-statement 0)
  ;   ("catch" "catch" c-electric-continued-statement 0)
  ;   ("finally" "finally" c-electric-continued-statement 0)))

(defvar nlog-mode-map (let ((map (c-make-inherited-keymap)))
		      ;; Add bindings which are only useful for NLog
		      map)
  "Keymap used in nlog-mode buffers.")

;; No idea what this does; just changed the names in template to NLog
(easy-menu-define nlog-menu nlog-mode-map "NLog Mode Commands"
		  ;; Can use `nlog' as the language for `c-mode-menu'
		  ;; since its definition covers any language.  In
		  ;; this case the language is used to adapt to the
		  ;; nonexistence of a cpp pass and thus removing some
		  ;; irrelevant menu alternatives.
		  (cons "NLog" (c-lang-const c-mode-menu nlog)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.n:\\'" . nlog-mode))

;;;###autoload
(defun nlog-mode (&optional x)
  "Major mode for editing NLog code.
This is a derived from CC Mode.

The hook `c-mode-common-hook' is run with no args at mode
initialization, then `nlog-mode-hook'.

Key bindings:
\\{nlog-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (c-initialize-cc-mode t)
  (set-syntax-table nlog-mode-syntax-table)
  (setq major-mode 'nlog-mode)
  (setq mode-name "NLog")
	(setq local-abbrev-table nlog-mode-abbrev-table)
	(setq abbrev-mode t)
  (use-local-map c-mode-map)
  ;; `c-init-language-vars' is a macro that is expanded at compile
  ;; time to a large `setq' with all the language variables and their
  ;; customized values for our language.
  (c-init-language-vars nlog-mode)
  ;; `c-common-init' initializes most of the components of a CC Mode
  ;; buffer, including setup of the mode menu, font-lock, etc.
  ;; There's also a lower level routine `c-basic-common-init' that
  ;; only makes the necessary initialization to get the syntactic
  ;; analysis and similar things working.
  (c-common-init 'nlog-mode)
  (easy-menu-add nlog-menu)
  (run-hooks 'c-mode-common-hook)
  (run-hooks 'nlog-mode-hook)
  (c-update-modeline)
  (message "Finished runing nlog-mode"))

(provide 'nlog-mode)



;;;;;;;;;;;;;;;;;;
;; Bunch of variables that didn't seem to do anything but that cc-fonts.el uses

; ;; Types: a list of strings.
; (c-lang-defconst c-primitive-type-kwds nlog nlog-mode-types)

; ;; Keywords: a list of strings.
; (c-lang-defconst c-constant-kwds nlog nlog-mode-keywords)

; ;; Modifiers, like private and public: a list of strings.
; (c-lang-defconst c-modifier-kwds nlog nlog-mode-structures)

; ;; C preprocessor directives
; (c-lang-defconst c-cpp-matchers
;   nlog (c-lang-const c-cpp-matchers))   ; inherit those from C

; ;; Types preceded by `c-type-prefix-kwds' (e.g. "struct").
; (c-lang-defconst c-type-prefix-kwds nlog nil)

; ;; Something to do with Enums
; (c-lang-defconst c-brace-id-list-kwds nlog nil)

; ;; Labels after goto etc.
; (c-lang-defconst c-before-label-kwds nlog nil)

; ;; Clauses after keywords
; (c-lang-defconst c-type-list-kwds nlog nil)
; (c-lang-defconst c-ref-list-kwds nlog nil)
; (c-lang-defconst c-colon-type-list-kwds nlog nil)

; ;; No idea
; (c-lang-defconst c-paren-type-kwds nlog nil)

;;; nlog-mode.el ends here

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(calendar-week-start-day 1)
 '(doxymacs-blank-multiline-comment-template (quote (> "///" n > "/// " n > "///")))
 '(doxymacs-doxygen-style "C++")
 '(erc-modules (quote (autojoin button completion fill irccontrols keep-place list match menu move-to-prompt netsplit networks noncommands readonly ring stamp spelling track)))
 '(erc-nickserv-identify-mode (quote nick-change))
 '(erc-play-sound nil)
 '(erc-sound-mode t)
 '(erc-try-new-nick-p nil)
 '(gc-cons-threshold 3500000)
 '(image-dired-dir "~/.image-dired/")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(mediawiki-site-alist (quote (("Wikipedia" "http://en.wikipedia.org/w/" "username" "password" "Main Page") ("CGAL" "https://cgal.geometryfactory.com/CGAL/Members/w/" "Pmoeller" "" "Main Page"))))
 '(org-agenda-files (quote ("~/org/notes.org")))
 '(org-archive-location "~/org/archive.org::From %s")
 '(org-capture-templates (quote (("l" "Link" entry (file+headline "~/org/notes.org" "Links") "* TODO %(get-page-title (current-kill 0))" :immediate-finish t) ("t" "Task" entry (file+headline "~/org/notes.org" "Tasks") "* TODO %?
  %u
  %a" :prepend t) ("p" "Paper" entry (file+headline "~/org/notes.org" "Papers") "* %A %^g"))))
 '(org-export-latex-classes (quote (("article" "\\documentclass[12pt]{article}" ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}")) ("report" "\\documentclass[11pt]{report}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("book" "\\documentclass[11pt]{book}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) ("beamer" "\\documentclass{beamer}" org-beamer-sectioning))))
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(org-time-stamp-rounding-minutes (quote (0 15)))
 '(savehist-file "~/.em_hist")
 '(savehist-mode t nil (savehist))
 '(standard-indent 2)
 '(url-max-redirections 30)
 '(yas/prompt-functions (quote (yas/dropdown-prompt yas/ido-prompt yas/completing-prompt))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-hide ((((background dark)) (:foreground "#2b2b2b")))))

;;
;; random unicode that makes typing german a lot more pleasant
;;

(define-key key-translation-map (kbd "M-p o") (kbd "ö"))
(define-key key-translation-map (kbd "M-p O") (kbd "Ö"))
(define-key key-translation-map (kbd "M-p u") (kbd "ü"))
(define-key key-translation-map (kbd "M-p U") (kbd "Ü"))
(define-key key-translation-map (kbd "M-p a") (kbd "ä"))
(define-key key-translation-map (kbd "M-p A") (kbd "Ä"))
(define-key key-translation-map (kbd "M-p s") (kbd "ß"))

;;
;; setup
;;

(add-to-list 'load-path "~/.emacs.d")

(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-to-load-path 
   '("codepad" "keyfreq" "mediawiki" "emacs-color-theme-solarized" "autopair" "expand-region.el" "dired-plus" "magit" "ace-jump-mode")))

(load-file "~/.emacs.d/zenburn/color-theme-zenburn.el")

;; ask briefly
(defalias 'yes-or-no-p 'y-or-n-p)

(server-start)

;; don't make backups. i have version control for a reason.

(setq make-backup-files nil)

;;
;; store bookmarks along with org notes
;;

(setq bookmark-file "~/org/bookmarks.bmk")

;;
;; dired-plus
;; 

(require 'dired+)

;;
;; version-control
;;

(require 'magit)

;;
;; ace-jump-mode
;; 

(require 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode)

;;
;; themes
;;

(require 'color-theme)
(require 'color-theme-zenburn)
(require 'color-theme-solarized)
(color-theme-zenburn)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(hl-line-mode 1)

;;
;; expand-region
;;

(require 'expand-region)
(global-set-key "\C-@" 'er/expand-region)



;; 
;; various modes and keybindings, things that are too small for their
;; own section
;;

(require 'mediawiki)
(require 'grep-edit)
(require 'codepad)
(show-paren-mode 1)
(add-to-list 'auto-mode-alist '("\\.pro$" . make-mode))

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(autoload 'word-count-mode "word-count"
  "Minor mode to count words." t nil)

(require 'autopair)
(autopair-global-mode 1)
(add-hook 'latex-mode-hook
          #'(lambda ()
              (set (make-local-variable 'autopair-handle-action-fns)
                   (list #'autopair-default-handle-action
                         #'autopair-latex-mode-paired-delimiter-action))))

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key [f6] 'recompile)
(global-set-key [f5] 'gnus)


;;
;; ido
;;

(ido-mode 1)


;;
;; gnus
;; 

(setq gnus-init-file "~/.emacs.d/gnus/gnus.el"
      gnus-save-newsrc-file nil
      gnus-read-newsrc-file nil
      gnus-directory "~/News/"
      message-directory "~/Mail/"
      gnus-startup-file "~/newsrc"
      gnus-use-dribble-file nil
      ;; speed killer
      gnus-fetch-old-headers nil
      gnus-agent nil
      nnimap-inbox "INBOX"
      gnus-use-full-window nil)
(setq gnus-posting-styles
      '(("gmail" 
         (name "Philipp Moeller")
         (address "bootsarehax@gmail.com") 
         ("X-SMTP-Server" "bootsarehax@gmail.com:smtp.gmail.com:587")
         (signature "Philipp"))
        ("geometry" 
         (name "Philipp Moeller")
         (address "philipp.moeller@geometryfactory.com") 
         (organization "GeometryFactory")
         ("X-SMTP-Server" "philipp.moeller@geometryfactory.com:ssl0.ovh.net:587")
         (signature "Philipp Moeller\nGeometryFactory"))
        ))

(setq nnmail-split-methods 
      '(("cgal-develop"          "^Subject:.*\\[cgal-develop\\]")
        ("cgal-discuss"          "^Subject:.*\\[cgal-discuss\\]")
        ("cgal-bindings-discuss" "^Subject:.*\\[cgal-bindings-discuss\\]")
        ("couchsurfing"          "^From:.*CouchSurfing")
        ("bbdb"                  "^To:.*bbdb-info@lists.sourceforge.net")
        ("osg-users"             "^Subject:.*\\[osg-users\\]")
        ("boost"                 "^To:.*boost*@lists.boost.org")
        ("gsoc" "^Subject:.*\\[GSoC Mentors\\]")
        ))
(setq nnimap-split-methods 
      '(("cgal-develop"          "^Subject:.*\\[cgal-develop\\]")
        ("cgal-discuss"          "^Subject:.*\\[cgal-discuss\\]")
        ("cgal-bindings-discuss" "^Subject:.*\\[cgal-bindings-discuss\\]")
        ("couchsurfing"          "^From:.*CouchSurfing")
        ("bbdb"                  "^To:.*bbdb-info@lists.sourceforge.net")
        ("osg-users"             "^Subject:.*\\[osg-users\\]")
        ("boost"                 "^To:.*boost.*@lists.boost.org")
        ("gsoc" "^Subject:.*\\[GSoC Mentors\\]")
        ))

;;
;; smtp mail configuration
;;

(eval-after-load "smtpmail"
  '(progn
     (defun smtpmail-get-and-delete-smtp-server-from-header ()
       "Find header field X-SMTP-Server and if found return value as
         string and delete header field. If a header field of this
         name doesn't exist, return nil."
       (save-excursion
         (goto-char (point-min))
         (save-match-data
           (let ((smtp-server))
             (loop until (or (eobp) (looking-at "^[ \t]*$"))
                   if (looking-at "X-SMTP-Server[ \t]*:[ \t]*\\(.*?\\)[ \t]*\n")
                   return (prog1 (match-string 1) (replace-match ""))
                   else
                   do (forward-line 1))))))
     
     (defadvice smtpmail-via-smtp (around set-smtp-server-from-header activate)
       (let* ((server-pattern (split-string (or (smtpmail-get-and-delete-smtp-server-from-header)
                          smtpmail-smtp-server) ":"))
              (auth-cred (car server-pattern))
              (server (car (cdr server-pattern)))
              (port (car (cdr (cdr server-pattern))))
              )
         (setq smtpmail-starttls-credentials (list (list server port nil nil))
               smtpmail-auth-credentials (list (list server port auth-cred nil))
               smtpmail-smtp-server server
               smtpmail-smtp-service port)
         ad-do-it
         ))))

(require 'smtpmail)
(require 'starttls)



(setq smtpmail-debug-info t
      smtpmail-debug-verb t)
(setq message-send-mail-function 'smtpmail-send-it)

;;
;; erc
;;

(require 'erc)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-kill-buffer-on-part t)
(setq erc-kill-server-buffer-on-quit t)

(setq erc-auto-query 'buffer)

(defun x-urgency-hint (frame arg &optional source)
  (let* ((wm-hints (append (x-window-property 
			    "WM_HINTS" frame "WM_HINTS" 
			    (if source
				source
			      (string-to-number 
			       (frame-parameter frame 'outer-window-id)))
			    nil t) nil))
	 (flags (car wm-hints)))
    (setcar wm-hints
	    (if arg
		(logior flags #x00000100)
	      (logand flags #xFFFFFEFF)))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p) 
      (x-urgency-hint (selected-frame) t)
    ;;(setq ad-return-value (intern "erc-current-nick-face")))
    ad-do-it))

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#archlinux" "#haskell" "#xmonad" "##c++")))

(defun irc-start ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "bo0ts__")
  (erc :server "localhost" :port 6667 :nick "boots")
  )

;;
;; latex/auctex
;; 

(setq TeX-auto-save nil)
(setq TeX-parse-self t)
(setq require-final-newline nil)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(add-hook 'TeX-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "pdflatex -interaction nonstopmode -file-line-error "
                         (buffer-name)))))

;;
;; haskell-related
;;

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

;;
;; c++
;;

(require 'doxymacs)

(setq c-default-style "stroustrup"
      c-basic-offset 2)
(c-set-offset 'innamespace 0)
(c-set-offset 'inline-open 0)

(defun cplusplus-query (search-string)
  "Search for SEARCH-STRING on cplusplus.com"
  (interactive "sSearch for: ")
  (browse-url (concat "http://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search="
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(defun sgi-query (search-string)
  "Search for SEARCH-STRING in http://www.sgi.com/tech/stl/ "
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.google.com/search?q=site:http://www.sgi.com/tech/stl/+"
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(add-hook 'c++-mode-hook 'subword-mode)
(add-hook 'c++-mode-hook 'doxymacs-mode)

(add-to-list 'auto-mode-alist '("\\.glsl$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;;
;; cmake-mode
;;

(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))


;; 
;; yasnippets
;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/yas")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/snippets/")
(yas/load-directory yas/root-directory)

;;
;; org-mode
;;

(require 'org-install)
(require 'org-protocol)
(require 'org-publish)
(require 'org-exp-bibtex)

(require 'french-holidays)
(setq calendar-holidays holiday-french-holidays)

(setq org-publish-project-alist
      '(
        ("web" :components ("blog" "static"))
        ("blog"
         :base-directory "~/web/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :html-preamble nil
         :html-postamble "<h2>Philipp's braindump</h2>Entirely experimental and subject to change"
         :publishing-function org-publish-org-to-html
         )
        ;; static files like images  and static html as well
        ("static"
         :base-directory "~/web/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|html"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ))

(setq org-log-done t)
(setq org-hide-leading-stars t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'auto-fill-mode)

(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-agenda-custom-commands '(("h" "Daily habits" ((agenda ""))
                                    ((org-agenda-show-log t) (org-agenda-ndays 7)
                                     (org-agenda-log-mode-items '(state))
                                     (org-agenda-skip-function '(org-agenda-skip-entry-if
                                                                 'notregexp ":DAILY:"))
                                     ))
                                   ("d" "Weekly CGAL report" 
                                    ((agenda "" ((org-agenda-span 'week)
                                                 (org-agenda-show-log t)
                                                 (org-agenda-filter-preset '("+cgal"))
                                                 (org-agenda-log-mode-items '(closed))))
                                     ))
                                   ))
(defun get-page-title (url)
  "Try to get the title of the html page given by url. This is seriously broken. setq etc."
  (interactive)
  (with-current-buffer (url-retrieve-synchronously url)
    (goto-char 0)
    (re-search-forward "<title>\\([^<]*\\)</title>" nil t 1)
    (setq web_title_str (match-string 1))
    (goto-char 0)

    (if (re-search-forward "charset=\\([-0-9a-zA-Z]*\\)" nil t 1)
        (setq coding_charset (downcase (match-string 1)))
      (setq coding_charset "utf-8")
    (setq web_title_str (decode-coding-string web_title_str (intern
                                                             coding_charset)))
    )
  (concat "[[" url "][" web_title_str "]]")
  ))

;;
;; bbdb
;;

(require 'bbdb-loaddefs)
(require 'bbdb-gnus)
(bbdb-initialize 'gnus 'message)
(bbdb-insinuate-message)
(setq bbdb-file "~/org/bbdb")
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

;;
;; ispell dictionaries and flyspell
;;

;; all text-modes
(add-hook 'text-mode-hook (lambda ()  (flyspell-mode 1)))

;; assorted prog modes
(add-hook 'c++-mode-hook 'flyspell-prog-mode)
(add-hook 'lisp-mode-hook 'flyspell-prog-mode)
(add-hook 'c-mode-hook 'flyspell-prog-mode)

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)

(setq skeleton-pair nil)

;;
;; emacs disabled
;;

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(calendar-week-start-day 1)
 '(custom-safe-themes (quote ("bf9d5728e674bde6a112979bd830cc90327850aaaf2e6f3cc4654f077146b406" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(doxymacs-doxygen-style "JavaDoc")
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
 '(package-user-dir "~/elpa")
 '(savehist-file "~/.em_hist")
 '(savehist-mode t nil (savehist))
 '(standard-indent 2)
 '(url-max-redirections 30))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-subscript-face ((t nil)) t)
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
;; packages
;;

(require 'package)

;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)
(require 'cl)

(defvar my-packages
  '(autopair dired+ expand-region haskell-mode keyfreq zenburn-theme magit))

;; (defun my-packages-installed-p ()
;;   (loop for p in my-packages
;;         do (message "%s %s" (package-installed-p p) p)))
;; (package-installed-p 'keyfreq)

;; (defun my-install-packages ()
;;   (unless (my-packages-installed-p)
;;     ;; check for new packages (package versions)
;;     (message "%s" "Refreshing package database...")
;;     (package-refresh-contents)
;;     (message "%s" " done.")
;;     ;; install the missing packages
;;     (dolist (p my-packages)
;;       (unless (package-installed-p p)
;;         (package-install p)))))

;;
;; setup
;;

(add-to-list 'load-path "~/.emacs.d")

(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-to-load-path 
   '("codepad" "mediawiki")))

(setq user-mail-address "philipp.moeller@geometryfactory.com")

;; ask briefly
(defalias 'yes-or-no-p 'y-or-n-p)

(server-start)

;; don't make backups. i have version control for a reason.
(setq make-backup-files nil)

;;
;; theming
;;

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(fringe-mode 0)
(load-theme 'zenburn)
(global-hl-line-mode 1)


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
(global-set-key "\M-\C-g" 'magit-status)

(require 'gist)
(setq gist-view-gist t)

;;
;; ibuffer
;;

(global-set-key "\C-x\C-b" 'ibuffer)

;;
;; footnote
;;

(setq footnote-spaced-footnotes nil)

;;
;; markdown-mode
;; 

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.text" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.txt" . markdown-mode) auto-mode-alist))

;; Hacky, but solid for ArchLinux.
(setq markdown-command "perl /usr/bin/vendor_perl/Markdown.pl")


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

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

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
      gnus-fetch-old-headers t
      gnus-agent nil
      nnimap-inbox "INBOX"
      gnus-use-full-window nil)

(add-hook 'message-mode-hook 'footnote-mode)
(setq gnus-posting-styles
           '((".*geometry.*"
              (name "Philipp Moeller")
              (signature "Philipp Moeller \nGeometryFactory")
              ;; (x-face-file "~/.xface")
              (x-url "www.geometryfactory.com")
              (organization "GeometryFactory")
              (From "Philipp Moeller <philipp.moeller@geometryfactory.com>")
              )
             (".*gmail.*"
              (name "Philipp Moeller")
              (signature "Philipp")
              (From "Philipp Moeller <bootsarehax@gmail.com>")
              )))


(setq nnmail-split-methods 
      '(("cgal-develop"          "^Subject:.*\\[cgal-develop\\]")
        ("cgal-discuss"          "^Subject:.*\\[cgal-discuss\\]")
        ("cgal-bindings-discuss" "^Subject:.*\\[cgal-bindings-discuss\\]")
        ("couchsurfing"          "^From:.*CouchSurfing")
        ("bbdb"                  "^To:.*bbdb-info@lists.sourceforge.net")
        ("bbdb"                  "^Cc:.*bbdb-info@lists.sourceforge.net")
        ("osg-users"             "^Subject:.*\\[osg-users\\]")
        ("boost"                 "^To:.*boost.*@lists.boost.org")
        ("gsoc"                  "^Subject:.*\\[GSoC Mentors\\]")
        ("gsoc"                  "^Subject:.*\\[gsoc-cgal\\]")
        ("cgal-commits"          "^From:.*cgal-commits-request")
        ("[Google Mail]/Bin"     "^From:.*eBay.*")
        ))
(setq nnimap-split-methods nnmail-split-methods)

(require 'smtpmail)
(require 'starttls)

(defun smtp-select-server ()
  (setq send-from (message-fetch-field "from"))
  (message "Sending from %s" send-from)
  (cond 
   ((equal send-from "Philipp Moeller <bootsarehax@gmail.com>")
    (setq smtpmail-smtp-server "smtp.gmail.com"
          smtpmail-smtp-service 587
          smtpmail-smtp-user "bootsarehax@gmail.com")
    )
   ((equal send-from "Philipp Moeller <philipp.moeller@geometryfactory.com>")
    (setq smtpmail-smtp-server "ssl0.ovh.net")
    (setq smtpmail-smtp-service 587)
    (setq smtpmail-smtp-user "philipp.moeller@geometryfactory.com")
    )
   (t
    (error "No such server known"))
   )
  (smtpmail-send-it))

(setq send-mail-function 'smtp-select-server)
(setq message-send-mail-function 'smtp-select-server)

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

(require 'yasnippet) ;; not yasnippet-bundle
(yas/global-mode 1)
(setq yas/snippet-dirs "~/.emacs.d/snippets/")

(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/completing-prompt))



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
         :exclude "\\(drafts\\|blog_export\\)\\.org"
         :recursive t
         :publishing-directory "~/public_html/"
         :html-preamble nil
         :html-postamble nil
         :auto-sitemap t
         ;; :sitemap-sort-files "anti-chronologically"
         :sitemap-filename "sitemap.org"
         :sitemap-title "Sitemap"
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
(setq bbdb-file "~/org/bbdb"
      bbdb-complete-mail-allow-cycling t)

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
(put 'narrow-to-region 'disabled nil)

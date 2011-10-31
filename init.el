(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(calendar-week-start-day 1)
 '(erc-modules (quote (autojoin button completion fill irccontrols keep-place list match menu move-to-prompt netsplit networks noncommands readonly ring stamp spelling track)))
 '(erc-nickserv-identify-mode (quote nick-change))
 '(erc-play-sound nil)
 '(erc-sound-mode t)
 '(erc-try-new-nick-p nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(mediawiki-site-alist (quote (("Wikipedia" "http://en.wikipedia.org/w/" "username" "password" "Main Page") ("CGAL" "https://cgal.geometryfactory.com/CGAL/Members/w/" "Pmoeller" "" "Main Page"))))
 '(org-agenda-files (quote ("~/everything/org/notes.org")))
 '(org-archive-location "~/everything/org/archive.org::From %s")
 '(org-capture-templates (quote (("l" "Link" entry (file+headline "~/everything/org/notes.org" "Links") "* TODO %(get-page-title (current-kill 0))" :immediate-finish t) ("t" "Task" entry (file+headline "~/everything/org/notes.org" "Tasks") "* TODO %?
  %u
  %a" :prepend t))))
 '(org-export-latex-classes (quote 
                             (("article" "\\documentclass[12pt]{article}" 
                               ("\\section{%s}" . "\\section*{%s}") 
                               ("\\subsection{%s}" . "\\subsection*{%s}") 
                               ("\\subsubsection{%s}" . "\\subsubsection*{%s}") 
                               ("\\paragraph{%s}" . "\\paragraph*{%s}") 
                               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                              ("report" "\\documentclass[11pt]{report}" 
                               ("\\part{%s}" . "\\part*{%s}") 
                               ("\\chapter{%s}" . "\\chapter*{%s}") 
                               ("\\section{%s}" . "\\section*{%s}") 
                               ("\\subsection{%s}" . "\\subsection*{%s}") 
                               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) 
                              ("book" "\\documentclass[11pt]{book}" 
                               ("\\part{%s}" . "\\part*{%s}") 
                               ("\\chapter{%s}" . "\\chapter*{%s}") 
                               ("\\section{%s}" . "\\section*{%s}") 
                               ("\\subsection{%s}" . "\\subsection*{%s}") 
                               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")) 
                              ("beamer" "\\documentclass{beamer}" org-beamer-sectioning))))
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(org-time-stamp-rounding-minutes (quote (0 15)))
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
;; setup
;;

(add-to-list 'load-path "/home/boots/.emacs.d")

(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-to-load-path 
   '("codepad" "keyfreq" "mediawiki" "emacs-color-theme-solarized")))

(load-file "~/.emacs.d/zenburn/color-theme-zenburn.el")

(server-start)

(require 'grep-edit)
(require 'codepad)
(require 'color-theme)
(require 'color-theme-zenburn)
(require 'color-theme-solarized)
(color-theme-zenburn)

(set-fringe-mode 0)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key [f6] 'recompile)

(require 'mediawiki)

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(autoload 'word-count-mode "word-count"
  "Minor mode to count words." t nil)

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

(add-hook 'TeX-mode-hook 'flyspell-mode)


;;
;; haskell-related
;;

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)


;; c++
;;

(setq c-default-style "stroustrup"
      c-basic-offset 2)

(defun cplusplus-query (search-string)
  "Search for SEARCH-STRING on cplusplus.com"
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.cplusplus.com/search.do?q="
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(defun sgi-query (search-string)
  "Search for SEARCH-STRING in http://www.sgi.com/tech/stl/ "
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.google.com/search?q=site:http://www.sgi.com/tech/stl/+"
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(add-to-list 'auto-mode-alist '("\\.glsl$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(add-hook 'c++-mode-hook 'flyspell-prog-mode)

;; 
;; yasnippets
;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp/yas")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;;
;;org-mode related
;;

(require 'org-install)
(require 'org-protocol)
(require 'org-publish)
(require 'org-exp-bibtex)

(setq org-publish-project-alist
      '(
        ("ba" :components ("ba-html" "ba-pdf" "ba-static"))
        ("ba-pdf"
         :base-directory "~/everything/ba/"
         :base-extension "org"
         :publishing-directory "~/public_html/ba/"
         :publishing-function org-publish-org-to-pdf
         )
        ("ba-html"
         :base-directory "~/everything/ba/"
         :base-extension "org"
         :publishing-directory "~/public_html/ba/"
         :publishing-function org-publish-org-to-html
         )
        ("ba-static"
         :base-directory "~/everything/ba/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|swf\\|html"
         :publishing-directory "~/public_html/ba/"
         :publishing-function org-publish-attachment
         :recursive t
         )
        ("web" :components ("blog" "static"))
        ("blog"
         :base-directory "~/everything/web/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :html-preamble nil
         :html-postamble "<h2>Philipp's braindump</h2>Entirely experimental and subject to change"
         :publishing-function org-publish-org-to-html
         )
        ;; static files like images  and static html as well
        ("static"
         :base-directory "~/everything/web/"
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
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)

(setq org-directory "~/everything/org")
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
  "Get title of web page, whose url can be found in the current line"
  ;; Get title of web page, with the help of functions in url.el
  (interactive)
  (with-current-buffer (url-retrieve-synchronously url)
    ;; find title by grep the html code
    (goto-char 0)
    (re-search-forward "<title>\\([^<]*\\)</title>" nil t 1)
    (setq web_title_str (match-string 1))
    ;; find charset by grep the html code
    (goto-char 0)

    ;; find the charset, assume utf-8 otherwise
    (if (re-search-forward "charset=\\([-0-9a-zA-Z]*\\)" nil t 1)
        (setq coding_charset (downcase (match-string 1)))
      (setq coding_charset "utf-8")
    ;; decode the string of title.
    (setq web_title_str (decode-coding-string web_title_str (intern
                                                             coding_charset)))
    )
  (concat "[[" url "][" web_title_str "]]")
  ))

;;
;; ispell dictionaries
;;

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)

;;
;; skeletons and paren balancing
;;

(setq skeleton-pair t)

(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "<" 'skeleton-pair-insert-maybe)

;;
;; emacs disabled
;;

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

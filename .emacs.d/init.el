;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; init.el file ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq gc-cons-threshold 100000000)

(let ((file-name-handler-alist nil))
  (require 'package) 
  (setq package-enable-at-startup nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- START -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)

;(require 'package)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(when (fboundp 'winner-mode)
  (winner-mode 1))
  
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package fzf :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Eshell -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Eshell C-l support
(defun eshell-clear-buffer ()
    "Clear terminal"
    (interactive)
    (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

 (add-hook 'eshell-mode-hook
 '(lambda()
 (local-set-key (kbd
		 "C-l") 'eshell-clear-buffer)))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Focus -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package focus :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- ido --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;; M-x configurations
;(global-set-key
;     "\M-x"
;     (lambda ()
;       (interactive)
;       (call-interactively
;        (intern
;         (ido-completing-read
;          "M-x "
;          (all-completions "" obarray 'commandp))))))
;
;;;; ido color customization

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-incomplete-regexp ((t (:foreground "#0000FF"))))
 '(ido-only-match ((t (:background "#008000")))))
 ;; Ido face for indicating incomplete regexps. (don't use this either)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- ivy/swiper/counsel --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
  :map ivy-minibuffer-map
  ("M-y" . ivy-next-line)))

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper-isearch)
  ("C-r" . swiper-isearch)
  ("C-c C-r" . ivy-resume)
  ("M-x" . counsel-M-x)
	   ;;("C-x C-f" . counsel-find-file)
  )
  :config
  (progn
      (ivy-mode 1)
      (setq ivy-use-virtual-buffers t)
      (setq ivy-display-style 'fancy)
      (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-word-1)) ;; changed from char as per jcs

(use-package ivy-rich
  :ensure t
  :config
  (ivy-rich-mode 1))

(use-package smex :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- elfeed -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq elfeed-db-directory "~/Dropbox/Apps/elfeed/elfeeddb")

(defun mz/elfeed-browse-url (&optional use-generic-p)
    "Visit the current entry in your browser using `browse-url'.
    If there is a prefix argument, visit the current entry in the
    browser defined by `browse-url-generic-program'."
    (interactive "P")
    (let ((entries (elfeed-search-selected)))
      (cl-loop for entry in entries
	       do (if use-generic-p
		      (browse-url-generic (elfeed-entry-link entry))
		    (browse-url (elfeed-entry-link entry))))
      (mapc #'elfeed-search-update-entry entries)
      (unless (or elfeed-search-remain-on-entry (use-region-p))
      ;;(forward-line)
)))

(defun elfeed-mark-all-as-read ()
      (interactive)
      (mark-whole-buffer)
      (elfeed-search-untag-all-unread))

;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
    "Wrapper to load the elfeed db from disk before opening"
    (interactive)
    (elfeed-db-load)
    (elfeed)
    (elfeed-search-update--force))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
    "Wrapper to save the elfeed db to disk before burying buffer"
    (interactive)
    (elfeed-db-save)
    (quit-window))

(use-package elfeed
  :ensure t
  :bind (:map elfeed-search-mode-map
	      )
  :config
  (defalias 'elfeed-toggle-star
	(elfeed-expose #'elfeed-search-toggle-all 'star))
  (global-set-key (kbd "C-x w") 'elfeed))

; cause error!!!
;(use-package elfeed-goodies
;    :ensure t
;    :config
;    (elfeed-goodies/setup))

(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/Dropbox/Apps/elfeed/elfeed.org")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- MISC --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Highlights the current cursor line
;(global-hl-line-mode t)
  
;flashes the cursor's line when you scroll
;(use-package beacon :ensure t)

  
;deletes all the whitespace when you hit backspace or delete
;(use-package hungry-delete
;    :ensure t
;    :config
;    (global-hungry-delete-mode))

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  ;(global-set-key (kbd "C->") 'mc/mark-next-like-this)
  ;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  ;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
)

; expand the marked region in semantic increments (negative prefix to reduce region)
(use-package expand-region
  :ensure t
  :config 
  (global-set-key (kbd "C-=") 'er/expand-region))

(setq save-interprogram-paste-before-kill t)

;;(use-package aggressive-indent
;;:ensure t
;;:config
;;(global-aggressive-indent-mode 1)
;;;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
;;)

;;(defun z/swap-windows ()
;;""
;;(interactive)
;;(ace-swap-window)
;;(aw-flip-window)
;;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- eshell --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Iedit --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;mark and edit all copies of the marked region simultaniously. 
(use-package iedit :ensure t)

;if you're windened, narrow to the region, if you're narrowed, widen
;bound to C-x n
(defun narrow-or-widen-dwim (p)
    "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
    Intelligently means: region, org-src-block, org-subtree, or defun,
    whichever applies first.
    Narrowing to org-src-block actually calls `org-edit-src-code'.

    With prefix P, don't widen, just narrow even if buffer is already
    narrowed."
    (interactive "P")
    (declare (interactive-only))
    (cond ((and (buffer-narrowed-p) (not p)) (widen))
    ((region-active-p)
    (narrow-to-region (region-beginning) (region-end)))
    ((derived-mode-p 'org-mode)
    ;; `org-edit-src-code' is not a real narrowing command.
    ;; Remove this first conditional if you don't want it.
    (cond ((ignore-errors (org-edit-src-code))
    (delete-other-windows))
    ((org-at-block-p)
    (org-narrow-to-block))
    (t (org-narrow-to-subtree))))
    (t (narrow-to-defun))))

;(define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;This line actually replaces Emacs' entire narrowing keymap, that's
;how much I like this command. Only copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- theme --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package monokai-theme  :ensure t)
(use-package doom-themes :ensure t)
 
;;  ;; Global settings (defaults)
;;  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;        doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
;;(doom-themes-visual-bell-config)
  
;; Enable custom neotree theme (all-the-icons must be installed!)
;;(doom-themes-neotree-config)
;; or for treemacs users
;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;(doom-themes-treemacs-config)
  
;; Corrects (and improves) org-mode's native fontification.
;;(doom-themes-org-config)

(use-package vi-tilde-fringe
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'vi-tilde-fringe-mode)
  (add-hook 'LaTeX-mode-hook 'vi-tilde-fringe-mode)
  ;(add-hook 'matlab-mode-hook 'vi-tilde-fringe-mode)
)

; divide line
(set-face-background 'vertical-border "#898989")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Flycheck --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
   ;; Custom fringe indicator
	(define-fringe-bitmap 'my-flycheck-fringe-indicator
	  (vector #b00000000
		  #b00000000
		  #b00000000
		  #b00000000
		  #b00000000
		  #b00000000
		  #b00000000
		  #b00011100
		  #b00111110
		  #b00111110
		  #b00111110
		  #b00011100
		  #b00000000
		  #b00000000
		  #b00000000
		  #b00000000
		  #b00000000))

	(flycheck-define-error-level 'error
	  :severity 2
	  :overlay-category 'flycheck-error-overlay
	  :fringe-bitmap 'my-flycheck-fringe-indicator
	  :fringe-face 'flycheck-fringe-error)
	(flycheck-define-error-level 'warning
	  :severity 1
	  :overlay-category 'flycheck-warning-overlay
	  :fringe-bitmap 'my-flycheck-fringe-indicator
	  :fringe-face 'flycheck-fringe-warning)
	(flycheck-define-error-level 'info
	  :severity 0
	  :overlay-category 'flycheck-info-overlay
	  :fringe-bitmap 'my-flycheck-fringe-indicator
	  :fringe-face 'flycheck-fringe-info)
)

;; Underline customization
(custom-set-faces
     '(flycheck-error ((t (:underline (:color "#F92672")))))
     '(flycheck-warning ((t (:underline ( :color "#FD971F")))))
     '(flycheck-info ((t (:underline ( :color "#66D9EF"))))))

;(use-package flycheck-pos-tip
;    :ensure t
;    :config
;    (with-eval-after-load 'flycheck
;    (flycheck-pos-tip-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- company-mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Toggle company-mode and auto-complete-mode use <M-x company-mode/auto-complete-mode>
;;in mini-buffer
(use-package company
  :ensure t
  :pin melpa
  :config
  (progn
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (add-hook 'after-init-hook 'global-company-mode)
    ;;(setq company-show-doc-buffer nil)
    (setq company-minimum-prefix-length 3)
    (setq company-idle-delay 0.0)
    (setq ess-use-company 'script-only))

    ;; English Auto-Complete using company
    (add-hook 'after-init-hook 'global-company-mode)

    (defun text-mode-hook-setup ()
    ;; make `company-backends' local is critcal
    ;; or else, you will have completion in every major mode, that's very annoying!
    (make-local-variable 'company-backends)
    ;; company-ispell is the plugin to complete words
    (add-to-list 'company-backends 'company-ispell))

    (add-hook 'text-mode-hook 'text-mode-hook-setup)

    (defun toggle-company-ispell ()
         (interactive)
         (cond
	 ((memq 'company-ispell company-backends)
	 (setq company-backends (delete 'company-ispell company-backends))
	 (message "company-ispell disabled"))
	 (t
	 (add-to-list 'company-backends 'company-ispell)
	 (message "company-ispell enabled!"))))
   )

;;Standard Jedi.el setting --- After instalation, M-x jedi:install-server

;(use-package company-box
;    :ensure t
;    :hook (company-mode . company-box-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- lsp-mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 ;(python-mode . lsp)
	 ;(r-mode . lsp)
	 ;(c++-mode . lsp)
	 ;(latex-mode . lsp)
	 ;;if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;;optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
;(setq lsp-completion-provider company-capf)
;;if you are helm user
;(use-package helm-lsp :ensure t :commands helm-lsp-workspace-symbol)
;;if you are ivy user
(use-package lsp-ivy :ensure t :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)

;;optionally if you want to use debugger
(use-package dap-mode :ensure t)
;;(use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- python -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Important add directory to path - it is used for ein package
(setenv "PATH" (concat (getenv "PATH") ":~/Software/anaconda3/bin/"))
(setq exec-path (append exec-path '("~/Software/anaconda3/bin/")))

;(setq python-python-command "~/Software/anaconda3/envs/neuro001/bin/python")
(setenv "WORKON_HOME" "~/Software/anaconda3/envs")
;;(setq python-shell-interpreter "~/Software/anaconda3/envs/neuro001/bin/python")
;(setq elpy-rpc-python-command "~/Software/anaconda3/envs/neuro001/bin/python")

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

;(venv-workon "neuro001")
;(setq lsp-python-executable-cmd "~/Software/anaconda3/envs/neuro001/bin/python")

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Julia -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package julia-mode :ensure t)

;(use-package julia-repl
;    :ensure t
;    :config
;    (add-hook 'julia-mode-hook 'julia-repl-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- matlab --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package matlab
  :ensure matlab-mode
  :config
  (progn
  (add-to-list
   'auto-mode-alist
   '("\\.m\\'" . matlab-mode))
  (setq matlab-indent-function t)
  (setq matlab-shell-command "matlab")
  (add-hook 'matlab-mode-hook 'vi-tilde-fringe-mode)
  ;(add-hook 'matlab-mode-hook 'auto-complete-mode)
  (matlab-cedet-setup)
  )
)

;; Firs time install: (use-package matlab-mode :ensure: t ....) then change to above 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- ess --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ess
  :ensure t
  :config
  ;(require 'ess-site)
  (setq ess-use-auto-complete t)
  (setq inferior-ess-r-program "/usr/bin/R")
  (setq inferior-julia-program-name "/usr/bin/julia"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- AUCTEX --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package auctex
  :defer t
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
  (setq reftex-plug-into-AUCTeX t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- gnuplot -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package: gnuplot
;; these lines enable the use of gnuplot mode
(use-package gnuplot
  :ensure t
  :config
  (progn
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

  ;; this line automatically causes all files with the .gp extension to be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Jupyter (EIN) -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package: gnuplot
;; these lines enable the use of gnuplot mode
(use-package ein
  :ensure t
  :config
  (setq ein:output-area-inlined-images t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Markdown --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- org-mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(use-package org 
  :ensure t
  :pin org)

(use-package htmlize :ensure t)

;;MY PROJECT -*- mode: org -*- 
;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/Apps/MobileOrg/todo.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-files '("~/Dropbox/org"))

(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;;Image Display

(setq org-image-actual-width nil)
;;(plist-put org-format-latex-options :scale 2.0)

(setq org-publish-project-alist
           '(("org"
              :base-directory "~Dropbox/Apps/MobileOrg/"
              :publishing-directory "~/public_html"
              :publishing-function org-html-publish-to-html
              :section-numbers nil
              :with-toc nil
              :html-head "<link rel=\"stylesheet\"
                         href=\"../other/mystyle.css\"
                         type=\"text/css\"/>")))

(setq org-highlight-latex-and-related '(latex))

(setq org-agenda-files (list "~/Dropbox/org/task.org"
			     "~/Dropbox/org/neuro001.org"
                             "~/Dropbox/org/covid-19.org" 
                             "~/Dropbox/org/bio001.org"))

(use-package ob-ipython :ensure t)

(setq org-confirm-babel-evaluate nil)                            
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (R . t)
   (shell . t)
   (python . t)
   (ipython . t)
   (gnuplot . t)
   (ein . t)
   (latex . t)
   ))

;; inline images
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; company
(defun add-pcomplete-to-capf ()
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))

(add-hook 'org-mode-hook #'add-pcomplete-to-capf)

(use-package org-bullets
  :ensure t
  :config 
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package cdlatex
  :ensure t
  :config
  (defun krofna-hack ()
  (when (looking-back (rx "$ "))
    (save-excursion
      (backward-char 1)
      (org-toggle-latex-fragment))))

  (add-hook 'org-mode-hook
          (lambda ()
          (org-cdlatex-mode)
          (add-hook 'post-self-insert-hook #'krofna-hack 'append 'local)))
)

;; Linewrap | (org-fill-paragraph)

(setq-default fill-column 120)
(define-key org-mode-map  "\M-q" 'toggle-truncate-lines)

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region ()
  (interactive)
   (let ((fill-column (point-max)))
     (fill-region  (region-beginning) (region-end) nil)))

(define-key org-mode-map (kbd "C-c f p") 'fill-paragraph)
(define-key org-mode-map (kbd "C-c u p") 'unfill-paragraph)

(define-key org-mode-map (kbd "C-c f r") 'fill-region)
(define-key org-mode-map (kbd "C-c u r") 'unfill-region)

;; highlighing
(setq org-hide-emphasis-markers t)

(setq org-emphasis-alist
      (quote (
       ("*" bold)
       ("/" italic)
       ("_" underline)
       ("=" (:background "yellow" :foreground "black"))
					; ("~" org-verbatim verbatim)
       ("~" (:background "sky blue" :foreground "black"))
       ("+" (:strike-through t))
       )))

;; Shortcuts
;; <C-c C-,>

(use-package olivetti
  :ensure t
  :config
  (defun olivetti/org-mode ()
      "Custom Configuration for org-mode"
      (olivetti-mode)
      (olivetti-set-width 120))

      (add-hook 'org-mode-hook 'olivetti/org-mode))

;(defun my-set-margins ()
;  "Set margins in current buffer."
;  (setq left-margin-width 30)
;  (setq right-margin-width 2))
;
;(add-hook 'org-mode-hook 'my-set-margins)

(add-hook 'org-mode-hook
      '(lambda ()
         (delete '("\\.pdf\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))))

;(use-package org-journal
;  :ensure t
;  :defer t
;  :init
;  ;; Change default prefix key; needs to be set before loading org-journal
;  (setq org-journal-prefix-key "C-c j ")
;  :config
;  (setq org-journal-dir "~/Dropbox/org/journal/"
;        org-journal-date-format "%A, %d %B %Y"))
;
;(use-package deft
;  :bind ("<f8>" . deft)
;  :commands (deft)
;  :config (setq deft-directory "~/Dropbox/org/Notes/"
;                deft-extensions '("md" "org")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Bibliography -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my/bib-file-location "~/Dropbox/bibliography/ref/references.bib"
  "Where I keep my bib file.")

(use-package org-ref
  :ensure t
  :config
	(setq reftex-default-bibliography '("~/Dropbox/bibliography/ref/references.bib"))

	;; see org-ref for use of these variables
	(setq org-ref-bibliography-notes "~/Dropbox/bibliography/ref/notes.org"
	      org-ref-default-bibliography '("~/Dropbox/bibliography/ref/references.bib")
	      org-ref-pdf-directory "~/Dropbox/bibliography/ref/bibtex-pdfs/")
	)

(use-package helm-bibtex
  :ensure t
  :config
  (autoload 'helm-bibtex "helm-bibtex" "" t)
  (setq bibtex-completion-pdf-symbol "⌘")    ;; pdf is availabe
  (setq bibtex-completion-notes-symbol "✎")  ;; note is availabe 

  (setq bibtex-completion-pdf-field "File")
  (setq bibtex-completion-pdf-extension '(".pdf" ".djvu"))

  (setq bibtex-completion-display-formats
    '((article       . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${journal:40}")
      (inbook        . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
      (incollection  . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
      (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
      (t             . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*}")))
  )

(setq bibtex-completion-bibliography my/bib-file-location)

;; specify the path of the note
(setq bibtex-completion-notes-path "~/Dropbox/bibliography/ref/notes.org")

;; with C-c C-o to open zotera pdf files in org-mode.
(defun my/org-ref-open-pdf-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
	 (pdf-file (car (bibtex-completion-find-pdf key))))
    (if (file-exists-p pdf-file)
	(org-open-file pdf-file)
      (message "No PDF found for %s" key))))

(setq org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Research -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pdf-tools
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  )

;; Org-roam (causes "selceting buffer error")
(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/Dropbox/org/Notes/")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-mode nil
        org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;; If you installed via MELPA
(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
              (("C-c n a" . orb-note-actions))))

(use-package org-noter :ensure t)

(use-package academic-phrases :ensure t)

(use-package ebib :ensure t)

(use-package org-pdftools
  :ensure t
  :hook (org-load . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :ensure t
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Icons and Powerline --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

(use-package all-the-icons :ensure t)

(use-package all-the-icons-ivy
  :ensure t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 3))

;(use-package spaceline
;  :ensure t
;  :config
;  (require 'spaceline-config)
;  (spaceline-emacs-theme)
;  )

(use-package nyan-mode :ensure t)

;;(use-package telephone-line
;; :ensure t
;;  :config
;;  (progn
;;    (telephone-line-mode 1)
;;    (setq telephone-line-lhs
;;      '((evil   . (telephone-line-evil-tag-segment))
;;        (accent . (telephone-line-vc-segment
;;                   telephone-line-erc-modified-channels-segment
;;                   telephone-line-process-segment))
;;       (nil    . (telephone-line-minor-mode-segment
;;                   telephone-line-buffer-segment))))
;;(setq telephone-line-rhs
;;      '((nil    . (telephone-line-misc-info-segment))
;;        (accent . (telephone-line-major-mode-segment))
;;        (evil   . (telephone-line-airline-position-segment)))))
;; )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Origami -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package origami :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- undo-tree -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- gui disable -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice epg--start (around advice-epg-disable-agent activate)
  (let ((agent (getenv "GPG_AGENT_INFO")))
    (setenv "GPG_AGENT_INFO" nil)
    ad-do-it
    (setenv "GPG_AGENT_INFO" agent)))

(setq use-dialog-box nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- flyspell --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sudo dnf install aspell-en
;;Swedish spell check in all i text files (including LaTeX-files).
;;These settings will not affect programming.

(add-hook 'text-mode-hook '(lambda () (flyspell-mode nil)))
;;(add-hook 'text-mode-hook '(lambda () (ispell-change-dictionary "svenska" nil)))

;;don't print words in mini-buffer when scanning, so sloooow
(setq flyspell-issue-message-flag' nil)

;;auto configure language (does not work? Says "??" in mod-line)
;;(require 'auto-dictionary)
;;(add-hook 'flyspell-mode-hook '(lambda () (auto-dictionary-mode 1)))

;;ispell=unix native spell checker, aspell=GNU's ispell, hunspell=OpenOffice & firefox
(setq ispell-program-name "aspell"
  ispell-extra-args '("--sug-mode=normal"))

;;change dictionary: "C-c e" = engelska, "C-c s"=svenska, "C-c w"=turn off flyspell
(add-hook 'text-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c s 1")
                             (lambda()(interactive)
                               (ispell-change-dictionary "american")
                               (flyspell-mode 1)
                               (flyspell-buffer)))
             (local-set-key (kbd "C-c s 2")
                             (lambda()(interactive)
                               (ispell-change-dictionary "british-ize")
                               (flyspell-mode 1)
                               (flyspell-buffer)))
             (local-set-key (kbd "C-c s 3")
                             (lambda()(interactive)
                               (ispell-change-dictionary "british-ise")
                               (flyspell-mode 1)
                               (flyspell-buffer)))
             (local-set-key (kbd "C-c s 0")
                             (lambda()(interactive)
                               (flyspell-mode -1)))
             ))

;; Color Configurations
;(custom-set-faces
; '(flyspell-incorrect ((((class color)) (:foreground "red"  :underline t :weight bold))))
;
; '(flyspell-duplicate ((((class color)) (:foreground "green" :underline t :weight bold)))) 
					; )

(custom-set-faces
 '(flyspell-duplicate ((t (:underline "green"))))
 '(flyspell-incorrect  ((t (:underline "red"))))
 '(langtool-errline ((t (:background "red" :foreground "black"))))
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Extra --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq file-name-handler-alist nil)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'matlab-mode-hook 'display-line-numbers-mode)

;(setq linum-mode -1)
(setq sentence-end-double-space nil)
(setq frame-title-format "Emacs")
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq save-place '(saveplace))
(setq inhibit-startup-screen t) ;; Show Scratch as startup
(desktop-save-mode 1)
(window-divider-mode -1)
(setq default-directory "~/")
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq show-paren-delay 0) ;; shows matching parenthesis asap
(show-paren-mode t)
(add-hook 'after-init-hook 'global-hl-line-mode) ;; highlight current line
(electric-pair-mode 1) ;; Matching pairs
(setq next-line-add-newlines t) ;; C-o create new line
(setq ring-bell-function 'ignore)
;;(setq visible-bell -1)
(fset 'yes-or-no-p 'y-or-n-p)
;(setq-default indicate-empty-lines t)
(set-window-fringes (selected-window) 0 0) 

(defun nolinum ()
  (global-linum-mode 0)
)
(add-hook 'org-mode-hook 'nolinum)

;(setq linum-format "%d ")
;(setq linum-format "%4d \u2502 ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Keybinding --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer-move package
(use-package buffer-move
  :ensure t
  :config
  (progn
      (global-set-key (kbd "C-c C-<left>") 'buf-move-left)
      (global-set-key (kbd "C-c C-<right>") 'buf-move-right)
      (global-set-key (kbd "C-c C-<down>") 'buf-move-down)
      (global-set-key (kbd "C-c C-<up>") 'buf-move-up)

      (global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
      (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
      (global-set-key (kbd "S-C-<down>") 'shrink-window)
      (global-set-key (kbd "S-C-<up>") 'enlarge-window))
  )

(use-package dirtree
  :ensure t
  :config
  (windmove-default-keybindings))

(global-set-key (kbd "<f5>") 'revert-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Auto Remove -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Auto remove/kill Completion buffer when done
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))
	     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Revert all buffers -;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- abbrevs -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq abbrev-file-name                ;; tell emacs where to read abbrev
      "~/.emacs.d/abbrev_defs.el")    ;; definitions from...
(setq save-abbrevs t)                 ;; (ask) save abbrevs when files are saved
(setq-default abbrev-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Matching Parents -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
	((looking-at "\\s)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

(global-set-key "%" 'match-paren)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Projectile -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package projectile
  :ensure t
  :bind (:map projectile-mode-map
		("s-p" . 'projectile-command-map)
		("C-c p" . 'projectile-command-map))
  :config 
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1))

(use-package ibuffer-projectile
  :ensure t
  :config 
  (add-hook 'ibuffer-hook
      (lambda ()
	(ibuffer-projectile-set-filter-groups)
	(unless (eq ibuffer-sorting-mode 'alphabetic)
	  (ibuffer-do-sort-by-alphabetic))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Cursor -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(blink-cursor-mode 0) ; disable blinking cursor

(defun djcb-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."
  (cond
    (buffer-read-only
      (set-cursor-color "gray")
      (setq cursor-type 'hbar))
    ;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
    ;; (hbar. HEIGHT); see the docs for set-cursor-type
    (mark-active
     (set-cursor-color "#00CCFF")
     (setq cursor-type 'hollow-rectangle))
    
    (overwrite-mode
      (set-cursor-color "red")
      (setq cursor-type 'box))
    (t
      (set-cursor-color "#00CCFF")
      (setq cursor-type 'box))))

;;TODO: only activate this setup if not in doc-view-mode:
(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)

; divide line
(set-face-background 'vertical-border "#898989")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Hydra -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package hydra
  :ensure t
  :config
  (defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- magit -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package magit :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- English Language -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dictionary
  :ensure t
  :config
  (global-set-key (kbd "C-c M-d") 'dictionary-lookup-definition))

(use-package synosaurus
  :ensure t
  :config
  (global-set-key (kbd "C-c M-s") 'synosaurus-lookup))

;; Meriam-Webster Dictionary
					; 0f6d00d3-4925-450b-8581-b364b0851ace
					; 41324f64-09d9-4897-9a01-5f8cb8138607
					;(add-to-list 'load-path "~/.emacs.d/langtool/")
(use-package mw-thesaurus
  :ensure t
  :config
  (setq mw-thesaurus--api-key "41324f64-09d9-4897-9a01-5f8cb8138607"))

;; Langtool (Grammar Check)
(use-package langtool
  :ensure t
  :init
  (setq langtool-language-tool-jar "~/Downloads/LanguageTool-5.0/languagetool-commandline.jar")  
  :config

;(add-hook 'org-mode-hook
;           (lambda () 
;              (add-hook 'after-save-hook 'langtool-check nil 'make-it-local)))

(add-hook 'text-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c g 1") 'langtool-check)
             (local-set-key (kbd "C-c g 0") 'langtool-check-done)
	     (local-set-key (kbd "C-c g n") 'langtool-goto-next-error)
	     (local-set-key (kbd "C-c g p") 'langtool-goto-previous-error)
             ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;(setq-default left-margin-width 2 right-margin-width 4) ; Define new widths.
;(set-window-buffer nil (current-buffer)) ; Use them now.

;(defun my-set-margins ()
;  "Set margins in current buffer."
;  (setq left-margin-width 2)
;  (setq right-margin-width 4))

;(add-hook 'text-mode-hook 'my-set-margins)
;(set-face-attribute 'fringe nil :background "#2E2920" :foreground "#2E2920") ;; margin color



)
(setq gc-cons-threshold (* 100 1024 1024))
(provide 'init)

;;; init.el ends here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- END -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-roam-bibtex zenburn-theme which-key virtualenvwrapper vi-tilde-fringe use-package undo-tree try synosaurus smex origami org-ref org-noter-pdftools org-bullets olivetti ob-ipython nyan-mode mw-thesaurus multiple-cursors monokai-theme mode-icons matlab-mode magit lsp-ui lsp-ivy langtool julia-mode ivy-rich ivy-bibtex iedit ibuffer-projectile gnuplot fzf focus flycheck expand-region esup ess emacsql-sqlite3 elpy elfeed-org elfeed-goodies ein ebib doom-themes doom-modeline dirtree dictionary dap-mode counsel company-lsp cdlatex buffer-move auctex all-the-icons-ivy all-the-icons-dired academic-phrases)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:underline (:color "#F92672")))))
 '(flycheck-info ((t (:underline (:color "#66D9EF")))))
 '(flycheck-warning ((t (:underline (:color "#FD971F")))))
 '(flyspell-duplicate ((t (:underline "green"))))
 '(flyspell-incorrect ((t (:underline "red"))))
 '(ido-incomplete-regexp ((t (:foreground "#0000FF"))))
 '(ido-only-match ((t (:background "#008000"))))
 '(langtool-errline ((t (:background "red" :foreground "black")))))

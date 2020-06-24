;;;;;;;;;;;;;;;;; init.el file ;;;;;;;;;;;;;;;;;;;;;



(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)

(require 'package)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))


(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))


  (when (fboundp 'winner-mode)
    (winner-mode 1))
  
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  )

(use-package fzf :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- navigation --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))


(use-package avy
:ensure t
:bind ("M-s" . avy-goto-word-1)) ;; changed from char as per jcs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- MISC --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ; Highlights the current cursor line
  (global-hl-line-mode t)
  
  ; flashes the cursor's line when you scroll
  (use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  ; (setq beacon-color "#666600")
  )
  
  ; deletes all the whitespace when you hit backspace or delete
  ;(use-package hungry-delete
  ;:ensure t
  ;:config
  ;(global-hungry-delete-mode))
  

  (use-package multiple-cursors
  :ensure t)

  ; expand the marked region in semantic increments (negative prefix to reduce region)
  (use-package expand-region
  :ensure t
  :config 
  (global-set-key (kbd "C-=") 'er/expand-region))

(setq save-interprogram-paste-before-kill t)


(global-auto-revert-mode 1) ;; you might not want this
(setq auto-revert-verbose nil) ;; or this
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f6>") 'revert-buffer)


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Iedit --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

					; mark and edit all copies of the marked region simultaniously. 
(use-package iedit
  :ensure t)

; if you're windened, narrow to the region, if you're narrowed, widen
; bound to C-x n
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

;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing keymap, that's
;; how much I like this command. Only copy it if that's what you want.
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
 ;;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
 ;;(doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
 ;;(doom-themes-org-config)



(set-cursor-color "#ffffff")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- ido --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;; M-x configurations
(global-set-key
     "\M-x"
     (lambda ()
       (interactive)
       (call-interactively
        (intern
         (ido-completing-read
          "M-x "
          (all-completions "" obarray 'commandp))))))



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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Flycheck --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- python -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Important add directory to path - it is used for ein package
 (setenv "PATH" (concat (getenv "PATH") ":~/Software/anaconda3/bin/"))
 (setq exec-path (append exec-path '("~/Software/anaconda3/bin/")))

(setq python-python-command "~/Software/anaconda3/envs/neuro001/bin/python")
(setenv "WORKON_HOME" "~/Software/anaconda3/envs")
(setq python-shell-interpreter "~/Software/anaconda3/envs/neuro001/bin/python")
(setq elpy-rpc-python-command "~/Software/anaconda3/envs/neuro001/bin/python")


(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

(venv-workon "neuro001")
(setq lsp-python-executable-cmd "~/Software/anaconda3/envs/neuro001/bin/python")


(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- company-mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Toggle company-mode and auto-complete-mode use <M-x company-mode/auto-complete-mode>
;;in mini-buffer

(use-package company
  :ensure t
  :pin melpa
  :config
  (progn
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (setq company-auto-complete nil)
    (add-hook 'after-init-hook 'global-company-mode)
    ;;(setq company-show-doc-buffer nil)
    (setq company-minimum-prefix-length 3)
    (setq company-idle-delay 0.0)
    (setq ess-use-company 'script-only))
  )

;; Standard Jedi.el setting --- After instalation, M-x jedi:install-server


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- lsp-mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	   ;(python-mode . lsp)
	   ;(r-mode . lsp)
	   ;(c++-mode . lsp)
	   ;(latex-mode . lsp)
            ;; if you want which-key integration
            (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; if you are helm user
;(use-package helm-lsp :ensure t :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :ensure t :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language


(use-package company-lsp
  :ensure t
    :config
    (push 'company-lsp company-backends))
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
  (add-hook 'matlab-mode-hook 'auto-complete-mode))
  (matlab-cedet-setup)
  )
 
;; Firs time install: (use-package matlab-mode :ensure: t ....) then change to above 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- ess --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ess
  :ensure t
  :config
  (require 'ess-site)
  (setq ess-use-auto-complete t)
  (setq inferior-ess-r-program "/usr/bin/R")
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- AUCTEX --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package auctex
:defer t
:ensure t)

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
(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Jupyter (EIN) -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package: gnuplot
;; these lines enable the use of gnuplot mode
(use-package ein
  :ensure t
  :config
  (setq ein:output-area-inlined-images t)
  )
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- org mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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



(use-package ob-ipython
  :ensure t)


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


(use-package org-bullets
:ensure t
:config 
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)


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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Icons and Powerline --;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode)
  )

(use-package all-the-icons
  :ensure t
  )


(use-package all-the-icons-ivy
:ensure t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup)
 )


(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nyan-mode
  :ensure t)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package origami
:ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Origami -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- undo-tree -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- gui disable -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice epg--start (around advice-epg-disable-agent activate)
  (let ((agent (getenv "GPG_AGENT_INFO")))
    (setenv "GPG_AGENT_INFO" nil)
    ad-do-it
    (setenv "GPG_AGENT_INFO" agent)))

(setq use-dialog-box nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Extra --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq file-name-handler-alist nil)
(add-hook 'prog-mode-hook 'linum-mode)
(blink-cursor-mode 0) ;; disable blinking cursor
(setq sentence-end-double-space nil)
(setq frame-title-format "Emacs")
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq save-place '(saveplace))
(setq inhibit-startup-screen t) ;; Show Scratch as startup
(desktop-save-mode 1)
(window-divider-mode 1)
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
(global-set-key (kbd "<f5>") 'revert-buffer)
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
  (windmove-default-keybindings)
  )

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










(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(all-the-icons-ivy-buffer-commands (quote (ivy-switch-buffer-other-window ivy-switch-buffer)))
 '(package-selected-packages
   (quote
    (dap-mode lsp-imenu lsp-mode iedit multiple-cursors hungry-delete counsel markdown-mode doom-themes neotree all-the-icons-dired which-key use-package undo-tree try telephone-line org-bullets ob-ipython monokai-theme mode-icons matlab-mode jedi gnuplot flycheck ess elpy ein cdlatex auctex all-the-icons))))

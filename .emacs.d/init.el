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
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- theme --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t)
  )

(set-cursor-color "#ffffff")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- ido --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- matlab --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- ess --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ess
  :ensure t
  :init (require 'ess-site))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- AUCTEX --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package auctex
:defer t
:ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- gnuplot -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- gnuplot -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package: gnuplot
;; these lines enable the use of gnuplot mode
(use-package ein
  :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- org mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Flycheck --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Elpy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  )

(setq inferior-ess-r-program "/usr/bin/R")


;; Important add directory to path - it is used for ein package
 (setenv "PATH" (concat (getenv "PATH") ":~/Software/anaconda3/bin/"))
 (setq exec-path (append exec-path '("~/Software/anaconda3/bin/")))

(setq python-python-command "~/Software/anaconda3/bin/python")
(setenv "WORKON_HOME" "~/Software/anaconda3/envs")
(setq python-shell-interpreter "~/Software/anaconda3/bin/python")
(setq elpy-rpc-python-command "~/Software/anaconda3/bin/python")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- company-mode --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Toggle company-mode and auto-complete-mode use <M-x company-mode/auto-complete-mode> in mini-buffer
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
    (setq company-idle-delay 0.0))
  )

;; Standard Jedi.el setting --- After instalation, M-x jedi:install-server
(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Icons and Powerline --;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode)
  )

(use-package all-the-icons
  :ensure t
  )

(use-package telephone-line
  :ensure t
  :config
  (progn
    (telephone-line-mode 1)
    (setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
        (accent . (telephone-line-vc-segment
                   telephone-line-erc-modified-channels-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-minor-mode-segment
                   telephone-line-buffer-segment))))
(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment)))))
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- undo-tree -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- gui disable -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice epg--start (around advice-epg-disable-agent activate)
  (let ((agent (getenv "GPG_AGENT_INFO")))
    (setenv "GPG_AGENT_INFO" nil)
    ad-do-it
    (setenv "GPG_AGENT_INFO" agent)))

(setq use-dialog-box nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Extra --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(blink-cursor-mode 0) ;; disable blinking cursor
(setq sentence-end-double-space nil)
(setq frame-title-format "Emacs")
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(linum-mode t)
(setq save-place '(saveplace))
(setq inhibit-startup-screen t) ;; Show Scratch as startup
(desktop-save-mode 1)
(window-divider-mode 1)
(setq default-directory "~/")
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-- Extra --;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





















(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (which-key use-package undo-tree try telephone-line org-bullets ob-ipython monokai-theme mode-icons matlab-mode jedi gnuplot flycheck ess elpy ein cdlatex auctex all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; load emacs 24's package system. Add MELPA repository.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
 
   
   
   ;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
   
   
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#272822" "#E74C3C" "#A6E22E" "#E6DB74" "#268bd2" "#F92660" "#66D9EF" "#F8F8F2"])
 '(ansi-term-color-vector
   [unspecified "#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#ff6188" "#fcfcfa"] t)
 '(column-number-mode t)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (doom-monokai-classic)))
 '(custom-safe-themes
   (quote
    ("6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" "7b3d184d2955990e4df1162aeff6bfb4e1c3e822368f0359e15e2974235d9fa8" "54cf3f8314ce89c4d7e20ae52f7ff0739efb458f4326a2ca075bf34bc0b4f499" "25f1b2ace87d23d803b42267fafdc38b31472e444c2aaa9069aa2c06be8955b2" "9b272154fb77a926f52f2756ed5872877ad8d73d018a426d44c6083d1ed972b1" "a92e9da0fab90cbec4af4a2035602208cebf3d071ea547157b2bfc5d9bd4d48d" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "b5fff23b86b3fd2dd2cc86aa3b27ee91513adaefeaa75adc8af35a45ffb6c499" "3c2f28c6ba2ad7373ea4c43f28fcf2eed14818ec9f0659b1c97d4e89c99e091e" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "5846b39f2171d620c45ee31409350c1ccaddebd3f88ac19894ae15db9ef23035" "632694fd8a835e85bcc8b7bb5c1df1a0164689bc6009864faed38a9142b97057" "5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" "5b809c3eae60da2af8a8cfba4e9e04b4d608cb49584cb5998f6e4a1c87c057c4" "71e5acf6053215f553036482f3340a5445aee364fb2e292c70d9175fb0cc8af7" "e2acbf379aa541e07373395b977a99c878c30f20c3761aac23e9223345526bcc" "3d3807f1070bb91a68d6638a708ee09e63c0825ad21809c87138e676a60bda5d" "912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0" "dcdd1471fde79899ae47152d090e3551b889edf4b46f00df36d653adc2bf550d" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "816bacf37139d6204b761fea0d25f7f2f43b94affa14aa4598bce46157c160c2" "379a804655efccc13a3d446468992bfdfc30ff27d19cfda6f62c7f9c9e7a8a7d" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" "b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" "123a8dabd1a0eff6e0c48a03dc6fb2c5e03ebc7062ba531543dfbce587e86f2a" "e1d09f1b2afc2fed6feb1d672be5ec6ae61f84e058cb757689edb669be926896" "a06658a45f043cd95549d6845454ad1c1d6e24a99271676ae56157619952394a" "939ea070fb0141cd035608b2baabc4bd50d8ecc86af8528df9d41f4d83664c6a" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" "9f15d03580b08dae41a1e5c1f00d1f1aa99fea121ca32c28e2abec9563c6e32c" "6177ecbffb8f37756012c9ee9fd73fc043520836d254397566e37c6204118852" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "93ed23c504b202cf96ee591138b0012c295338f38046a1f3c14522d4a64d7308" "4e764943cc022ba136b80fa82d7cdd6b13a25023da27528a59ac61b0c4f1d16f" "e30e72b10b9c7887ff8adcd1a25b5c6eaa32665e0f8f40994e5b6d51069d3b2a" "6bacece4cf10ea7dd5eae5bfc1019888f0cb62059ff905f37b33eec145a6a430" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "24132f7b6699c6e0118d742351b74141bac3c4388937e40db9207554eaae78c9" "1623aa627fecd5877246f48199b8e2856647c99c6acdab506173f9bb8b0a41ac" "79278310dd6cacf2d2f491063c4ab8b129fee2a498e4c25912ddaa6c3c5b621e" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "82360e5f96244ce8cc6e765eeebe7788c2c5f3aeb96c1a765629c5c7937c0b5b" "f9cae16fd084c64bf0a9de797ef9caedc9ff4d463dd0288c30a3f89ecf36ca7e" "0cb1b0ea66b145ad9b9e34c850ea8e842c4c4c83abe04e37455a1ef4cc5b8791" "51956e440cec75ba7e4cff6c79f4f8c884a50b220e78e5e05145386f5b381f7b" "58c3313b4811ed8b30239b1d04816f74d438bcb72626d68181f294b115b7220d" "7d708f0168f54b90fc91692811263c995bebb9f68b8b7525d0e2200da9bc903c" "c83c095dd01cde64b631fb0fe5980587deec3834dc55144a6e78ff91ebc80b19" "730a87ed3dc2bf318f3ea3626ce21fb054cd3a1471dcd59c81a4071df02cb601" "2cdc13ef8c76a22daa0f46370011f54e79bae00d5736340a5ddfe656a767fddf" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "7c4cfa4eb784539d6e09ecc118428cd8125d6aa3053d8e8413f31a7293d43169" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "d5f8099d98174116cba9912fe2a0c3196a7cd405d12fa6b9375c55fc510988b5" "7f791f743870983b9bb90c8285e1e0ba1bf1ea6e9c9a02c60335899ba20f3c94" "dde8c620311ea241c0b490af8e6f570fdd3b941d7bc209e55cd87884eb733b0e" "f2b56244ecc6f4b952b2bcb1d7e517f1f4272876a8c873b378f5cf68e904bd59" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "56911bd75304fdb19619c9cb4c7b0511214d93f18e566e5b954416756a20cc80" "fe94e2e42ccaa9714dd0f83a5aa1efeef819e22c5774115a9984293af609fce7" "7a994c16aa550678846e82edc8c9d6a7d39cc6564baaaacc305a3fdc0bd8725f" "ef1673f437a39637cfad495400813d5dd1246a01325c898ba4fc776af3ffe620" "e964832f274625fa45810c688bdbe18caa75a5e1c36b0ca5ab88924756e5667f" "1526aeed166165811eefd9a6f9176061ec3d121ba39500af2048073bea80911e" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" "f9aede508e587fe21bcfc0a85e1ec7d27312d9587e686a6f5afdbb0d220eab50" "11e57648ab04915568e558b77541d0e94e69d09c9c54c06075938b6abc0189d8" "588b1c5d24ab8ddeffe6e7ae93ac642f71149bbb67b13e54edbef4ef761ad13c" "13fa7a304bd53aa4c0beec4c25c4f811de499bce9deb326798265ed0015b3b78" default)))
 '(fci-rule-color "#555556")
 '(global-display-line-numbers-mode t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#FD971F"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#A6E22E"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#525254"))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(objed-cursor-color "#E74C3C")
 '(package-selected-packages
   (quote
    (docker smooth-scrolling minimap dashboard typit typing-game pyenv-mode elpy desktop+ helm mode-icons ein dockerfile-mode all-the-icons-dired all-the-icons all-the-icons-ibuffer company-irony-c-headers irony-eldoc irony company-irony zenburn-theme spacemacs-theme buffer-move yasnippet-snippets yasnippet flycheck company-quickhelp magit gruvbox-theme jupyter eimp company twittering-mode sml-modeline nyan-mode 2048-game fireplace pdf-tools ert-runner s cask w3m smart-mode-line-powerline-theme smart-mode-line powerline org evil doom-themes markdown-mode auctex dirtree tree-mode windata ess molokai-theme monokai-theme monokai-pro-theme dracula-theme matlab-mode)))
 '(pdf-view-midnight-colors (cons "#F8F8F2" "#272822"))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(rustic-ansi-faces
   ["#272822" "#E74C3C" "#A6E22E" "#E6DB74" "#268bd2" "#F92660" "#66D9EF" "#F8F8F2"])
 '(send-mail-function (quote mailclient-send-it))
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote sml/global)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(vc-annotate-background "#272822")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A6E22E")
    (cons 40 "#bbdf45")
    (cons 60 "#d0dd5c")
    (cons 80 "#E6DB74")
    (cons 100 "#edc457")
    (cons 120 "#f5ad3b")
    (cons 140 "#FD971F")
    (cons 160 "#fb7134")
    (cons 180 "#fa4b4a")
    (cons 200 "#F92660")
    (cons 220 "#f33254")
    (cons 240 "#ed3f48")
    (cons 260 "#E74C3C")
    (cons 280 "#c14d41")
    (cons 300 "#9c4f48")
    (cons 320 "#77504e")
    (cons 340 "#555556")
    (cons 360 "#555556")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white"))))
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil))))
 '(spaceline-python-venv ((t (:distant-foreground "dark magenta" :foreground "plum1")))))
 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; matlab ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . matlab-mode))
 (setq matlab-indent-function t)
 (setq matlab-shell-command "~/Software/matlab/R2019b/bin/matlab")
 
 (add-hook 'matlab-mode-hook 'auto-complete-mode)

    (matlab-cedet-setup)
     

(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; AUCTEX ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ESS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'package)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;;(package-initialize)  ;load and activate packages, including auto-complete
;;(ac-config-default)
;;(setq ess-use-auto-complete t)
;;(setq ess-use-auto-complete 'script-only)


(add-hook 'python-mode-hook (lambda () (auto-complete-mode -1)))

;;Auto-Completion Color
;;(set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
;;(set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
;;(set-face-attribute 'popup-tip-face    nil   :background "#003A4E" :foreground "light gray")


;;Company is the best package for auto completion
;;(setq ess-use-auto-complete 'script-only)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;org mode;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Jupyter -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package -- ein


;;## Jupyter Notebook
;;Package ein is exccelletn!!
 
;;Server:  M-x ein:login // for docker server=localhost:8888 password:****
;;Local:  M-x ein:run 
;;M-x revert-buffer // refresh the buffer

;;;;;;;;;;;;;;;;;;;;;;;;; font ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq elpy-rpc-backend "jedi")  
	   
;; Standard package.el + MELPA setup
;; (See also: https://github.com/milkypostman/melpa#usage)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)



;; Standard Jedi.el setting
(require 'jedi)
(add-to-list 'ac-sources 'ac-source-jedi-direct)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


(defvar jedi-config:with-virtualenv nil
"set to non-nil to point to a particular virtualenv.")


(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inferior-lisp-program "sbcl")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Evil Mode -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(evil-mode 1)
;(setq key-chord-two-keys-delay 0.5)
;(key-chord-define evil-insert-state-map ";;" 'evil-normal-state)
;(key-chord-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Powerline -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
        (evil   . (telephone-line-airline-position-segment))))

(require 'telephone-line)
(telephone-line-mode 1)




;;(use-package spaceline
;;  :demand t
;;  :init
;;  (setq powerline-default-separator 'arrow-fade)
;;  :config
;;  (require 'spaceline-config)
;;  (spaceline-spacemacs-theme))


;;(setq spaceline-separator-dir-left '(left . left))
;;(setq spaceline-separator-dir-right '(right . right))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Auto Complete -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(setq company-idle-delay 0.0) 
(yas-global-mode 1)
;;;;;;

(use-package company
:ensure t
:config
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)
(global-company-mode t))

(use-package company-irony
:ensure t
:config
(add-to-list 'company-backends 'company-irony))

(use-package irony
:ensure t
:config
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package irony-eldoc
:ensure t
:config
(add-hook 'irony-mode-hook #'irony-eldoc))

(use-package company-jedi
:ensure t
:config
(add-hook 'python-mode-hook 'jedi:setup))

(defun my/python-mode-hook ()
(add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Elpy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(setq inferior-ess-r-program "/usr/bin/R")
(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
(require 'flycheck)
(add-hook 'ess-mode-hook
          (lambda () (flycheck-mode t)))
;; Important add directory to path - it is used for ein package
 (setenv "PATH" (concat (getenv "PATH") ":~/Software/anaconda3/bin/"))
 (setq exec-path (append exec-path '("~/Software/anaconda3/bin/")))

(setq python-python-command "~/Software/anaconda3/bin/python")
(setenv "WORKON_HOME" "~/Software/anaconda3/envs")
(setq python-shell-interpreter "~/Software/anaconda3/bin/python")
(setq elpy-rpc-python-command "~/Software/anaconda3/bin/python")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Icons -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; require packages: all-the-icons and all-the-icons-dired
(require 'all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Dockerfile -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dockerfile package
(add-to-list 'load-path "~/.emacs.d/elpa/dockerfile-mode-20200106.2126/dockerfile-mode.el")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Flycheck -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages: flycheck, yassinep, yassinep-snippets, and company
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Desktop -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Loading a desktop saved from a previous session ata startup
(desktop-save-mode)
;; optional - if your desktop is saved in "~.emacs.d/.cache/"
(setq desktop-path '("~/.emacs.d/desktop/"))
(desktop-read)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Extra -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; buffer-move package
(global-set-key (kbd "C-c C-<left>") 'buf-move-left)
(global-set-key (kbd "C-c C-<right>") 'buf-move-right)
(global-set-key (kbd "C-c C-<down>") 'buf-move-down)
(global-set-key (kbd "C-c C-<up>") 'buf-move-up)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(window-divider-mode t) ;; window-divider

(require 'dirtree)
(windmove-default-keybindings)


(when (fboundp 'winner-mode)
  (winner-mode 1))      ;; <C-c> <left> restor previous window configuration

(set-cursor-color "#ffffff")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- gui disable -;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice epg--start (around advice-epg-disable-agent activate)
  (let ((agent (getenv "GPG_AGENT_INFO")))
    (setenv "GPG_AGENT_INFO" nil)
    ad-do-it
    (setenv "GPG_AGENT_INFO" agent)))

(setq use-dialog-box nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- Icons -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages: all-the-icons, all-the-icons-dired, and mode-icons
(mode-icons-mode) ;; mode-icons package

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;- helm -;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package: helm
(require 'helm)
(helm-mode 1)
;;(setq mode-icons-change-mode-name nil)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x d") #'helm-find-files)


;; helm-recentf to see recent files
(require 'recentf)

(recentf-mode 1)
(global-set-key "\C-xf" 'helm-recentf)
;; or (global-set-key "\C-xf" 'recentf-open-files)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree

(require 'undo-tree)
(global-undo-tree-mode)

;;(set-background-color "#000000")
;;(add-to-list 'default-frame-alist '(background-color . "#000000"))
(set-face-attribute 'region nil :background "#454545")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(set-frame-parameter (selected-frame) 'alpha '(100 100))
;;(add-to-list 'default-frame-alist '(alpha 100 100))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; startup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'dashboard)
;;(dashboard-setup-startup-hook)
;; Or if you use use-package
;;(use-package dashboard
 ;; :ensure t
;;  :config
;;  (dashboard-setup-startup-hook))



;;(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq frame-title-format "Emacs")

(ido-mode)

(show-paren-mode)

(winner-mode t)

(global-hl-line-mode)

(windmove-default-keybindings)

(cua-mode -1)

(tool-bar-mode -1)

(menu-bar-mode -1)

(scroll-bar-mode -1)

;;(set-default 'cursor-type 'hbar)

(column-number-mode t)

(show-paren-mode t)

(setq inhibit-startup-message t)

(setq comint-process-echoes t)

(setq default-directory "~/")

(setq-default major-mode 'lisp-mode)

(setq-default indent-tabs-mode nil)

(setq make-backup-files nil)

(setq mouse-autoselect-window t)

(setq save-place '(saveplace))

;;(setq visible-bell t)
(setq ring-bell-function 'ignore)

(defun my-disable-scroll-bars (frame)

(modify-frame-parameters frame

'((vertical-scroll-bars . nil)

(horizontal-scroll-bars . nil))))

(add-hook 'after-make-frame-functions 'my-disable-scroll-bars)

(add-hook 'after-init-hook 'my-after-init-hook)

(defun my-after-init-hook ()

(progn

(load-theme 'yak-shave t)

(setq default-frame-alist

'((font . "-xos4-terminus-medium-r-normal--12-140-*-*-*-*-*-*")

(cursor-type . hbar)))))

(setq display-time-default-load-average nil)

(setq display-time-day-and-date nil)

(display-time-mode -1)


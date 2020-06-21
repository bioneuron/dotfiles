# Matlab

## Emacs
To run matlab-mode in Emacs:
M-x matlab-shell


-------------------------------------------------------------------------------------------------------------
## nvim
To run matlab in nvim run:
1. Run tmux
$ tmux
2. Run nvim
$ nvim
3. Run the following command in nvim
:call VimuxRunCommand("matlab -nodesktop")

To copy text between vim and terminal use <"> + <+> + <y> to copy from vim and
then past to terminal.


-------------------------------------------------------------------------------------------------------------
# R

## Emacs
Emacs: ESS
run the following:
M-x ess-r-mode


-------------------------------------------------------------------------------------------------------------
# Change resolution from Terminal
$ xrandr -q
$ xrandr -s 1280x720


-------------------------------------------------------------------------------------------------------------
# Python

## Emacs
 M-x run-python
 M-x jedi:install-server   // Auto-completion

Undo in Emacs C-x u !!! // It is great
-------------------------------------------------------------------------------------------------------------
## Jupyter Notebook
Package ein is exccelletn!!
 
Server:  M-x ein:login // for docker server=localhost:8888 password:****
Local:  M-x ein:run 
M-x revert-buffer // refresh the buffer

-------------------------------------------------------------------------------------------------------------
## Elisp
M-x emacs-lisp-mode
C-M-x
C-x C-e
M-x ielm

## Emacs

close buffers?
1) C-x C-b 
2) mark selected buffer with D then press x

-------------------------------------------------------------------------------------------------------------
### helm
;; helm-recentf to see recent files


-------------------------------------------------------------------------------------------------------------
## Terminal

### Terminator terminal
- Font: Source Code Pro Light 11
### zsh
(desktop-save-mode)
;; optional - if your desktop is saved in "~.emacs.d/.cache/"
(setq desktop-path '("~/.emacs.d/desktop/"))
(desktop-read). install oh my zsh
2. change default theme to agnoster


#### Themes
1) powerlevel10k
2) plugins:  zsh-autosuggestions, zsh-syntax-highlighting

### change bash to zsh 
1. sudo vi /etc/passwd
2. change 
$ $USER:x:1000:1000:<name>:/home/$USER:/usr/bin/bash
to
$ $USER:x:1000:1000:<name>:/home/$USER:/usr/bin/zsh


-------------------------------------------------------------------------------------------------------------
## Emacs Packages

* company-mode
* flycheck
* yasnippet
* helm
* magit
* org-mode
* ielm
* isearch
* windmove
* winner
* ein
* Desktop
* all-the-icons
* all-the-icons-dired
* elpy
* undo-tree
* spaceline
* winum
* spaceline-all-the-icons
* org-bullets
* docker-tramp
* iedit
* ivy/avy

** desktop-mode configuration:
;; Create a directory named "desktop" in .emacs.d dir
(desktop-save-mode)
;; optional - if your desktop is saved in "~.emacs.d/desktop/"
(setq desktop-path '("~/.emacs.d/desktop/"))
(desktop-read)


-------------------------------------------------------------------------------------------------------------
## Ein (Emacs)

M-x ein:run
server-command: ~/Software/anaconda3/bin/jupyter 


-------------------------------------------------------------------------------------------------------------
## ESS - flycheck

M-x flycheck-compile
command: r-lintr


-------------------------------------------------------------------------------------------------------------
# rsync
1. Save ignorelist file in /var/tmp directory:

2. Run the following:
$ sudo rsync -aP --exclude-from=/var/tmp/ignorelist /home/$USER/ /run/media/$USER/09016626974/linuxbackup/home



-------------------------------------------------------------------------------------------------------------

## Emacs Key bindings

- python mode
<C-S-<RETURN>> ----> Create blank line befor the current line
<S-<RETURN>> ----> Run the current line


-------------------------------------------------------------------------------------------------------------

## Emacs

### Minimap scroll 

M-x minimap


-------------------------------------------------------------------------------------------------------------
## Emacs 
### Autocompletion
To toggle either of two major auto-complete modes: 
M-x company-mode/auto-complete-mode



## Emacs Keybindings:
<C-x TAB> : Multiline indent

C-x C-x :  The commands that most interest you as far as movement is concerned is C-x C-x to toggle between the point and the mark in the buffer.
C-S-DEL : Delete the line
C-0 C-k : Kill the line backward

C-=     : Word wil be selected. Multiple use for more selection!
C-;     : iEdit!
C-c '   : Open the org-mode code block in a separate edit buffer 
M-x find-name-dired : Recursive search.

C-x n   : Mini navigation!!


flycheck:
M-x flycheck-next-error / flycheck-previous-error    : Go to next/previous error


-------------------------------------------------------------------------------------------------------------
## Inline image show for ein
I had the same problem. First I checked that the graphics had really been created by looking into the .ipynb file (with a text editor) and opening it in HTML browser with jupyter notebook. Second (with M-x customize-group RTN ein), I toggled on the variable Ein:Output Area Inlined Images, restarted Emacs etc. and it worked.


-------------------------------------------------------------------------------------------------------------
## ToDo

Try lsp-mode!










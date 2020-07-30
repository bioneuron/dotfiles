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

$ conda install -c anaconda pylint flake8
$ conda install -c conda-forge python-language-server mypy

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
1- counsel-recentf 
2- helm-recentf to see recent files


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
* lsp-mode

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
<C-S-<RETURN>> ----> Create blank line before the current line
<S-<RETURN>> ----> Run the current line


-------------------------------------------------------------------------------------------------------------

## Emacs

### Minimap scroll 

M-x minimap


-------------------------------------------------------------------------------------------------------------
## Emacs 
### Auto-completion
To toggle either of two major auto-complete modes: 
M-x company-mode/auto-complete-mode



## Emacs Keybindings:
<C-x TAB> : Multi-line indent

C-x C-x :  The commands that most interest you as far as movement is concerned is C-x C-x to toggle between the point and the mark in the buffer.
C-S-DEL : Delete the line
C-0 C-k : Kill the line backward

C-=     : Word Will be selected. Multiple use for more selection!
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

1- Conver default Emacs config fie to an org file named ""myconf.org""! The org file name could not be "init.org"
	because it will be renamed to "init.el" during run time and it will be mixed up with the main config file.
2- Try lsp-mode!


-------------------------------------------------------------------------------------------------------------
## lsp-mode and anaconda3

### lsp-python:

1- sudo ln -s ~/Software/anaconda3/bin/python /usr/bin/python
2- export PATH="$HOME/Software/anaconda3/bin:$PATH"
3- cond a create -n envname python=x.x anaconda 
4- source activate envname
5- conda install -c conda-forge python-language-server
6- pip install pyls-isort pyls-mypy pyls-black
6- open emacs from virtualenv terminal
7- M-x lsp

### Change virtual environment
M-x pyvenv-workon
(optional)
M-x revert-buffer // to show the python version in status bar

### lsp-r:

Install the R server:
1. sudo dnf install libcurl-devel.x86_64  // sudo dnf search libcurl
2. install.packages("languageserver")


### lsp-latex:

Install texlab server:
$ sudo dnf install rust cargo
$ cargo install --git https://github.com/latex-lsp/texlab.git


### lsp-c++:

Install clangd server:
$ sudo dnf install clang


-------------------------------------------------------------------------------------------------------------

## Creating bare git repository:

$ git init --bare $HOME/dotfiles

$ alias dotfile='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

$ dotfile config status.showUntrackedFiles no

$ dotfile remote add origin git@github.com:bioneuron/dotfile.git


### add files
$ dotfile add ~/.bashrc

$ dotfile commit -m "comment"

$ dotfile push origin master


## Python

### Using jupyter notebooks with a virtual environment

$ source activate neuro001
$ conda install ipykernel
$ ipython kernel install --user --name=neuro001 


## org-mode

C-c C-v k clear all results in org-babel
C-c C-x C-f * // Bold the selection
C-c C-, // Shortcuts

-------------------------------------------------------------------------------------------------------------

## Bookmark

M-x C-x r m    : make bookmark
M-x C-x r b    : view bookmark list

-------------------------------------------------------------------------------------------------------------
## Rectangle
C-x +    : Restore window size

C-x r-<KEY> : Rectangle Manipulations

C-x r r : copy rectangle to register
C-x r y : yank as rectangle

-------------------------------------------------------------------------------------------------------------

## Recover File

M-x recover-file <RET> foo.c <RET>
yes <RET>
C-x C-s

-------------------------------------------------------------------------------------------------------------

## Org-mode

### Linewrap

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

-------------------------------------------------------------------------------------------------------------

<C-u 4 C-x TAB>  ----> indent
<C-x C-o>        ----> delete white spaces
<C-/>            ----> cycle

-------------------------------------------------------------------------------------------------------------

## Julia

install julia-mode

julia to run
revert-buffer to enable ess-julia-mode in jl file
ess-julia-mode for auto-completion

-------------------------------------------------------------------------------------------------------------

## English Language

- dictionary package
- synosaurus package // sudo dnf install wordnet

-------------------------------------------------------------------------------------------------------------

(require 'package)

(setq package-enable-at-startup nil) ;; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
			 ("gnu"       . "http://elpa.gnu.org/packages/")
			 ("melpa"     . "https://melpa.org/packages/")
			 ;; ("marmalade" . "http://marmalade-repo.org/packages/")
			 ))
(package-initialize) ; guess what this one does ?

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
(package-refresh-contents) ; updage packages archive
(package-install 'use-package)) ; and install the most recent version of use-package

(require 'use-package)
(setq use-package-always-ensure t) ;; Cette commande permet d’éviter les ensure t

; (setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen

 (setq coding-system-for-read 'utf-8)	; use utf-8 by default
 (setq coding-system-for-write 'utf-8)
 ;;(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
 ;;(setq default-fill-column 80)		; toggle wrapping text at the 80th character
 (setq initial-scratch-message "Salut toi, la patate aujourd’hui?!") ; print a default message in the empty scratch buffer opened at startup
 (scroll-bar-mode -1)        ; Disable visible scrollbar
 (tool-bar-mode -1)          ; Disable the toolbar
 (tooltip-mode -1)           ; Disable tooltips
 (set-fringe-mode 10)        ; Give some breathing room
 (menu-bar-mode -1)          ; Désactive la barre de menu
 (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
 (setq visible-bell 1);fait flasher l’écran au lie d’entendre la sonnette.

(use-package org)

(use-package org-bullets
  :config
  (org-bullets-mode 1)
  ;ça permet de recharger or-bullets dès que je crée un nouveau buffer org mode
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
 )

(setq org-log-done nil) ;n’ajoute rien quand on marque une tâche comme DONE (ou CANCELED)

;c’est trop bien ce qu’il y a en dessous surtout le visual line
(org-indent-mode) ;Keeps org items like text under headings, lists, nicely indented
(visual-line-mode) ;Nice line wrappingsetq org-agenda-files '("~/tasks.org")
(setq org-startup-folded 'fold) ;; Org files start up folded by default

(use-package which-key
  :init
  (which-key-mode)
  (setq which-key-idle-delay 0);définit le tps d’attente avant que which se lance
  (setq which-key-sort-order 'which-key-key-order-alpha
	which-key-min-display-lines 6
	which-key-max-display-columns 4)
  )

(use-package general)

;crée une leader key "SPC" global et override pour retirer le comportement normal de "SPC"
(general-create-definer my-leader-def
  :states '(motion visual normal emacs)
  :keymaps 'override
  :prefix "SPC")

(my-leader-def
  ;Plus utilisés: top level(sans intermédiaires)
  "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
  "SPC" '(avy-goto-char  :which-key "go to char")
  "q" '(save-buffers-kill-terminal :which-key "quit emacs")
  "s" '(save-buffer :which-key "save buffer")
  "#" '(comment-or-uncomment-region :which-key "comment")
  "l"  '(avy-goto-line :which-key "jump to line")
  "e"  '(avy-goto-word-0 :which-key "jump to word")
  "w"  '(sk/return-week-number :which-key "week n°")
  "u" '(undo-tree-visualize :which-key "undo-tree")
  "i" '(indent-pp-sexp :which-key "indent-sexp")
  "o" '(recenter-top-bottom :which-key "recenter")

  ;Windows
  "é" '(nil :which-key "window")
  "éN" '(make-frame :which-key "make frame")
  "éd" '(evil-window-delete :which-key "delete window")
  "é-" '(split-window-vertically :which-key "split below")
  "é/" '(split-window-horizontally :which-key "split right")
  "ér" '(evil-window-right :which-key "evil-window-right")
  "éc" '(evil-window-left :which-key "evil-window-left")
  "ét" '(evil-window-down :which-key "evil-window-down")
  "és" '(evil-window-up :which-key "evil-window-up")
  "éz" '(text-scale-adjust :which-key "text zoom")
  "é TAB" '(evil-window-next :wich-key "next")
  "éD"  '(delete-other-windows :which-key "delete other")
  "és"  '(evil-window-vsplit :which-key "split")

  ;Buffer
  "b" '(nil :which-key "buffers")
  "bb" '(ivy-switch-buffer :which-key "switch")
  "bd" '(kill-buffer :which-key "kill")
  "bn" '(evil-buffer-new :which-key "new")

  ;Files
  "f" '(nil :which-key "files")
  "ff" '(counsel-find-file :which-key "find")
  "fb" '(counsel-bookmark :which-key "bookmark")
  "fs" '(save-buffer :which-key "save");c’est juste le temps que je prenne l’habitude de l’autre

  ;Toggle UI
  "t" '(nil :which-key "toggle")
  "th" '(sk-hydra-theme-switcher/body :which-key "themes") 
  "tt" '(toggle-transparency :which-key "transparency") 
  "tx" '(hydra-text-scale/body :which-key "text-size") 
  "tv" '(visual-line-mode :which-key "visual line mode")
  "tn" '(display-line-numbers-mode :which-key "display line numbers")
  "tm" '(hide-mode-line-mode :which-key "hide modeline mode")
  "tw" '(whitespace-mode :which-key "white space")
  "tc" '(toggle-truncate-lines :which-key "truncate-lines")
  "ts" '(smooth-scrolling-mode :which-key "smooth scrolling")

  ;; Help/emacs
  "h" '(nil :which-key "help/emacs")

  "hv" '(counsel-describe-variable :which-key "des. variable")
  "hb" '(counsel-descbinds :which-key "des. bindings")
  "hf" '(counsel-describe-function :which-key "des. func")
  "hF" '(counsel-describe-face :which-key "des. face")
  "hk" '(describe-key :which-key "des. key")

  "hed" '((lambda () (interactive) (jump-to-register 67)) :which-key "edit dotfile")

  ;; Subtree
  "S" '(nil :which-key "Subtree")
  "Sn" 'org-narrow-to-subtree
  "Sw" 'widen

  ;; "Applications"
  "a" '(nil :which-key "applications")
  "ao" '(org-agenda :which-key "org-agenda")
  "ac" '(calc :which-key "calc")
  "ab" '(browse-url-chrome :which-key "chrome")
  "ar" 'ranger
  "ad" 'dired

  ;; "Lorem ipsum"
  "L" '(nil :which-key "lorem")
  "Ll" '(lorem-ipsum-insert-sentences :which-key "phrase")
  "Lp" '(lorem-ipsum-insert-paragraphs :which-key "§")
  "L-" '(lorem-ipsum-insert-list :which-key "list")
  )


(general-define-key
;je pensais que motion tout seul suffisait à transférer à normal visual et les autres, apparemment non
;donc je les spécifie à la main
:states '(motion normal)
:keymaps 'override

"t" 'evil-next-visual-line
"s" 'evil-previous-visual-line
"c" 'backward-char
"r" 'forward-char
"h" 'evil-replace
"b" 'backward-word
"é" 'forward-to-word
;pour l’instant je fais le redo comme ça
"U" 'undo-fu-only-redo
"u" 'undo-fu-only-undo
"TAB" 'org-cycle
"T" 'scroll-half-page-up
"S" 'scroll-half-page-down
"(" 'backward-sexp ;ca fonctionne pas
")" 'forward-sexp ;ca fonctionne
"/" 'swiper-isearch ;on remplace la recherche par défaut
)

;Org
(general-define-key
:states '(motion normal)
:keymaps 'override
:prefix ","

"e" '(org-end-of-subtree :which-key "end-subtree")
; le h c’est pour le heading le H pour le parent
"h" '(org-previous-visible-heading :which-key "prev-heading")
"H" '(outline-up-heading :which-key "up-heading")
"s" 'org-cycle
;permet d’ouvrir un URL dans nav par défaut au clavier
"c" 'org-open-at-point 

"i" '(:ignore t :which-key "insert")
"it" '(org-time-stamp :which-key "timestamp")
"is" '(org-insert-heading-respect-content :which-key "heading")
"il" '(org-insert-link :which-key "link")

"o" '(:ignore t :which-key "org")
"oc" '(org-toggle-checkbox :which-key "check")
"oa" '(org-agenda :which-key "agenda")
"os" '(org-schedule :which-key "schedule")
)

;Jump
;résumé dans le top level

;Caractères spéciaux en bépo (que en insert)
;C’est pour le mac, sur PC aucun problème comme alt et alt gr
(general-define-key
:states '(insert)
:keymaps 'override
"M-b" "|"
"M-," "'"
"M-p" "&"
"M-P" "§"
"M-n" "~"
"M-e" "€"
"M-u" "ù"
"M-(" "["
"M-)" "]"
"M-y" "{"
"M-x" "}"
"M-à" "\\"
"M-«" "<"
"M-»" ">"
"M-=" "≠"
"M-+" "±"
)

(use-package key-chord
:init
(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.8)
)
; définition classique du raccourci qui exit insert (ou visual) state
(key-chord-define-global "gq" 'evil-normal-state)
(key-chord-define-global "hh" 'outline-up-heading)

(use-package evil
  :init
(evil-mode 1)
;TAB insert une tab et pas autre chose
(setq evil-want-C-i-jump 0)
;(evil-set-undo-system 'undo-redo) j’essaye de le remplacer par undo-fu
)


  (setq evil-emacs-state-cursor    '("#649bce" box))
  (setq evil-normal-state-cursor   '("#ebcb8b" box))
  (setq evil-operator-state-cursor '("#ebcb8b" hollow))
  (setq evil-visual-state-cursor   '("#677691" box))
  (setq evil-insert-state-cursor   '("#eb998b" (bar . 2)))
  (setq evil-replace-state-cursor  '("#eb998b" hbar))
  (setq evil-motion-state-cursor   '("#ad8beb" box))

(use-package avy
:init
;home row letters only (bépo layout)
(setq avy-keys '(?a ?u ?i ?e ?t ?s ?r ?n))
)

; je ne suis psa sûr que ce package serve à quelque chose
(use-package smooth-scrolling
  :init
  (smooth-scrolling-mode nil))

; ça c’est utile
(setq redisplay-dont-pause t
      scroll-margin 10
      scroll-step 1
      scroll-conservatively 10
      scroll-preserve-screen-position 1)

(use-package ivy
  :init
  (ivy-mode)
  )

(use-package counsel)

(use-package gruvbox-theme)
(use-package doom-themes)
(use-package kaolin-themes)
(use-package modus-themes)
(use-package all-the-icons
  :if (display-graphic-p)
  )
(load-theme 'doom-horizon t)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  (setq doom-modeline-height 25)
  (setq doom-modeline-major-mode-icons t)
  (setq doom-modeline-major-mode-icons t)
  )

(use-package undo-fu)

;je teste un peu sans ce package
;(use-package beacon)

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(85 . 50) '(100 . 100)))))
;je le fais une fois parce que sinon il faut le faire 2 fois la 1re fois
(toggle-transparency)

(use-package undo-tree
 :config
 (global-undo-tree-mode)
 )

(defun scroll-half-page-down ()
    (interactive)
    (scroll-down (/ (window-body-height) 4)))

(defun scroll-half-page-up ()
    (interactive)
    (scroll-up (/ (window-body-height) 4)))

(defun sk/return-week-number ()
  (interactive)
  (message "It is week %s of the year." (format-time-string "%U")))

(use-package magit)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-items '(
			  (bookmarks . 5)
			  (recents . 5)
			  (registers . 5)
			  (agenda . 5)
			  )
	)
  (setq dashboard-banner-logo-tile "Salut toi, tu veux voir ma config? ;)")
  (setq dashboard-startup-banner 3)
  (setq dashboard-set-init-info t)
  (setq dashboard-init-info "La patate ou quoi?!")
)

(use-package hydra
  :defer t)

(defhydra sk-hydra-theme-switcher (:hint nil)
  "
     Dark                ^Light^
----------------------------------------------
_1_ deep              _\"_ xcode 
_2_ dracula           _2_ snazzy
_3_ ephemeral         _3_ aurora
_4_ gruvbox           _(_ mono-dark    
_5_ henna             _)_ ocean 
_6_ horizon           _@_ modus-vivendi  
_7_ material          _+_ modus-operandi
_8_ molokai              ^
_9_ peacock              ^
_0_ old-hope             ^
_q_ quit                 ^
^                        ^
"

  ("1" (load-theme 'doom-challenger-deep t) "deep")
  ("2" (load-theme 'doom-dracula t) "dracula")
  ("3" (load-theme 'doom-ephemeral t) "ephemeral")
  ("4" (load-theme 'doom-gruvbox t) "gruvbox")
  ("5" (load-theme 'doom-henna t) "henna")
  ("6" (load-theme 'doom-horizon t) "horizon")
  ("7" (load-theme 'doom-material t) "material")
  ("8" (load-theme 'doom-molokai t) "molokai")
  ("9" (load-theme 'doom-old-hope t) "hold-hope")
  ("0" (load-theme 'doom-peacock t) "peacock")
  ;colonne 2
  ("\"" (load-theme 'doom-xcode t) "xcode")
  ("«" (load-theme 'doom-snazzy t) "snazzy")
  ("»" (load-theme 'kaolin-aurora t) "aurora")
  ("(" (load-theme 'kaolin-mono-dark t) "mono-dark")
  (")" (load-theme 'kaolin-ocean t) "ocean")
  ("@" (load-theme 'modus-vivendi t) "modus-vivendi")
  ("+" (load-theme 'modus-operandi t) "modus-operandi")
  ("q" nil)
  )

;hydra pour taille de la police
(defhydra hydra-text-scale (:timeout 4)
"scale text"
("t" text-scale-increase "in")
("s" text-scale-decrease "out")
("e" nil "finished" :exit t)
)
(fset 'yes-or-no-p  'y-or-n-p)

"
c’est le package qui génère des mots aléatoirement.
"
(use-package lorem-ipsum
:ensure t)

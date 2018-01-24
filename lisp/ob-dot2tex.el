;;; ob-dot2tex.el --- Babel Functions for dot2tex

;;; Code:
(require 'ob)

(defvar org-babel-default-header-args:dot2tex
  '((:results . "file") (:exports . "results"))
  "Default arguments to use when evaluating a dot source block.")

(defun org-babel-expand-body:dot2tex (body params)
  "Expand BODY according to PARAMS, return the expanded body."
  body)

(defun org-babel-execute:dot2tex (body params)
  "Execute a block of Dot code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (flet ((arg (key form &optional def)
	      (if-let ((p (or (cdr (assq key params))
			      (if (eq def 'err)
				  (error "You need to provide %s" (symbol-name key))
				def))))
		  (format form p)
		"")))
    (let* ((res-type (arg :results "%s"))
	   (out-file (arg :file "-o %s" 'err))
	   (dtt-format (arg :format "--format=%s" "tikz"))
	   (dtt-tikzedgelabels (arg :tikzedgelabels "--tikzedgelabels"))
	   (dtt-straightedges (arg :straightedges "--straightedges"))
	   (dtt-styleonly (arg :styleonly "--styleonly"))
	   (dtt-autosizeopt (arg :autosize "--autosize"))
	   (dtt-debugstr (arg :debug "--debug"))
	   (dtt-procprog (arg :layout "--prog=%s" "dot"))
	   (dtt-texmode (arg :texmode "--texmode=%s" "math"))
	   (dtt-graphstyle (arg :graphstyle "--graphstype=%s"))
	   (dtt-options (arg :dot2tex-options "%s"))
	   (in-file (org-babel-temp-file "org-dot2tex" ".dot"))
	   (cmd (concat "dot2tex"
			" " dtt-format
			" " dtt-tikzedgelabels
			" " dtt-straightedges
			" " dtt-styleonly
			" " dtt-autosizeopt
			" " dtt-debugstr
			" " dtt-procprog
			" " dtt-texmode
			" " dtt-graphstyle
			" " dtt-options
			" " out-file
			" " in-file
			" --figonly")))
      (with-temp-file in-file (insert body "\n"))
      (let ((r (org-babel-eval cmd "")))
	(message "Evaluated: %s => '%s'" cmd r)
	(if (member "file" (split-string res-type) ) nil
	  (error "We don't support non-file result types, sorry."))))))

(defun org-babel-prep-session:dot (_session _params)
  "Return an error because Dot does not support sessions."
  (error "Dot does not support sessions"))

(provide 'ob-dot2tex)

;;; ob-dot2tex.el ends here

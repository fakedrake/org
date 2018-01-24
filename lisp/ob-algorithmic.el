;;; ob-algorithmic.el --- Babel Functions for latex algorithms

;;; Code:
(require 'ob)

(defvar org-babel-default-header-args:algorithmic
  '((:exports . "src") (:latex-listings . t))
  "Default arguments to use when evaluating a dot source block.")

(defun org-babel-expand-body:algorithmic (body params)
  "Expand BODY according to PARAMS, return the expanded body."
  body)

(defun org-babel-execute:algorithmic (_body _params)
  "Execute a block of Dot code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (error "Can't execute latex algorithms"))

(defun org-babel-prep-session:algorithmic (_session _params)
  "Return an error because Dot does not support sessions."
  (error "Dot does not support sessions"))

(provide 'ob-algorithmic)

;;; ob-algorithmic.el ends here

;;; carbon-now-sh.el --- https://carbon.now.sh integration.

;; Copyright © 2018 Vitalii Elenhaupt <velenhaupt@gmail.com>
;; Author: Vitalii Elenhaupt
;; URL: https://github.com/veelenga/carbon-now-sh.el
;; Keywords: convenience
;; Version: 0
;; Package-Requires: ((emacs "24.4"))

;; This file is not part of GNU Emacs.

;;; License:

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package allows you to open selected content in carbon.now.sh.

;; Usage:

;; Select some text and run this interactive function:
;;
;;     (carbon-now-sh)

;;; Code:

(require 'cl-lib)
(require 'url-util)

(defgroup carbon-now-sh nil
  "https://carbon.now.sh integration"
  :prefix "carbon-now-sh-"
  :group 'applications
  )

(defconst carbon-now-sh-baseurl "https://carbon.now.sh")

(cl-defun carbon-now-sh--region(&key
                                (beg (and (use-region-p) (region-beginning)))
                                (end (and (use-region-p) (region-end))))
  "Return code in current region."
  (buffer-substring-no-properties beg end))

(defun carbon-now-sh--link ()
  "Generate link for code in region to carbon.now.sh."
  (concat carbon-now-sh-baseurl "?code="
          (url-hexify-string (carbon-now-sh--region))))

;;;###autoload
(defun carbon-now-sh ()
  "Open current region in carbon.now.sh."
  (interactive)
  (browse-url (carbon-now-sh--link)))

;;;###autoload
(defun carbon-now-sh-copy ()
  "Copy a carbon.now.sh link to the copy in region."
  (interactive)
  (kill-new (carbon-now-sh--link)))

(provide 'carbon-now-sh)
;;; carbon-now-sh.el ends here

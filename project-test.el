;; test-project.el --- Ability to run a test suite on the current project -*- lexical-binding: t; -*-

;; Author: David Sullivan <devel@sullatrix.us>
;; URL: https://github.com/davidrs317
;; Created: January 21, 2026
;; Keywords: project, compile, test
;; Package-Requires: ((emacs "24.1"))
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; the Free Software Foundation (FSF), either version 3 of the
;; License, or (at the option of the reader) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.

;; A copy of the GNU General Public License should be have been
;; received along with this program. If not, see
;; <http://www.gnu.org/licenses/>.

;;; Commentary:
;; This package provides one additonal function and one additional
;; customizable variable to test a project using Emacs's `compile'
;; functionality. The intent is to add run a project's test suite
;; without overriding the compilation command as currently happens
;; with the `project-compile' command.

;; For more information see the README in the online repository.

;;; Code:

(defgroup project-test nil
  "Provide an interface to run a test suite in a project."
  :group 'project
  :prefix "project-test-")

(defcustom project-test-command "make -k"
  "Command that should be run executed to run project's test suite.
The default value is \"make -k\" which will attempt to compile as much
as possible after encountering errors"
  :group 'project-test
  :type 'string)

;;;###autoload
(defun project-test-run ()
  "Run the command to execute a project's test suite in a `compile' buffer."
  (declare (interactive-only compile))
  (interactive)
  (let ((default-directory (project-root (project-current t)))
		(compilation-buffer-name-function
		 (or project-compilation-buffer-name-function
			 compilation-buffer-name-function)))
	(compile project-test-command)))

(provide 'project-test)
;;; project-test.el ends here

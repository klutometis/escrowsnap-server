#!/usr/bin/env chicken-scheme

;; (require 'escrowsnap)
;; (import escrowsnap)
(use call-with-sqlite3-connection
     vector-lib
     matchable
     sql-null)
(define (call-with-project-db procedure)
  (call-with-sqlite3-connection
   "project.db"
   procedure))
(use call-with-query json)
(require-library sqlite3)
(import (prefix sqlite3 sqlite3:))

(call-with-dynamic-fastcgi-query
 (lambda (query)
   (display-content-type-&c. 'text)
   (let ((id (query-any query 'id)))
     (pp (query->alist query)))))

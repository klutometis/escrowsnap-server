#!/usr/bin/env chicken-scheme

(use call-with-sqlite3-connection
     vector-lib
     matchable
     sql-null
     call-with-query
     json)

(require-library sqlite3)
(import (prefix sqlite3 sqlite3:))

(include "escrowsnap.scm")
(import escrowsnap)

(call-with-project-db
 (lambda (project-db)
   (call-with-dynamic-fastcgi-query
    (lambda (query)
      (display-status-&c.)
      (let ((id (query-any query 'id)))
        (sqlite3:execute
         project-db
         "UPDATE task SET done = 1 WHERE id = ?;"
         id))))))

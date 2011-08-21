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
      (let* ((id (query-any query 'id))
             (done
              (sqlite3:first-result project-db "SELECT done FROM task WHERE id = ?;" id)))
        (sqlite3:execute
         project-db
         "UPDATE task SET done = not(?) WHERE id = ?;"
         done
         id))))))

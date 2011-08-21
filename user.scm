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
      (display-content-type-&c. 'json)
      (let ((username (query-any query 'username)))
        (json-write
         (sqlite3:map-row
          (lambda (role-id name company phone email)
            (match-let*
                (((permission-id role-name)
                  (sqlite3:first-row
                   project-db
                   "SELECT permission_id, name FROM role WHERE id = ?"
                   role-id))
                 (permission-level
                  (sqlite3:first-result
                   project-db
                   "SELECT level FROM permission WHERE id = ?"
                   permission-id)))
              `#((name . ,(void-if-sql-null name))
                 (company . ,(void-if-sql-null company))
                 (phone . ,(void-if-sql-null phone))
                 (email . ,(void-if-sql-null email))
                 (role-id . ,(void-if-sql-null role-id))
                 (role-name . ,(void-if-sql-null role-name))
                 (permission-id . ,(void-if-sql-null permission-id))
                 (permission-level . ,(void-if-sql-null permission-level)))))
          project-db
          "SELECT role_id, name, company, phone, email FROM person WHERE username = ?;"
          username)))))))

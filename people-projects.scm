#!/usr/bin/env chicken-scheme

(use call-with-sqlite3-connection
     vector-lib
     matchable
     sql-null
     call-with-query
     json
     debug)

(require-library sqlite3)
(import (prefix sqlite3 sqlite3:))

(include "escrowsnap.scm")
(import escrowsnap)

(call-with-project-db
 (lambda (project-db)
   (call-with-dynamic-fastcgi-query
    (lambda (query)
      (display-content-type-&c. 'json)
      (let* ((username (query-any query 'username))
             (owner-id (sqlite3:first-result project-db "SELECT id FROM person WHERE username = ?;" username)))
        (json-write
         (sqlite3:map-row
          (lambda (id address-1 address-2 city state zip)
            `#((id . ,(void-if-sql-null id))
               (address-1 . ,(void-if-sql-null address-1))
               (address-2 . ,(void-if-sql-null address-2))
               (city . ,(void-if-sql-null city))
               (state . ,(void-if-sql-null state))
               (zip . ,(void-if-sql-null zip))))
          project-db
          "SELECT id, address_1, address_2, city, state, zip FROM project WHERE creator_id = ?;"
          owner-id)))))))

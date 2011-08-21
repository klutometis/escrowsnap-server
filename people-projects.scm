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
      (let ((owner-id (query-any query 'owner-id)))
        (json-write
         (sqlite3:map-row
          (lambda (project-id address-1 address-2 city state zip)
            `#((project-id . ,(void-if-sql-null project-id))
               (address-1 . ,(void-if-sql-null address-1))
               (address-2 . ,(void-if-sql-null address-2))
               (city . ,(void-if-sql-null city))
               (state . ,(void-if-sql-null state))
               (zip . ,(void-if-sql-null zip))))
          project-db
          "SELECT id, address_1, address_2, city, state, zip FROM project WHERE creator_id = ?;"
          owner-id)))))))

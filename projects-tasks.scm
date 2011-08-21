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
      (let ((project-id (query-any query 'project-id)))
        (json-write
         (sqlite3:map-row
          (lambda (task-type-id responsible-person-id due-date done other-name)
            (match-let (((type-name type-description)
                         (sqlite3:first-row project-db "SELECT name, description FROM task_type WHERE id = ?;" task-type-id)))
              `#((type-id . ,(void-if-sql-null task-type-id))
                 (type-name . ,(void-if-sql-null type-name))
                 (type-description . ,(void-if-sql-null type-description))
                 (responsible-person-id . ,(void-if-sql-null responsible-person-id))
                 (due-date . ,(void-if-sql-null due-date))
                 (done . ,(void-if-sql-null done))
                 (other-name . ,(void-if-sql-null other-name)))))
          project-db
          "SELECT task_type_id, responsible_person_id, due_date, done, other_name FROM task WHERE project_id = ?;"
          project-id)))))))

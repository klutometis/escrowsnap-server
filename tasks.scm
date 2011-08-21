#!/usr/bin/env chicken-scheme

(use call-with-sqlite3-connection
     vector-lib
     matchable
     sql-null
     call-with-query
     json
     debug
     uri-common
     intarweb
     http-client)

(require-library sqlite3)
(import (prefix sqlite3 sqlite3:))

(include "escrowsnap.scm")
(import escrowsnap)

(define (send-sms phone-number message)
  (with-input-from-request
   (make-request
    method: 'POST
    uri: (uri-reference "https://AC1a9f4597513f08aa979147b8b8c89af5:41483eb10ccf96b2a88207a3d7d671f5@api.twilio.com/2010-04-01/Accounts/AC1a9f4597513f08aa979147b8b8c89af5/SMS/Messages"))
   `((From . "+16262648573")
     (To . ,phone-number)
     (Body . ,message))
   read-string))

;; (define (send-email email)
;;   ())

(call-with-project-db
 (lambda (project-db)
   (call-with-dynamic-fastcgi-query
    (lambda (query)
      (let* ((id (query-any query 'id))
             (done (query-any query 'done)))
        (display-content-type-&c. 'json)
        (sqlite3:execute
         project-db
         "UPDATE task SET done = ? WHERE id = ?;"
         done
         id)
        (match-let*
            (((responsible-person-id task-type-id project-id due-date done)
              (sqlite3:first-row
               project-db
               "SELECT responsible_person_id, task_type_id, project_id, due_date, done FROM task WHERE id = ?"
               id))
             ((task-name task-description)
              (sqlite3:first-row
               project-db
               "SELECT name, description FROM task_type WHERE id = ?;"
               task-type-id))
             ((name phone email)
              (sqlite3:first-row
               project-db
               "SELECT name, phone, email FROM person WHERE id = ?;"
               responsible-person-id)))
          (send-sms
           phone
           (if (zero? done)
               (format "You better get on ~a, ~a; it's due on ~a!"
                       task-name
                       name
                       due-date)
               (format "Nice, ~a; you finished ~a!"
                       name
                       task-name))))
        (json-write done))))))

#!/usr/bin/env chicken-scheme

(use call-with-query json call-with-sqlite3-connection)

(call-with-dynamic-fastcgi-query
 (lambda (query)
   (display-content-type-&c. 'text)
   (let ((id (query-any query 'id)))
     (pp (query->alist query)))))

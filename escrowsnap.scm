
(module
 escrowsnap
 (call-with-project-db)

 (import scheme chicken)

 (use call-with-sqlite3-connection)

 (define (call-with-project-db procedure)
   (call-with-sqlite3-connection
    "project.db"
    procedure)))


(module
 escrowsnap
 (call-with-project-db
  void-if-sql-null)

 (import scheme chicken)

 (use call-with-sqlite3-connection
      sql-null)

 (define (call-with-project-db procedure)
   (call-with-sqlite3-connection
    "project.db"
    procedure))

 (define (void-if-sql-null datum)
  (if (sql-null? datum) (void) datum)))

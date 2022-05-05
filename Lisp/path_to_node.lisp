;Find the path from root to a node n in a binary tree.

(defun isin (n l)
  (cond
   ((null l) nil)
   ((and (atom (car l)) (equal (car l) n)) t)
   ((listp (car l)) (or (isin n (car l)) (isin n (cdr l))))
   ( t  (isin n (cdr l)))
)
)

; Solution withuth map functions
(defun patha (tree n)
 (COND
   ((NULL Tree) NIL)
   ((EQUAL (CAR Tree) n)  (list n))
   ((isin n (cadr tree)) (cons (car tree) ( patha (cadr tree) n)))
   ( t         (cons (car tree)(patha (caddr tree) n)))
 )
)

;Solution with map functions binary tree
(defun pathb (tree n)
  (cond
    ( (null tree) nil   )
    ( (equal (car tree) n) (list (car tree)))
    ( (isin n (cadr tree)) (cons (car tree) (mapcan #'(lambda (ti) (pathb ti n)) (list (cadr tree)))))
    ( t (cons (car tree) (mapcan #'(lambda (ti) (pathb ti n)) (list (caddr tree)))))
)
)


;Solution with map functions n-ary tree

(defun pathc (tree n)
  (cond
    ((and (atom tree)(equal  tree n)) (list tree) )
    ((atom tree)        ())
    ((and (listp tree) (isin n  tree ))  (cons (car tree) (mapcan #'(lambda (ti) (pathc ti n) )  (cdr tree))))
    ((listp tree) nil)
  )
)




; Alternative map solution with let :
(defun path (tree leaf)
  (cond ((null tree) nil)
        ((eq (car tree) leaf) (list leaf))
        (t (mapcan #'(lambda (st)
                     (let ((p (path st leaf))) (when p (cons (car tree) p))))
               (cdr tree)
           ))
  )
)
                     


;Alternative solution 2: check to which subtree the node belongs to and continue on that path, which will generate a valid path and not end in nil.
(defun pathx (tree node)
  ((lambda (x)
    (cond 
     ((null tree) nil)
     ((equal (car tree) node) (list (car tree)))
     ((null x) nil)
     ( t  (cons (car tree) x))
   )) 
  (mapcan (lambda (x) (pathx x node)) (cdr tree))
  )
)

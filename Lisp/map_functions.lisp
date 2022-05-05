(defun triple (x)
  ( cond 
    ((numberp x)  (* x 3))
    ((atom x)         x)
    ( t        (mapcar #'triple x))
  )
)

;(list (triple 1) (triple 2) (triple 3))
;(list 3 6 9)

; triple(x)={ 3*x, if x is number
;           {   x, if x is a nonumric atom
;           { triple(x1) U triple(x2) U... Utriple (xn)  , if x=x1x2..xn a list
;              U triple(xi) , i=1,n


;prod(x)={ x, if x is a number
;        { 1, if x is nonumeric atom
;        { prod(x1) * prod(x2) *....* prod(xn)  , if x=x1x2..xn
;  PI prod (xi)  , i=1,n 

(defun prod (x)
  (cond
     ((numberp x) x)
     ((atom x)    1)
     ( t  (apply #'* (mapcar #'prod x)) )
  )
)

;Compute the number of nodes from the even levels of an n-ary tree, represented as (root (subtree_1) (subtree_2) ... (subtree_n)). The level of the root is 1. For example, for the tree (A (B (D (G) (H)) (E (I))) (C (F (J (L)) (K)))) the result is 7.


;            A              1
;      B            C  M      2
;   D    E        F     N     3
;  G  H    I    J K P       4
;               L           5

; (node (subtree) (subtree))   
;( a (b) (c))
;( 1 2 3( 4 5 ( 4 5 t )a b ))

;countEven( tree, level)={1 , if tree is atom & level%2=0
;                        {0, if tree is atom & level%2=1
;                        {sum(countEven(ti, level+1)) , i=1,n  , if tree=t1t2..tn

(defun countEven (tree level)
  (cond
     ((and (atom tree) (equal (mod level 2) 0))  1)
     ((atom tree)                               0)
     ( t        (apply #'+ (mapcar #'(lambda (ti) ( countEven ti (+ 1 level) ) ) tree )))
   )
)

;mainCE(tree)=countEven(tree, 0)

(defun mainCE (tree)
  (countEven tree 0)
)

;treeCE(tree, level)={0  , if tree is atom (includes [])
;                    {1 + sum(treeCE(ti, level+1)) i=2, n  , if tree=t1t2..tn list & level %2=0
;                    { sum(treeCE(ti, level+1), i=2, n , if tree=t1t2..tn & level%2=1


(defun treeCE (tree level)
  (cond
    ((atom tree) 0)
    ((= 0 (mod level 2))  ( + 1 (apply '+ (mapcar #'(lambda (ti) (treeCE ti (+ 1 level))) (cdr tree)))))
    ( t  (apply '+ (mapcar #'(lambda (ti) (treeCE ti (+1 level))) (cdr tree))))
  )
)

;2. You are given a nonlinear list. Compute the number of sublists (including the initial list) where the first numeric atom is 5. For example, for the list: (A 5 (B C D) 2 1 (G (5 H) 7 D) 11 14) there are 3 such lists: the initial list, (G (5 H) 7 D) and (5 H).


; check(l) - true, if first numerical atom of l  on any level is 5

; transform - remove atomsa anf flatten list
;(G (5 H) 7 D) -  ((5) 7)  -> (5 7) 


;transform(l)={ [l], if l is numeric
;             { [],if l is nonnumeric atom
;             { U transform(li), i=1,n , if l=l1l2..ln (U is append)

(defun transform (l)
  (cond
    ((numberp l) (list l))
    ((atom l)        nil )
    ( t  (mapcan #'transform l))
   )
)

;mapcan
;(nconc (transf l1) (tranfl2)..) 


;check(l)={true , if transform(l)=t1t2..tn, t1=5
;         {false, ( transform(l)=[]   or t1!=5 )

(defun check (l)
  (cond
     ((null (transform l))         nil)
     ((equal (car (transform l)) 5) t)
     ( t                           nil)
   )
)

;countLists(l)= { 0, if l is an atom
;               {1+ sum(countLists(li)), i=1.n   , if l is list & check(l)
;               {sum(countLists(li)), i=1,n   , if l is list and not check(l)

(defun countLists (l)
  (cond
      ((atom l)  0)
      ((check l) (+ 1 (apply '+ (mapcar #'countLists l))))
      ( t  (apply '+ (mapcar #'countLists l)))
   )
)

; transform - remove atomsa anf flatten list
;(G (5 H) 7 D) -  ((5) 7)  -> (5 7) 

;transf(l1l2..ln)={

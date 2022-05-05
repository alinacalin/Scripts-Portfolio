; fact(n)={ 1, if n=0
;         { n* fact(n-1), otherwise

(defun f1 (n)
  (cond 
      ((zerop n)  1 )
      ( t (* n (f1 (- n 1)))  )
  )
)

; f2(n, c)={ c, n=0
;          {f2(n-1, n*c), otherwise
; f2(n,1)

(defun f2 ( n c)
 (cond
    ((zerop n) c)
    ( t (f2 (- n 1) (* n c)))
)) 

;1. Define a function in Lisp which merges, without keeping the doubles, two sorted linear lists.

;mymerge(l1l2..ln, k1k2..km)={ l1l2..ln, m=0
;                            { k1k2..km, n=0
;             { l1 U mymerge(l2..ln, k2..km)  , if l1=k1
;             { l1 U mymerge(l2..ln, k1..km)  , if l1<k1
;             { k1 U mymerge(l1..ln, k2..km), otherwise

(defun mymerge1 ( l k)
  (cond 
      ((null l) k  )
      ((null k) l  )
      ((equal ( car l) (car k))  (cons (car l) (mymerge1 (cdr l) (cdr k))))
      ((< (car l) (car k))       (cons (car l) (mymerge1 (cdr l) k)))
      ( t                        (cons (car k) (mymerge1 l (cdr k))))
  )
)

;2. Define a function to remove all the occurrences of an element from a nonlinear list.
;(1 2 3(2 4 5) 4 ((352) 1 (2 3 4(1 2 ))) 4)

; removeAll(l1l2.ln, e)={ [] , if n=0
;           { removeAll(l1, e) U removeAll(l2..ln, e) , if l1 is a list
;           { removeAll(l2..ln, e) , if l1 atom and l1=e
;           { l1 U removaAll(l2..ln, e), otherwise 

(defun remAll (l e)
  (cond
     ( (null l)   nil)
     ( (listp (car l))    (cons (remAll (car l) e) (remAll (cdr l) e)))
     ( (equal e (car l))  (remAll (cdr l) e))
     (  t                 (cons (car l) (remAll (cdr l) e)))
  )
)

;  3. Build a list with the positions of the minimum number from a linear list.  

; minim(l1l2..ln, m)={m , if L=[]
;                    {minim(l2..ln, l1) , if l1<m
;                    {minim(l2..ln, m), otherwise


; minim(l1l2..ln, l1 ) (n>0, list is num)

(defun minim2 ( l m)
  (cond
      ( (null l) m )
      ( (< (car l) m)   (minim2 (cdr l) (car l)))
      (  t              (minim2 (cdr l) m))
 )
)


;pos(l1l2..ln, e, p)={ [], if L=[]
;                    { p U pos(l2..ln, e, p+1)  , if l1=e
;                    { pos(l2..ln, e, p+1), otherwise


;pos(L,e, 1)

(defun pos2 (l e p)
  (cond
      ( (null l) nil )
      ( (equal (car l ) e)   (cons p (pos2 (cdr l) e (+ p 1))))
      ( t                    (pos2 (cdr l) e (+ p 1)))
))

;mainPos(l1l2..ln)= pos2(l1l2..ln, minim(l1l2..ln, l1), 1 )

(defun mainPos ( l )
 (pos2 l (minim2 l (car l)) 1 )
)


;mainPos2( l1l2..ln, minC , posMinC,  p)=
;   {  posMinC , if n=0
;   {  mainPos2(l2..ln, minC, posMinC, p+1), if l1 is not a numerical atom 
;   {  mainPos2(l2..ln, l1, [p], p+1) , if minC is a nonnumerial atom
;   {  mainPos2(l2..ln, minC, posMinC U p, p+1)   , if l1 = minC
;   {  mainPos2(l2..ln, l1, [p], p+1)  , if l1< minC
;   {  mainPos2(l2..ln, minC, posMinC, p+1) if l1> minC

;    mainPos2(l1l2..ln, l1  ,[]  , 1)

;(E 1 2 A 5 7 B 2 3 1 3 T 1 9)

(defun mainPos2 (l m posList p)
  (cond
      ( (null l) posList )
      ( (not (numberp (car l))) (mainPos2 (cdr l) m posList (+ p 1)))
      ( (not (numberp m))       (mainPos2 (cdr l) (car l) (list p) (+ p 1)))
      ( (equal (car l) m)       (mainPos2 (cdr l) m (append posList (list p)) (+ p 1)  ))
      ( (< (car l) m)           (mainPos2 (cdr l) (car l) (list p) (+ p 1)))
      (  t                      (mainPos2 (cdr l) m posList (+ p 1)))
 )
)

(defun wrapper (l)
 (mainPos2  l (car l) nil 1)
)
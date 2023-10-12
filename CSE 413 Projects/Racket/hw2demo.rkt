Welcome to DrRacket, version 8.8 [cs].
Language: racket, with debugging; memory limit: 128 MB.
> (lengtht '())
0
> (lengtht '(1))
1
> (lengtht '(1 2 3))
3
> (lengtht2 '())
0
> (lengtht2 '(1))
1
> (lengtht2 '(1 2 3))
3
> (poly 0 '(0))
0
> (poly 0 '(1))
1
> (poly 1 '(0))
0
> (poly 3 '(1 2 3))
34
> (poly 3 '(0 0 1 0 0))
9
> (define (square n) (* n n))
  (define (cube n) (* n n n))
> (apply-all (list sqrt square cube) 4)
'(2 16 64)
> (apply-all '() 4)
'()
> ((all-are positive?) '(1 2 3 4))
#t
> ((all-are even?) '(2 4 5 6 8))
#f
> ((all-are even?) '(2 4 6 8))
#t
> ((all-are positive?) '(-1 2 3 4))
#f
> ((all-are positive?) '())
#t
> (make-expr 1 '+ 2)
'(1 + 2)
> (operator (make-expr 1 '+ 2))
'+
> (left-op (make-expr 1 '+ 2))
1
> (right-op (make-expr 1 '+ 2))
2
> (make-expr '(6 * 3) '+ '(5 - 2))
'((6 * 3) + (5 - 2))
> (left-op (make-expr '(6 * 3) '+ '(5 - 2)))
'(6 * 3)
> (right-op (make-expr '(6 * 3) '+ '(5 - 2)))
'(5 - 2)
> (operator (make-expr '(6 * 3) '+ '(5 - 2)))
'+
> (preorder (make-expr '(6 * 3) '+ '(5 - 2)))
'(+ (* 6 3) (- 5 2))
> (postorder (make-expr '(6 * 3) '+ '(5 - 2)))
'((6 3 *) (5 2 -) +)
> (inorder (make-expr '(6 * 3) '+ '(5 - 2)))
'((6 * 3) + (5 - 2))
> (preorder (make-expr 1 '+ 2))
'(+ 1 2)
> (postorder (make-expr 1 '+ 2))
'(1 2 +)
> (inorder (make-expr 1 '+ 2))
'(1 + 2)
> (define test-expr (make-expr (make-expr 1 '+ 2) '- (make-expr 3 '+ 4)))
> (preorder test-expr)
'(- (+ 1 2) (+ 3 4))
> (postorder test-expr)
'((1 2 +) (3 4 +) -)
> (inorder test-expr)
'((1 + 2) - (3 + 4))
> (eval-tree (make-expr 1 '+ 2))
3
> (eval-tree (make-expr '(6 * 3) '+ '(5 - 2)))
21
> (eval-tree test-expr)
-4
> (map-leaves even? test-expr)
'((#f + #t) - (#f + #t))
> (map-leaves square test-expr)
'((1 + 4) - (9 + 16))
> (map-leaves cube (make-expr 1 '+ 2))
'(1 + 8)
> 
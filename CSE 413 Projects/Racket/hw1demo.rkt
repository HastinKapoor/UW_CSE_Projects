Welcome to DrRacket, version 8.8 [cs].
Language: racket, with debugging; memory limit: 128 MB.
> (comb 0 0)
1
> (comb 1 1)
1
> (comb 4 0)
1
> (comb 4 2)
6
> (comb 4 4)
1
> (zip '(a b) '())
'(a b)
> (zip '() '(a b))
'(a b)
> (zip '() '())
'()
> (zip '(a b) '(c d))
'(a c b d)
> (zip '(a b) '(w x y z))
'(a w b x y z)
> (zip '(w x y z) '(a b))
'(w a x b y z)
> (unzip '(a b c d e f))
'((a c e) (b d f))
> (unzip '(a b c d e))
'((a c) (b d e))
> (unzip '())
'(() ())
> (unzip '(a))
'(() (a))
> (expand '())
'()
> (expand '(a))
'(a)
> (expand '((3 a)))
'(a a a)
> (expand '((0 a)))
'()
> (expand '(a (3 b) (3 a) b (2 c) (3 a)))
'(a b b b a a a b c c a a a)
> (value '(1 (2 () ()) (3 () ())))
1
> (left '(1 (2 () ()) (3 () ())))
'(2 () ())
> (right '(1 (2 () ()) (3 () ())))
'(3 () ())
> (size '())
0
> (size '(1 () ()))
1
> (size '(1 (2 () ()) (3 () ())))
3
> (size '(1 (2 () ()) ()))
2
> (contains 1 '())
#f
> (contains 1 '(1 (2 () ()) (3 () ())))
#t
> (contains 0 '(1 (2 () ()) (3 () ())))
#f
> (contains 2 '(1 (2 () ()) ()))
#t
> (contains 3 '(1 (2 () ()) (3 () ())))
#t
> (leaves '())
'()
> (leaves '(1 ()()))
'(1)
> (leaves '(1 (2 () ()) (3 () ())))
'(2 3)
> (leaves '(1 (2 () ()) ()))
'(2)
> (isBST '())
#t
> (isBST '(1 () ()))
#t
> (isBST '(1 (2 () ()) (3 () ())))
#f
> (isBST '(1 (0 () ()) (3 () ())))
#t
> (isBST '(1 (2 () ()) ()))
#f
> (isBST '(1 (0 () ()) ()))
#t
> (isBST '(1 () (3 (2 () ()) ())))
#t
> (isBST '(1 () (3 (0 () ()) ())))
#f
> 
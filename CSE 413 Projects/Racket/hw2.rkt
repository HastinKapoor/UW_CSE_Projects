;; Hastin Kapoor
;; 2061247

#lang racket

(provide (all-defined-out))

;; (lengtht lst)
;; Computes the length of a list tail recursively.
(define (lengtht lst)
  (lengthtaux lst 0))

;; Auxillary function for lengtht
(define (lengthtaux lst acc)
  (if (null? lst)
      acc
      (lengthtaux (cdr lst) (+ 1 acc))))

;; (lengtht2 lst)
;; Computes the length of a list tail recursively using a locally defined helper function.
(define (lengtht2 lst)
  (letrec ([aux (lambda (lst acc)
                  (if (null? lst)
                      acc
                      (aux (cdr lst) (+ 1 acc))))])
    (aux lst 0)))

;; (poly x coeff)
;; Computes poly by calculating a_0 + x * (a_1 + x * (...(a_n-1 + x * (a_n))...)),
;; using n multiplies and n additions for a degree n polynomial, thus O(n).
(define (poly x coeff)
  (if (null? coeff)
      0
      (+ (car coeff) (* x (poly x (cdr coeff))))))

;;(apply-all lst x)
;; Returns a list of the values returned when the functions of lst are applied to x.
(define (apply-all lst x)
  (if (null? lst)
      '()
      (cons ((car lst) x) (apply-all (cdr lst) x))))

;; ((all-are f) lst)
;; Returns a function which takes a predicate f and returns whether each value of the list satisfys f.
(define all-are
  (lambda (f)
    (lambda (lst)
      (if (null? lst)
          #t
          (and (f (car lst)) ((all-are f) (cdr lst)))))))

;; (make-expr left-op operator right-op)
;; Returns an infix notation expression of the operator applied to left-op and right-op.
(define (make-expr left-op operator right-op) (list left-op operator right-op))

;; (operator '(left-op operator right-op))
;; Returns the operator of an expression.
(define (operator expr) (cadr expr))

;; (left-op '(left-op operator right-op))
;; Returns the left operator of an expression.
(define (left-op expr) (car expr))

;; (right-op '(left-op operator right-op))
;; Returns the right operator of an expression.
(define (right-op expr) (caddr expr))

;; (preorder  expr-tree)
;; Returns the expression tree using prefix notation.
(define (preorder  expr-tree)
  (if (number? expr-tree)
      expr-tree
      (list (operator expr-tree) (preorder (left-op expr-tree)) (preorder (right-op expr-tree)))))

;; (postorder  expr-tree)
;; Returns the expression tree using postfix notation.
(define (postorder  expr-tree)
  (if (number? expr-tree)
      expr-tree
      (list (postorder (left-op expr-tree)) (postorder (right-op expr-tree)) (operator expr-tree))))

;; (inorder  expr-tree)
;; Returns the expression tree using infix notation.
(define (inorder  expr-tree)
  (if (number? expr-tree)
      expr-tree
      (list (inorder (left-op expr-tree)) (operator expr-tree) (inorder (right-op expr-tree)))))

;; (eval-tree expr-tree)
;; Returns the value of the expression tree when it is evaluated.
(define (eval-tree expr-tree)
  (eval (preorder expr-tree)))

;; (map-leaves f expr-tree)
;; Returns the resulting expression tree where f is applied to each value in the tree.
(define (map-leaves f expr-tree)
  (if (number? expr-tree)
      (f expr-tree)
      (list (map-leaves f (left-op expr-tree)) (operator expr-tree) (map-leaves f (right-op expr-tree)))))
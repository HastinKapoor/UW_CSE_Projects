;;Hastin Kapoor
;;2061247

#lang racket

(provide (all-defined-out))

;;Helper function for (comb n k).
(define (factorial n)
  (if (< n 2)
      1
      (* n (factorial (- n 1)))))

(define (comb n k)
  (/ (factorial n) (* (factorial k) (factorial (- n k)))))

(define (zip a b)
  ;;If either is null, return the other. Otherwise, return the first elements of the lists appended to the zip of their cdr's.
  (cond [(null? a) b]
        [(null? b) a]
        [else (cons (car a) (cons (car b) (zip (cdr a) (cdr b))))]))

(define (unzip a)
  ;;Check if there are at least 2 elements, then split them and repeat on the cddr.
  (cond [(null? a) (list '() '())]
        [(null? (cdr a)) (list '() a)]
        [else (list (cons (car a) (car (unzip (cddr a)))) (cons (cadr a) (cadr (unzip (cddr a)))))]))

;;Helper function for (expand lst).
(define (expandHelper n a)
  (if (eqv? n 0)
      '()
      (cons a (expandHelper (- n 1) a))))

(define (expand lst)
  ;;If it's empty, return. If the first element is a list, append its expansion. Otherwise, append it to the expansion of the cdr.
  (cond [(null? lst) lst]
        [(list? (car lst)) (append (expandHelper (caar lst) (cadar lst)) (expand (cdr lst)))]
        [else (cons (car lst) (expand (cdr lst)))]))

(define (value node)
  (car node))

(define (left node)
  (cadr node))

(define (right node)
  (caddr node))

(define (size tree)
  (if (null? tree)
      0
      (+ 1 (size (left tree)) (size (right tree)))))

(define (contains item tree)
  ;;False if the current node is null, true if its value is equal to item, search subtrees otherwise.
  (cond [(null? tree) #f]
        [(equal? item (value tree)) #t]
        [else (or (contains item (left tree))(contains item (right tree)))]))

(define (leaves tree)
  ;;If tree is null return null, if it's a leaf return its value, otherwise return the leaves of its subtrees.
  (cond [(null? tree) '()]
        [(and (null? (left tree)) (null? (right tree))) (list (value tree))]
        [else (append (leaves (left tree))(leaves (right tree)))]))

;;Helper method for isBST
(define (BSTmax tree)
  (if (null? (right tree))
      (value tree)
      (BSTmax (right tree))))

;;Helper method for isBST
(define (BSTmin tree)
  (if (null? (left tree))
      (value tree)
      (BSTmin (left tree))))

(define (isBST tree)
  ;;If it's null, it's a BST. Otherwise, the subtrees should be BSTs,
  ;;the left subtree should have it's largest element smaller than or equal to the current node's value, and
  ;;the right subtree should have it's smallest element larger than or equal to the current node's value.
  (cond [(null? tree) #t]
        [(and (not (null? (left tree))) (>= (BSTmax (left tree)) (value tree))) #f]
        [(and (not (null? (right tree))) (<= (BSTmin (right tree)) (value tree))) #f]
        [(or (not (isBST (left tree))) (not (isBST (right tree)))) #f]
        [else #t]))
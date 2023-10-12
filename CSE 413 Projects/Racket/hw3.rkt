;; Hastin Kapoor
;; 2061247

#lang racket

(provide (all-defined-out))

;; (diff v E)
;; Differentiates functions of constants, variables, sums, products, and constant powers of variables. 
(define (diff v E)
  (cond [(number? E) 0]
        [(equal? v E) 1]
        [(symbol? E) 0]
        [else ((element1 (assoc (get-op E) diff-dispatch)) v E)]))

;; Helper for (diff-sum x E).
(define (partial-application-diff v)
  (lambda (E)
    (diff v E)))

;; Calculates the derivative of a sum.
(define (diff-sum x E)
  (make-sum (map (partial-application-diff x) (elements-of E))))

;; Calculates the derivative of a product.
(define (diff-product x E)
  (make-sum (list (make-product (element1 E) (diff x (element2 E))) (make-product (diff x (element1 E)) (element2 E)))))

;; Calculates the derivative of a variable raised to a constant power.
(define (diff-expt x E)
  (cond [(or (not (equal? x (element1 E))) (equal? 0 (element2 E))) 0]
        [else (make-product (element2 E) (make-expt x (- (element2 E) 1)))]))

;; Dispatch Table of supported operators.
(define diff-dispatch
  (list (list '+ diff-sum)
        (list '* diff-product)
        (list 'expt diff-expt)
        ))

;; Style functions
(define (get-op E) (car E))
(define (element1 E) (cadr E))
(define (element2 E) (caddr E))
(define (elements-of E) (cdr E))
(define (make-sum alist) (cons '+ alist))
(define (make-product x y) (list '* x y))
(define (make-expt x y) (list 'expt x y))
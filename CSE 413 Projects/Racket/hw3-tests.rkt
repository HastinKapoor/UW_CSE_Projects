;; Hastin Kapoor
;; 2061247

#lang racket

(require rackunit)
(require "hw3.rkt")

(check-equal? (diff 'x 4) 0 "Differentiating a base case - constant")
(check-equal? (diff 'x 'x) 1 "Differentiating a base case - variable")
(check-equal? (diff 'x 'y) 0 "Differentiating a base case - constant variable")
(check-equal? (diff 'x '(+ x (* x x))) '(+ 1 (+ (* x 1) (* 1 x))) "Differentiating addition of two terms - base case plus function")
(check-equal? (diff 'x '(+ 1 x y)) '(+ 0 1 0) "Differentiating addition of more than two operands - adding base cases")
(check-equal? (diff 'x '(+ (+ 1 x) (+ x y) (+ 2 y))) '(+ (+ 0 1) (+ 1 0) (+ 0 0)) "Differentiating addition of more than two operands - nested additions")
(check-equal? (diff 'x '(* 2 x)) '(+ (* 2 1) (* 0 x)) "Differentiating multiplication of base cases - constant times variable")
(check-equal? (diff 'y '(* 2 x)) '(+ (* 2 0) (* 0 x)) "Differentiating multiplication of base cases - constant times constant variable")
(check-equal? (diff 'x '(* y x)) '(+ (* y 1) (* 0 x)) "Differentiating multiplication of base cases - constant variable times variable")
(check-equal? (diff 'x '(* (+ x 1) (* x y))) '(+ (* (+ x 1) (+ (* x 0) (* 1 y))) (* (+ 1 0) (* x y))) "Differentiating multiplication - nested multiplication times addition")
(check-equal? (diff 'x '(expt x 4)) '(* 4 (expt x 3)) "Differentiating exponent - variable to nonzero power")
(check-equal? (diff 'x '(expt y 4)) 0 "Differentiating exponent - constant variable")
(check-equal? (diff 'x '(expt x 0)) 0 "Differentiating exponent - variable to zero power")
(check-equal? (diff 'x '(expt y 0)) 0 "Differentiating exponent - constant variable to zero power")
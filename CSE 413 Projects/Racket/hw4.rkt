;; Hastin Kapoor
;; 2061247

#lang racket

(provide (all-defined-out))

(define (red-blue)
  (letrec ([red (lambda () (cons "red" (lambda () (blue))))]
           [blue (lambda () (cons "blue" (lambda () (red))))])
    (red)))

(define (take st n)
  (if (= n 0)
      '()
      (cons (car (st)) (take (cdr (st)) (- n  1)))))

(define combm
  (letrec ([memo '()]
           [fact (lambda (x)
                   (if (= x 0)
                       1
                       (* x (fact (- x 1)))))]
           [f (lambda (n k)
                (let ([ans (assoc (list n k) memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (/ (fact n) (* (fact k) (fact (- n k))))])
                        (begin
                          (set! memo (cons (cons (list n k) new-ans) memo))
                          new-ans)))))])
    f))
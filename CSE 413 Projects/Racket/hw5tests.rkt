;; Hastin Kapoor
;; 2061247

;; CSE413 23sp, Programming Languages & Implementation
;; Homework 5 tests

#lang racket

(require "hw5.rkt")

; This file uses Racket's unit-testing framework.

; Note we have provided [only] 3 tests, but you can't
; run them until do some of the assignment.
; You will want to add more tests.

(require rackunit)

(define tests
  (test-suite
   "Homework 5 Tests"

   (check-equal? (racketlist->mupllist '()) (munit) "racketlist->mupllist - empty list")
   (check-equal? (racketlist->mupllist (list (int 1))) (apair (int 1) (munit)) "racketlist->mupllist - list of one element")
   (check-equal? (racketlist->mupllist (list (int 1) (int 2) (int 3))) (apair (int 1) (apair (int 2) (apair (int 3) (munit)))) "racketlist->mupllist - list of multiple elements")

   (check-equal? (mupllist->racketlist (munit)) '() "mupllist-racketlist - empty list")
   (check-equal? (mupllist->racketlist (apair (int 1) (munit))) (list (int 1)) "mupllist-racketlist - list of a single element")
   (check-equal? (mupllist->racketlist (apair (int 1) (apair (int 2) (apair (int 3) (munit))))) (list (int 1) (int 2) (int 3)) "mupllist-racketlist - list of multiple elements")

   (check-equal? (eval-exp (int 1)) (int 1) "int evaluates to itself")
   
   (check-equal? (eval-exp (add (int 2) (int 2))) (int 4) "add simple test")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL addition applied to non-number"))
              (lambda () (eval-exp (add (int 2) (munit))))
              "add bad argument")

   (check-equal? (eval-exp (isgreater (int 1) (int 0))) (int 1) "isgreater - e1 > e2 returns (int 1)")
   (check-equal? (eval-exp (isgreater (int 0) (int 1))) (int 0) "isgreater - e1 < e2 returns (int 0)")
   (check-equal? (eval-exp (isgreater (int 0) (int 0))) (int 0) "isgreater - e1 = e2 returns (int 0)")
   
   (check-exn (lambda (x) (string=? (exn-message x) "MUPL isgreater applied to non-number"))
              (lambda () (eval-exp (isgreater (int 2) (munit))))
              "isgreater - bad argument")

   (check-equal? (eval-exp (ifnz (int 0) (int 4) (int 5))) (int 5) "ifnz - e1 = 0")
   (check-equal? (eval-exp (ifnz (int 1) (int 4) (int 5))) (int 4) "ifnz - e1 != 0")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL ifnz applied to non-number"))
              (lambda () (eval-exp (ifnz (munit) (int 4) (int 5))))
              "ifnz - bad argument")

   (check-equal? (eval-exp (mlet "x" (int 1) (var "x"))) (int 1) "mlet - adds var to environment with associated value")
   (check-equal? (eval-exp (mlet "x" (add (int 1) (int 2)) (add (int 3) (var "x")))) (int 6) "mlet - mlet evaluates e and adds variable value pair to environment")

   (check-equal? (eval-exp (fun "f" "x" (add (var "x") (int 1)))) (closure '() (fun "f" "x" (add (var "x") (int 1)))) "fun - evaluates to a closure")
   (check-equal? (eval-exp (mlet "x" (int 1) (fun "f" "y" (add (var "x") (var "y"))))) (closure (list (cons "x" (int 1))) (fun "f" "y" (add (var "x") (var "y")))) "fun - closure contains proper environment")

   (check-equal? (eval-exp (call (fun "f" "x" (var "x")) (int 2))) (int 2) "call - attaches variable value pair to environment before evaluating function body")
   (check-equal? (eval-exp (mlet "x" (int 1) (call (fun "f" "y" (add (var "x") (var "y"))) (int 2)))) (int 3) "call - pulls proper values from environment")
   (check-equal? (eval-exp (mlet "x" (int 1) (call (fun "f" "x" (add (var "x") (var "x"))) (int 2)))) (int 4) "call - pulls proper values from environment when values overriden")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL call applied to non-function"))
              (lambda () (eval-exp (call (int 0) (int 1))))
              "call - bad argument")

   
   (check-equal? (eval-exp (apair (int 1) (int 2))) (apair (int 1) (int 2)) "apair - creates a pair with appropriate elements in correct order")
   (check-equal? (eval-exp (apair (add (int 1) (int 2)) (int 4))) (apair (int 3) (int 4)) "apair - evaluates values before creating pair")

   (check-equal? (eval-exp (first (apair (int 1) (int 2)))) (int 1) "first - returns first element of a MUPL pair")
   (check-equal? (eval-exp (first (apair (int 1) (apair (int 2) (apair (int 3) (munit)))))) (int 1) "first - returns first element of a MUPL list")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL first applied to non-apair"))
              (lambda () (eval-exp (first (int 1))))
              "first - bad argument")

   (check-equal? (eval-exp (second (apair (int 1) (int 2)))) (int 2) "second - returns second element of a MUPL pair")
   (check-equal? (eval-exp (second (apair (int 1) (apair (int 2) (apair (int 3) (munit)))))) (apair (int 2) (apair (int 3) (munit))) "second - returns the cdr of a MUPL list")

   (check-exn (lambda (x) (string=? (exn-message x) "MUPL second applied to non-apair"))
              (lambda () (eval-exp (second (int 1))))
              "second - bad argument")

   (check-equal? (eval-exp (ismunit (munit))) (int 1) "ismunit - returns (int 1) when passed (munit)")
   (check-equal? (eval-exp (ismunit (int 1))) (int 0) "ismunit - returns (int 0) when not passed (munit)")

   (check-equal? (eval-exp (ifmunit (munit) (int 2) (int 3))) (int 2) "ifmunit - returns e2 when e1 is (munit)")
   (check-equal? (eval-exp (ifmunit (int 1) (int 2) (int 3))) (int 3) "ifmunit - returns e3 when e1 is not (munit)")

   (check-equal? (eval-exp (mlet* (list (cons "a" (int 1))) (var "a"))) (int 1) "mlet* - one variable value pair")
   (check-equal? (eval-exp (mlet* (list (cons "a" (int 1)) (cons "b" (int 2))) (add (var "a") (var "b")))) (int 3) "mlet* - two variable value pairs")
   
   (check-equal? (eval-exp (ifeq (int 1) (int 1) (int 3) (int 4))) (int 3) "ifeq - returns e3 when e1 and e2 are int and are equal")
   (check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (int 4))) (int 4) "ifeq - returns e4 when e1 and e2 are int and are not equal")

   (check-equal? (eval-exp (call (call mupl-filter (fun null "x" (ifnz (var "x") (int 1) (int 0)))) (apair (int 0) (apair (int 1) (apair (int 2) (apair (int 0) (munit))))))) (apair (int 1) (apair (int 2) (munit))) "mupl-filter - filtering nonzero values")
   (check-equal? (eval-exp (call (call mupl-filter (fun null "x" (ifnz (var "x") (int 1) (int 0)))) (apair (int 0) (apair (int 0) (apair (int 0) (apair (int 0) (munit))))))) (munit) "mupl-filter - empty return")

   (check-equal? (eval-exp (call (call mupl-all-gt (int 0)) (apair (int 0) (apair (int 1) (apair (int 2) (apair (int 0) (munit))))))) (apair (int 1) (apair (int 2) (munit))) "mupl-all-gt - greater than (int 0)")
   (check-equal? (eval-exp (call (call mupl-all-gt (int 5)) (apair (int 0) (apair (int 1) (apair (int 2) (apair (int 0) (munit))))))) (munit) "mupl-all-gt - empty return")
   
   (check-exn (lambda (x) (string=? (exn-message x) "MUPL ifeq applied to non-numbers"))
              (lambda () (eval-exp (ifeq (int 1) (munit) (int 3) (int 4))))
              "ifeq - bad argument")
   
   (check-equal? (mupllist->racketlist
                  (eval-exp (call (call mupl-all-gt (int 9))
                                  (racketlist->mupllist
                                   (list (int 10) (int 9) (int 15))))))
                 (list (int 10) (int 15))
                 "provided combined test using problems 1, 2, and 4")
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
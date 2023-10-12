;; Hastin Kapoor
;; 2061247

#lang racket

(require rackunit)
(require "hw4.rkt")

(check-equal? (car (red-blue)) "red" "Car of the first cons cell of red-blue is 'red'")
(check-equal? (car ((cdr (red-blue)))) "blue" "Car of the second cons cell of red-blue is 'blue' - red nested function calls for blue after itself")
(check-equal? (car ((cdr ((cdr (red-blue)))))) "red" "Car of the third cons cell of red-blue is 'red' - blue nested function calls for red after itself")

(check-equal? (take red-blue 0) '() "Returns empty list when called to list first zero elements of the stream")
(check-equal? (take red-blue 1) '("red") "Returns a list containing the first element of the stream")
(check-equal? (take red-blue 10) '("red" "blue" "red" "blue" "red" "blue" "red" "blue" "red" "blue") "Returns the first ten elements in the correct order when called to return ten elements")

(check-equal? (combm 0 0) 1 "Factorial base cases - 0! = 1")
(check-equal? (combm 5 0) 1 "Combinations edge case - n choose 0")
(check-equal? (combm 5 5) 1 "Combinations edge case - n choose n")
(check-equal? (combm 9 5) 126 "Non base case or edge case - 9 choose 5")
(check-equal? (list (combm 7 4) (combm 7 4)) '(35 35) "Returns the same value when called with the same parameters twice - memoization")
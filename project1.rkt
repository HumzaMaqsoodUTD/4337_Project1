; main
; eval-loop
; eval-expression

#lang racket

(require "mode.rkt")

;; main entry point
(define (main)
  (eval-loop '()))

;; main evaluation loop
(define (eval-loop history)
  (if prompt?
      (display "> ")
      (void))
  
  (let ([line (read-line)])
    (cond
      [(eof-object? line) (void)]
      [(string=? line "quit") (void)]
      [else
       ;; evaluation logic will be added later
       (displayln "Error: Invalid Expression")
       (eval-loop history)])))

;; placeholder for expression evaluation
(define (eval-expression chars history)
  ;; implementation will be added later
  #f)

(main)

; main
; eval-loop
; eval-expression

#lang racket

;; Load mode.rkt without modifying it
(dynamic-require "mode.rkt" 0)
(define mode-ns (module->namespace "mode.rkt"))
(define prompt?
  (parameterize ([current-namespace mode-ns])
    (namespace-variable-value 'prompt?)))

;; skip leading whitespace
(define (skip-whitespace chars)
  (cond
    [(null? chars) chars]
    [(char-whitespace? (car chars))
     (skip-whitespace (cdr chars))]
    [else chars]))

;; parse a sequence of digits
;; returns: (list value remaining-chars)
(define (parse-number chars)
  (define (collect digits rest)
    (cond
      [(and (not (null? rest)) (char-numeric? (car rest)))
       (collect (cons (car rest) digits) (cdr rest))]
      [else
       (list (string->number (list->string (reverse digits))) rest)]))
  (collect '() chars))

;; look up a value from history by id
(define (history-ref n history)
  (if (or (< n 1) (> n (length history)))
      #f
      (list-ref (reverse history) (- n 1))))

;; parse a history reference like $1 or $2
(define (parse-history chars history)
  (define (collect digits rest)
    (cond
      [(and (not (null? rest)) (char-numeric? (car rest)))
       (collect (cons (car rest) digits) (cdr rest))]
      [else
       (if (null? digits)
           #f
           (let* ([num (string->number (list->string (reverse digits)))]
                  [val (history-ref num history)])
             (if val
                 (list val rest)
                 #f)))]))
  (collect '() (cdr chars)))

;; unary negation
(define (eval-negate chars history)
  (let* ([rest (skip-whitespace (cdr chars))]
         [result (eval-expression rest history)])
    (if result
        (list (- (first result)) (second result))
        #f)))

;; binary addition
(define (eval-plus chars history)
  (let* ([rest (skip-whitespace (cdr chars))]
         [left-result (eval-expression rest history)])
    (if (not left-result)
        #f
        (let* ([right-start (skip-whitespace (second left-result))]
               [right-result (eval-expression right-start history)])
          (if right-result
              (list (+ (first left-result) (first right-result))
                    (second right-result))
              #f)))))

;; binary multiplication
(define (eval-times chars history)
  (let* ([rest (skip-whitespace (cdr chars))]
         [left-result (eval-expression rest history)])
    (if (not left-result)
        #f
        (let* ([right-start (skip-whitespace (second left-result))]
               [right-result (eval-expression right-start history)])
          (if right-result
              (list (* (first left-result) (first right-result))
                    (second right-result))
              #f)))))

;; binary division
(define (eval-divide chars history)
  (let* ([rest (skip-whitespace (cdr chars))]
         [left-result (eval-expression rest history)])
    (if (not left-result)
        #f
        (let* ([right-start (skip-whitespace (second left-result))]
               [right-result (eval-expression right-start history)])
          (if (or (not right-result) (= (first right-result) 0))
              #f
              (list (quotient (first left-result) (first right-result))
                    (second right-result)))))))

;; evaluate one full input line
;; returns the final numeric value or #f if invalid
(define (evaluate-line line history)
  (let* ([chars (string->list line)]
         [result (eval-expression chars history)])
    (if result
        (let ([remaining (skip-whitespace (second result))])
          (if (null? remaining)
              (first result)
              #f))
        #f)))

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
       (let ([value (evaluate-line line history)])
         (if value
             (let ([new-history (cons value history)]
                   [id (+ (length history) 1)])
               (displayln
                (string-append
                 (number->string id)
                 ": "
                 (number->string (real->double-flonum value))))
               (eval-loop new-history))
             (begin
               (displayln "Error: Invalid Expression")
               (eval-loop history))))])))

;; expression evaluator
;; returns (list value remaining-chars) or #f on error
(define (eval-expression chars history)
  (let ([chars (skip-whitespace chars)])
    (cond
      [(null? chars) #f]
      [(char-numeric? (car chars))
       (parse-number chars)]
      [(char=? (car chars) #\$)
       (parse-history chars history)]
      [(char=? (car chars) #\-)
       (eval-negate chars history)]
      [(char=? (car chars) #\+)
       (eval-plus chars history)]
      [(char=? (car chars) #\*)
       (eval-times chars history)]
      [(char=? (car chars) #\/)
       (eval-divide chars history)]
      [else #f])))

(main)
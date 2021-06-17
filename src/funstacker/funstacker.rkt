; stacker -- functional style

#lang br/quicklang

(define (read-syntax path port)
  (datum->syntax #f `(module funstacker-module "funstacker.rkt" (handle-args ,@(format-datums '~a (port->lines port))))))

(define (handle-args . args)
  (for/fold
    ([stack-acc empty])                         ; accumulator
    ([arg (in-list args)] #:unless (void? arg)) ; iterator, skipping blank lines
    (cond [(number? arg) (cons arg stack-acc)]
          [(or (equal? * arg) (equal? + arg)) (define op-result (arg (first stack-acc) (second stack-acc))) (cons op-result (drop stack-acc 2))])))

(define-macro (funstacker-module-begin HANDLE-ARGS-EXPR) #'(#%module-begin (display (first HANDLE-ARGS-EXPR))))

(provide read-syntax)
(provide (rename-out [funstacker-module-begin #%module-begin]))
(provide handle-args)
(provide + *)

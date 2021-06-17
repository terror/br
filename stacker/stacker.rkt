#lang br/quicklang

(define (read-syntax path port)
  ; retrieve all lines from input `port`
  (define src-lines (port->lines port))

  ; format datums to include the `handle` prefix before each element in
  ; the provided list.
  ; Example:
  ; > format-datums '(~a 42) '("foo" "bar" "baz")
  ; > '((foo 42) (bar 42) (baz 42))
  (define src-datums (format-datums '(handle ~a) src-lines))

  ; define our `stacker-module` using the `stacker.rkt` expander, passing in the
  ; list of datums using `unquote-splicing` operator, merging the
  ; sublist with the surrounding list.
  (define module-datum `(module stacker-module "stacker.rkt",@src-datums))

  ; finally, convert the `module-datum` into a syntax object, aka a
  ; datum with some extra useful information
  (datum->syntax #f module-datum))

; export function `read-syntax`
(provide read-syntax)

; define a macro with a `syntax pattern`, a pattern that breaks
; down the input into pieces. Use `define-macro` for syntax pattern
; support. Use `#'` prefix to capture the current lexical context and
; attach it to the new syntax object.
(define-macro (stacker-module-begin HANDLE-EXPR ...)
              #'(#%module-begin
                 HANDLE-EXPR ...
                 (display (first stack))))

; make `stacker-module-begin` available outside of this module
(provide (rename-out [stacker-module-begin #%module-begin]))

; initialize our stack as an empty list
(define stack empty)

; push `arg` onto the stack
(define (push-stack! arg)
  (set! stack (cons arg stack)))

; pops and returns the top of the stack
(define (pop-stack!)
  (define arg (first stack))
  (set! stack (rest stack))
  arg)

(define (handle [arg #f]) ; note: the `#f` implies `arg` is optional
  (cond
    ; push this arg onto the stack if it's a number
    [(number? arg) (push-stack! arg)]

    ; check if `arg` is equal to one of our stack operators, `+` or `*`,
    ; if so, pop the top two values from the stack and push the
    ; resulting value from `arg` applied to those values on top of the
    ; stack.
    [(or (equal? + arg) (equal? * arg))
     (define op-result (arg (pop-stack!) (pop-stack!)))
     (push-stack! op-result)]))

; export `handle`
(provide handle)

; add binding for our operators, `+` and `*`
(provide + *)

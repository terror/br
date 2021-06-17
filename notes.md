### Unstructured notes

I.

- Why make languages?
  - Learn how things work

  - Start thinking about languages as open-ended and malleable

  - Enlarge the solution space
    - For problems that don't mesh with the language idiom
    - A solution can be tailored to the problem

  - Some programs naturally describe languages
    - A large set of inputs but a small scope of outputs
    - i.e: Large set of files -> Simple representation

  - Better glue

  - Increase skill as a programmer

II.

- What is a programming language?
  - Just another program
    - Often called a `compiler` or `interpreter`

  - Input -> Computation -> Output

  - A function is just a domain-specific language with a tiny domain

  - A tool for discovering new ways to program

  - DSL's
    - A language tailored to the needs of a set of problems.
    - Stuff like SQL, CSS/HTML, TeX, awk, bash, lex/yacc, make, just

III.

- How are languages implemented in Racket?
  1. Design the notation and behaviour

  2. Write a Racket program that converts the source code of the new language into Racket.

  3. Run the Racket program.

  - Essentially just a `transpiler`

IV.

- The components of a language
  - Reader
    - Converts the source code of our language -> S-expressions
  - Expander
    - Adds meaning to these S-expressions, which are then evaluated

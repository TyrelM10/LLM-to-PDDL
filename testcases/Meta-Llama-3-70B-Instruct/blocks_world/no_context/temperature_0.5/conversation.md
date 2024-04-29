**USER** :
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.
 
 Instruction: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. This code should be solved in a STRIPS Planner. Do not give any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:actions
    (move-block-to-table
      :parameters (?block)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      :parameters (?block?target)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      :parameters (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      :parameters (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
  )
)

```
**USER** :
```pddl

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:actions
    (move-block-to-table
      :parameters (?block)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      :parameters (?block?target)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      :parameters (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      :parameters (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
  )
)

```
 
 The above code produces the following error: There is a value error on finding unknown keyword in domain definition: 'actions'. Remove the keyword 'actions' from definition, keep the rest of code the same.
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:parameters 
  )
  (move-block-to-table
      :parameters (?block)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      :parameters (?block?target)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      :parameters (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      :parameters (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
)

```
**USER** :
```pddl

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:parameters 
  )
  (move-block-to-table
      :parameters (?block)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      :parameters (?block?target)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      :parameters (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      :parameters (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
)

```
 
 The above code produces the following error: There is a value error on finding unknown keyword in domain definition: 'parameters'. Remove the keyword 'parameters' from definition, keep the rest of code the same.
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (move-block-to-table
      (?block)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      (?block?target)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
)

```
**USER** :
```pddl

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (move-block-to-table
      (?block)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      (?block?target)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
)

```
 
 The above code produces the following error: There is a value error where keywords have to start with a colon ":"
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:actions
    (move-block-to-table
      (?block?y)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      (?block?target?y)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
  )
)

```
**USER** :
```pddl

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:actions
    (move-block-to-table
      (?block?y)
      :preconditions (and (on?block?y) (clear?block) (hand-empty))
      :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
    )
    (move-block-to-block
      (?block?target?y)
      :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
      :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
    )
    (pick-up-block-from-table
      (?block)
      :preconditions (and (on-table?block) (clear?block) (hand-empty))
      :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
    )
    (pick-up-block-from-block
      (?block?target)
      :preconditions (and (on?block?target) (clear?block) (hand-empty))
      :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
    )
  )
)

```
 
 The above code produces the following error: There is a value error on finding unknown keyword in domain definition: 'actions'. Remove the keyword 'actions' from definition, keep the rest of code the same.
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (move-block-to-table
    (?block?y)
    :preconditions (and (on?block?y) (clear?block) (hand-empty))
    :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
  )
  (move-block-to-block
    (?block?target?y)
    :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
    :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
  )
  (pick-up-block-from-table
    (?block)
    :preconditions (and (on-table?block) (clear?block) (hand-empty))
    :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
  )
  (pick-up-block-from-block
    (?block?target)
    :preconditions (and (on?block?target) (clear?block) (hand-empty))
    :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
  )
)

```
**USER** :
```pddl

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (move-block-to-table
    (?block?y)
    :preconditions (and (on?block?y) (clear?block) (hand-empty))
    :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
  )
  (move-block-to-block
    (?block?target?y)
    :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
    :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
  )
  (pick-up-block-from-table
    (?block)
    :preconditions (and (on-table?block) (clear?block) (hand-empty))
    :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
  )
  (pick-up-block-from-block
    (?block?target)
    :preconditions (and (on?block?target) (clear?block) (hand-empty))
    :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
  )
)

```
 
 The above code produces the following error: There is a value error where keywords have to start with a colon ":"
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block-to-table
    :parameters (?block?y)
    :preconditions (and (on?block?y) (clear?block) (hand-empty))
    :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
  )
  (:action move-block-to-block
    :parameters (?block?target?y)
    :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
    :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
  )
  (:action pick-up-block-from-table
    :parameters (?block)
    :preconditions (and (on-table?block) (clear?block) (hand-empty))
    :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
  )
  (:action pick-up-block-from-block
    :parameters (?block?target)
    :preconditions (and (on?block?target) (clear?block) (hand-empty))
    :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
  )
)

```
**USER** :
```pddl

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block-to-table
    :parameters (?block?y)
    :preconditions (and (on?block?y) (clear?block) (hand-empty))
    :effects (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
  )
  (:action move-block-to-block
    :parameters (?block?target?y)
    :preconditions (and (on?block?y) (clear?block) (clear?target) (hand-empty))
    :effects (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
  )
  (:action pick-up-block-from-table
    :parameters (?block)
    :preconditions (and (on-table?block) (clear?block) (hand-empty))
    :effects (and (not (on-table?block)) (clear?block) (not (hand-empty)))
  )
  (:action pick-up-block-from-block
    :parameters (?block?target)
    :preconditions (and (on?block?target) (clear?block) (hand-empty))
    :effects (and (not (on?block?target)) (clear?block) (not (hand-empty)))
  )
)

```
 
 The above code produces the following error: There is a value error where Predicate Statement must start with ":precondition" keyword and not ":preconditions."
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block-to-table
    :parameters (?block?y)
    :precondition (and (on?block?y) (clear?block) (hand-empty))
    :effect (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
  )
  (:action move-block-to-block
    :parameters (?block?target?y)
    :precondition (and (on?block?y) (clear?block) (clear?target) (hand-empty))
    :effect (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
  )
  (:action pick-up-block-from-table
    :parameters (?block)
    :precondition (and (on-table?block) (clear?block) (hand-empty))
    :effect (and (not (on-table?block)) (clear?block) (not (hand-empty)))
  )
  (:action pick-up-block-from-block
    :parameters (?block?target)
    :precondition (and (on?block?target) (clear?block) (hand-empty))
    :effect (and (not (on?block?target)) (clear?block) (not (hand-empty)))
  )
)

```
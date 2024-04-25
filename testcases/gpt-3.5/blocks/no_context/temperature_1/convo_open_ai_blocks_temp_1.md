**USER** :
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.
 
 Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.
**LLM MODEL** (CHAT_GPT):
```pddl
(define (domain blocks-world)
  (:requirements :strips)
  (:predicates 
    (on-table ?x)
    (on ?x ?y)
    (clear ?x)
    (holding ?x)
  )

  (:action pick-up
    :parameters (?x)
    :precondition (and (clear ?x) (on-table ?x))
    :effect (and (holding ?x) (not (clear ?x)) (not (on-table ?x)))
  )

  (:action put-down
    :parameters (?x)
    :precondition (holding ?x)
    :effect (and (on-table ?x) (clear ?x) (not (holding ?x)))
  )

  (:action stack
    :parameters (?x ?y)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y) (clear ?x) (not (holding ?x)))
  )

  (:action unstack
    :parameters (?x ?y)
    :precondition (and (on ?x ?y) (clear ?x))
    :effect (and (clear ?y) (holding ?x) (not (on ?x ?y)))
  )
)

```
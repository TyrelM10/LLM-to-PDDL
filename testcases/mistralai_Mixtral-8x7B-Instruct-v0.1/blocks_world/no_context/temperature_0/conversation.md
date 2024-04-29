**USER** :
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.
 
 Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. This code should be solved in a STRIPS Planner. Do not give any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl
(define (domain blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types for clarity
  (:types block)
  (:predicates
    (ontable ?x - block)        ; x is on the table
    (clear ?x - block)          ; no other block directly rests upon x
    (on ?x ?y - block)           ; x is stacked on y
    (handempty)                 ; whether or not the robot hand is empty
    (holding ?x - block))       ; what object, if anything, the robot hand holds

  ;; Actions
  (:action pick-up
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)))

  (:action put-down
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (ontable ?x) (clear ?x) (handempty) (not (holding ?x))))

  (:action stack
    :parameters (?x ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y) (clear ?x) (handempty) (not (holding ?x)) (not (clear ?y))))

  (:action unstack
    :parameters (?x ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (clear ?y) (holding ?x) (not (on ?x ?y)) (not (clear ?x)) (not (handempty)))))

```
**GPT-4 - BLOCKS WORLD**

---
**STEP 1:**
**USER:**
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-4):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types block)

  (:predicates
    (on ?x ?y - block)
    (ontable ?x - block)
    (clear ?x - block)
    (handempty)
    (holding ?x - block)
  )

  (:action pick-up
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (not (ontable ?x)) (not (handempty)) (holding ?x))
  )

  (:action put-down
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (not (holding ?x)) (ontable ?x) (handempty))
  )

  (:action stack
    :parameters (?x ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (not (holding ?x)) (not (clear ?y)) (on ?x ?y) (handempty) (clear ?x))
  )

  (:action unstack
    :parameters (?x ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (not (on ?x ?y)) (clear ?y) (holding ?x) (not (handempty)))
  )
)
```

<span style="color:green">_**NOTE:** DOMAIN WAS SUCCESSFULLY PARSED_</span>

---

**BELOW IS THE PART TO GET THE PROBLEM FROM THE LLM FOR THIS DOMAIN TO SOLVE**

**USER:**
For the above the PDDL domain code, create a problem file in PDDL that when put into a planner to solve will give valid actions and an action path to reach a goal.

**LLM MODEL (GPT-4):**
```
(define (problem blocks-problem)
  (:domain blocks-world)
  (:objects
    a b c - block
  )

  (:init
    (ontable a)
    (ontable b)
    (ontable c)
    (clear a)
    (clear b)
    (clear c)
    (handempty)
  )

  (:goal
    (and
      (on a b)
      (on b c)
    )
  )
)
```

**<span style="color:green">{'success': True, 'action_path': [<Op (pick-up b)>, <Op (stack b c)>, <Op (pick-up a)>, <Op (stack a b)>], 'message': 'Action Path Sucessfully Found.'}</span>**
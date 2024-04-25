**GPT-3.5 - Managing Context - BLOCKS WORLD** [Conversation Link](https://chat.openai.com/share/fb094d1b-2e44-4520-937e-4d91258b6fde)

---
**STEP 1:**
**USER:**
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain blocks-world)
    (:requirements :strips :typing)
    (:types block)
    (:predicates 
        (on ?b1 ?b2)    ; block ?b1 is on top of block ?b2
        (ontable ?b)    ; block ?b is on the table
        (clear ?b)      ; block ?b has nothing on top of it
    )

    (:action move
        :parameters (?b1 ?b2)
        :precondition (and 
            (clear ?b1)
            (or (ontable ?b1) (clear ?b2))
        )
        :effect (and 
            (not (ontable ?b1))
            (not (clear ?b2))
            (clear ?b1)
            (on ?b1 ?b2)
        )
    )

    (:action move-to-table
        :parameters (?b)
        :precondition (and 
            (clear ?b)
            (not (ontable ?b))
        )
        :effect (and 
            (not (on ?b ?x))
            (not (clear ?b))
            (ontable ?b)
        )
    )
)
```
---
**STEP 2:**
**USER:**
The above code produces the following error -> There is a semantic error where unknown predicate 'or' used in precondition of action. Remove 'or' from the precondition of all actions having it.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain blocks-world)
    (:requirements :strips :typing)
    (:types block)
    (:predicates 
        (on ?b1 ?b2)    ; block ?b1 is on top of block ?b2
        (ontable ?b)    ; block ?b is on the table
        (clear ?b)      ; block ?b has nothing on top of it
    )

    (:action move
        :parameters (?b1 ?b2)
        :precondition (and 
            (clear ?b1)
            (ontable ?b1)
            (clear ?b2)
        )
        :effect (and 
            (not (ontable ?b1))
            (not (clear ?b2))
            (clear ?b1)
            (on ?b1 ?b2)
        )
    )

    (:action move-to-table
        :parameters (?b)
        :precondition (and 
            (clear ?b)
            (not (ontable ?b))
        )
        :effect (and 
            (not (on ?b ?x))
            (not (clear ?b))
            (ontable ?b)
        )
    )
)
```
---
**STEP 3:**
**USER:**
The above code produces the following error -> There is a semantic error where unknown predicate 'not' used in precondition of action. Remove 'not' from the precondition of all actions having it.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain blocks-world)
    (:requirements :strips :typing)
    (:types block)
    (:predicates 
        (on ?b1 ?b2)    ; block ?b1 is on top of block ?b2
        (ontable ?b)    ; block ?b is on the table
        (clear ?b)      ; block ?b has nothing on top of it
    )

    (:action move
        :parameters (?b1 ?b2)
        :precondition (and 
            (clear ?b1)
            (ontable ?b1)
            (clear ?b2)
        )
        :effect (and 
            (not (ontable ?b1))
            (not (clear ?b2))
            (clear ?b1)
            (on ?b1 ?b2)
        )
    )

    (:action move-to-table
        :parameters (?b)
        :precondition (and 
            (clear ?b)
            (ontable ?b)
        )
        :effect (and 
            (not (on ?b ?x))
            (clear ?b)
            (ontable ?b)
        )
    )
)
```

<span style="color:green">_**NOTE:** DOMAIN WAS SUCCESSFULLY PARSED_</span>

---

**BELOW IS THE PART TO GET THE PROBLEM FROM THE LLM FOR THIS DOMAIN TO SOLVE**

**USER:**
For the above the PDDL domain code, create a problem file in PDDL that when put into a planner to solve will give valid actions and an action path to reach a goal.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (problem blocks-world-problem)
    (:domain blocks-world)
    (:objects
        block1 block2 block3
    )
    (:init
        (clear block1)
        (clear block2)
        (clear block3)
        (ontable block1)
        (ontable block2)
        (ontable block3)
    )
    (:goal (and 
        (on block1 block2)
        (on block2 block3)
    ))
)
```

**<span style="color:green">{'success': True, 'action_path': [<Op (move block2 block3)>, <Op (move block1 block2)>], 'message': 'Action Path Sucessfully Found.'}</span>**


**USER:**
For the above domain file please rewrite the domain without using ':typing' and give a new PDDL domain code.

**LLM:**
```
(define (domain blocks-world)
    (:requirements :strips)
    (:predicates 
        (on ?b1 ?b2)    ; block ?b1 is on top of block ?b2
        (ontable ?b)    ; block ?b is on the table
        (clear ?b)      ; block ?b has nothing on top of it
    )

    (:action move
        :parameters (?b1 ?b2)
        :precondition (and 
            (clear ?b1)
            (ontable ?b1)
            (clear ?b2)
        )
        :effect (and 
            (not (ontable ?b1))
            (not (clear ?b2))
            (clear ?b1)
            (on ?b1 ?b2)
        )
    )

    (:action move-to-table
        :parameters (?b)
        :precondition (and 
            (clear ?b)
            (ontable ?b)
        )
        :effect (and 
            (not (on ?b ?x))
            (clear ?b)
            (ontable ?b)
        )
    )
)
```

**<span style="color:green">{'success': True, 'action_path': [<Op (move block2 block3)>, <Op (move block1 block2)>], 'message': 'Action Path Sucessfully Found.'}</span>**

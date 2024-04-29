**Meta-Llama-3-70B-Instruct -Managing Context - BLOCKS WORLD**
_**System Prompt**: Generate PDDL domain code for natural language text descriptions. Do not add comments to the code._ [Conversation Link](https://hf.co/chat/r/BM4dTNn)

---
**STEP 1:**
**USER:**
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Meta-Llama-3-70B-Instruct):**
```
pddl
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:actions 
    (move-block 
      :parameters (?b?from?to) 
      :preconditions (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effects (and (on?b?to) (not (on?b?from)) (not (clear?to)) (not (hand-empty)))
    )
    (pick-up 
      :parameters (?b?from) 
      :preconditions (and (on?b?from) (clear?b) (hand-empty)) 
      :effects (and (not (on?b?from)) (not (clear?b)) (not (hand-empty)))
    )
    (put-down 
      :parameters (?b?to) 
      :preconditions (and (not (hand-empty)) (clear?to)) 
      :effects (and (on?b?to) (clear?b) (hand-empty))
    )
  )
)
```
---
**STEP 2:**
**USER:**
The above code produces the following error -> There was an error in parsing the code. Expected '(', got pddl.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Meta-Llama-3-70B-Instruct):**
```
pddl
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:actions 
    (move-block 
      :parameters (?b?from?to) 
      :preconditions (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effects (and (on?b?to) (not (on?b?from)) (not (clear?to)) (not (hand-empty)))
    )
    (pick-up 
      :parameters (?b?from) 
      :preconditions (and (on?b?from) (clear?b) (hand-empty)) 
      :effects (and (not (on?b?from)) (not (clear?b)) (not (hand-empty)))
    )
    (put-down 
      :parameters (?b?to) 
      :preconditions (and (not (hand-empty)) (clear?to)) 
      :effects (and (on?b?to) (clear?b) (hand-empty))
    )
  )
)
```
---
**STEP 3:**
**USER:**
The above code produces the following error -> There was an error in parsing the code. Expected '(', got pddl.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Do not give any explanations.

**LLM MODEL (Meta-Llama-3-70B-Instruct):**
```
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:actions 
    (move-block 
      :parameters (?b?from?to) 
      :preconditions (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effects (and (on?b?to) (not (on?b?from)) (not (clear?to)) (not (hand-empty)))
    )
    (pick-up 
      :parameters (?b?from) 
      :preconditions (and (on?b?from) (clear?b) (hand-empty)) 
      :effects (and (not (on?b?from)) (not (clear?b)) (not (hand-empty)))
    )
    (put-down 
      :parameters (?b?to) 
      :preconditions (and (not (hand-empty)) (clear?to)) 
      :effects (and (on?b?to) (clear?b) (hand-empty))
    )
  )
)
```
---
**STEP 4:**
**USER:**
The above code produces the following error -> There is a value error on finding unknown keyword in domain definition: 'actions'. Remove the keyword 'actions' from definition, keep the rest of code the same.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Do not give any explanations.

**LLM MODEL (Meta-Llama-3-70B-Instruct):**
```
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (move-block 
      :parameters (?b?from?to) 
      :preconditions (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effects (and (on?b?to) (not (on?b?from)) (not (clear?to)) (not (hand-empty)))
    )
    (pick-up 
      :parameters (?b?from) 
      :preconditions (and (on?b?from) (clear?b) (hand-empty)) 
      :effects (and (not (on?b?from)) (not (clear?b)) (not (hand-empty)))
    )
    (put-down 
      :parameters (?b?to) 
      :preconditions (and (not (hand-empty)) (clear?to)) 
      :effects (and (on?b?to) (clear?b) (hand-empty))
    )
)
```
---
**STEP 5:**
**USER:**
The above code produces the following error -> There is a value error where keywords have to start with a colon ":"

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Do not give any explanations.

**LLM MODEL (Meta-Llama-3-70B-Instruct):**
```
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block 
      :parameters (?b?from?to) 
      :preconditions (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effects (and (on?b?to) (not (on?b?from)) (not (clear?to)) (not (hand-empty)))
    )
    (:action pick-up 
      :parameters (?b?from) 
      :preconditions (and (on?b?from) (clear?b) (hand-empty)) 
      :effects (and (not (on?b?from)) (not (clear?b)) (not (hand-empty)))
    )
    (:action put-down 
      :parameters (?b?to) 
      :preconditions (and (not (hand-empty)) (clear?to)) 
      :effects (and (on?b?to) (clear?b) (hand-empty))
    )
)
```
---
**STEP 6:**
**USER:**
The above code produces the following error -> There is a value error where Precondition statement must start with ":precondition" keyword.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Do not give any explanations.

**LLM MODEL (Meta-Llama-3-70B-Instruct):**
```
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block 
      :parameters (?b?from?to) 
      :precondition (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effect (and (on?b?to) (not (on?b?from)) (not (clear?to)) (not (hand-empty)))
    )
    (:action pick-up 
      :parameters (?b?from) 
      :precondition (and (on?b?from) (clear?b) (hand-empty)) 
      :effect (and (not (on?b?from)) (not (clear?b)) (not (hand-empty)))
    )
    (:action put-down 
      :parameters (?b?to) 
      :precondition (and (not (hand-empty)) (clear?to)) 
      :effect (and (on?b?to) (clear?b) (hand-empty))
    )
)
```
---
**STEP 7:**
**USER:**
The above code produces the following error -> There is a semantic error where unknown predicate 'not' used in precondition of action. Remove 'not' from the precondition of all actions having it.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Do not give any explanations.

**LLM MODEL (Meta-Llama-3-70B-Instruct):**
```
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block 
      :parameters (?b?from?to) 
      :precondition (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effect (and (on?b?to) (on?b?from) (clear?to) (hand-empty))
    )
    (:action pick-up 
      :parameters (?b?from) 
      :precondition (and (on?b?from) (clear?b) (hand-empty)) 
      :effect (and (clear?b) (hand-empty))
    )
    (:action put-down 
      :parameters (?b?to) 
      :precondition (and (hand-empty) (clear?to)) 
      :effect (and (on?b?to) (clear?b) (hand-empty))
    )
)
```
<span style="color:green">_**NOTE:** DOMAIN WAS SUCCESSFULLY PARSED_</span>

---

**BELOW IS THE PART TO GET THE PROBLEM FROM THE LLM FOR THIS DOMAIN TO SOLVE**

**USER:**
For the above the PDDL domain code, create a problem file in PDDL that when put into a planner to solve will give valid actions and an action path to reach a goal.

**LLM**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    (block1 block)
    (block2 block)
    (block3 block)
    (table table)
  )
  (:init 
    (and 
      (on-table block1)
      (on-table block2)
      (on-table block3)
      (clear block1)
      (clear block2)
      (clear block3)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on block1 block2)
      (on block2 block3)
    )
  )
)
```

**USER:**
On trying to solve the above the following error was received --> There was an error in parsing the code for not a word.

Requirement: Correct the error and give a new problem file only. Do not make changes in domain code.

**LLM:**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    (b1 block)
    (b2 block)
    (b3 block)
    (t table)
  )
  (:init 
    (and 
      (on-table b1)
      (on-table b2)
      (on-table b3)
      (clear b1)
      (clear b2)
      (clear b3)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on b1 b2)
      (on b2 b3)
    )
  )
)
```

---
**USER:**
On trying to solve the above the following error was received --> There was an error in parsing the code for not a word.

Requirement: Correct the error and give a new problem file only. Do not make changes in domain code.

**LLM:**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    (block1 block)
    (block2 block)
    (block3 block)
    (the-table table)
  )
  (:init 
    (and 
      (on-table block1)
      (on-table block2)
      (on-table block3)
      (clear block1)
      (clear block2)
      (clear block3)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on block1 block2)
      (on block2 block3)
    )
  )
)
```

**USER:**
On trying to solve the above the following error was received --> There was an error in parsing the code for not a word.

Requirement: Correct the error and give a new problem file only. Try something different and new.

**LLM:**

```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    (a block)
    (b block)
    (c block)
    (d table)
  )
  (:init 
    (and 
      (on-table a)
      (on-table b)
      (on-table c)
      (clear a)
      (clear b)
      (clear c)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on a b)
      (on b c)
    )
  )
)
```

**USER:**
On trying to solve the above the following error was received --> There was an error in parsing the code for not a word. Check the structure of the code and solve.

Requirement: Correct the error and give a new problem file only. Try something different and new.

**LLM:**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    a b c d
  )
  (:types 
    block a b c
    table d
  )
  (:init 
    (and 
      (on-table a)
      (on-table b)
      (on-table c)
      (clear a)
      (clear b)
      (clear c)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on a b)
      (on b c)
    )
  )
)
```

**USER:**
On trying to solve the above the following error was received --> There is a value error when found invalid keyword when parsing :init statement.

Requirement: Correct the error and give a new problem file only. Do not make changes in domain code.

**LLM:**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    a b c d
  )
  (:types 
    block a b c
    table d
  )
  (:init 
    (and 
      (on-table a)
      (on-table b)
      (on-table c)
      (clear a)
      (clear b)
      (clear c)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on a b)
      (on b c)
    )
  )
)
```

**USER:**
On trying to solve the above the following error was received --> There is a value error when found invalid keyword when parsing :init statement.

Requirement: Correct the error and give a new problem file only.

**LLM:**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    a b c d
  )
  (:types 
    block a b c
    table d
  )
  (:init 
    (and 
      (on-table a d)
      (on-table b d)
      (on-table c d)
      (clear a)
      (clear b)
      (clear c)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on a b)
      (on b c)
    )
  )
)
```

**USER:**
On trying to solve the above the following error was received --> There is a value error when found invalid keyword when parsing :init statement. Remove the invalid keywords as you think and solve.

Requirement: Correct the error and give a new problem file only.

NOTE: Changed

**LLM:**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    a b c d
  )
  (:types 
    block a b c
    table d
  )
  (:init 
    (and 
      (on-table a)
      (on-table b)
      (on-table c)
      (clear a)
      (clear b)
      (clear c)
      (hand-empty)
    )
  )
  (:goal 
    (and 
      (on a b)
      (on b c)
    )
  )
)
```

**USER:**
On trying to solve the above the following error was received --> There is a value error when found invalid keyword when parsing :init statement. Remove 'types' and 'and' and solve.

Requirement: Correct the error and give a new problem file only.

**LLM:**
```
(define (problem blocks-world-problem)
  (:domain blocks-world)
  (:objects 
    a b c d
  )
  (:init 
      (on-table a)
      (on-table b)
      (on-table c)
      (clear a)
      (clear b)
      (clear c)
      (hand-empty)
  )
  (:goal 
      (on a b)
      (on b c)
  )
)
```

**<span style="color:green">{'success': True, 'action_path': [<Op (put-down a b)>], 'message': 'Action Path Sucessfully Found.'}</span>**

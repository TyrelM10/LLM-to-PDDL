**mistralai/Mistral-7B-Instruct-v0.2 -Managing Context - BLOCKS WORLD**
_**System Prompt**: Generate PDDL domain code for natural language text descriptions. Do not add comments to the code._ [Conversation Link](https://hf.co/chat/r/aEtlSei)
**API CALL 0:**
**USER:**
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```pddl
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types block - Type
           stack - FunctionOfOneOrMoreBlocks
           location - Type
         )
  (:predicates
    (clear? - location - "true iff all blocks are clear at location"?)
    (on? - block stack - "true if block is on top of stack"?)
    (stack? - stack - "true if stack has at least one block"?)
    (at? - block location - "true if block is located at location"?)
  )
  (:action move
     :parameters (?x ?y ?z)
     :precondition (and (block ?x) (clear? ?z))
     :effect (and (not (clear? ?y)) (clear? ?z) (on? ?x ?z)))

  (:action pickup
      :parameters (?x)
      :precondition (and (block ?x) (clear? ground))
      :effect (and (not (on? ?x ground)) (clear? ground)))

  (:action putdown
       :parameters (?x)
       :precondition (and (clear? hand) (or (clear? ?goal) (stack? ?goal)))
       :effect (and (not (clear? hand)) (clear? ?goal) (on? ?x ?goal))))
```

**API CALL 1:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?".

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```pddl
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location
          /\Type
        )
  (:predicates
    (clear? - Location - "true iff all blocks are clear at location")
    (on? - Block Stack - "true if block is on top of stack")
    (stack? - Stack - "true if stack has at least one block")
    (at? - Block Location - "true if block is located at location")
  )
  (:action move
     :parameters (?x ?y ?z)
     :precondition (and (BlockP ?x) (Clear? ?z))
     :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))

  (:action pickup
      :parameters (?x)
      :precondition (and (BlockP ?x) (Clear? Ground))
      :effect (and (not (On? ?x Ground)) (Clear? Ground)))

  (:action putdown
       :parameters (?x)
       :precondition (and (Clear? Hand) (or (Clear? Goal) (Stack? Goal)))
       :effect (and (not (Clear? Hand)) (Clear? Goal) (On? ?x Goal))))
```

**API CALL 2:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?".

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```pddl
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location
          ?type
        )
  (:predicates
    (clear? - Location - "true iff all blocks are clear at location")
    (on? - Block Stack - "true if block is on top of stack")
    (stack? - Stack - "true if stack has at least one block")
    (at? - Block Location - "true if block is located at location")
  )
  (:action move
     :parameters (?x ?y ?z)
     :precondition (and (BlockP ?x) (Clear? ?z))
     :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))

  (:action pickup
      :parameters (?x)
      :precondition (and (BlockP ?x) (Clear? Ground))
      :effect (and (not (On? ?x Ground)) (Clear? Ground)))

  (:action putdown
       :parameters (?x)
       :precondition (and (Clear? Hand) (or (Clear? Goal) (Stack? Goal)))
       :effect (and (not (Clear? Hand)) (Clear? Goal) (On? ?x Goal))))
```


**API CALL 3:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?".

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```pddl
(:domain blocks-world
   (:requirements :strips :typing)
   (:types Block Stack Location
            ?t)
   (:predicates
      (clear? - Location - "Location is clear.")
      (on? - Block Stack - "Block is on top of stack."))
   (:functions none)
   (:init)
   (:action move
      :parameters (?x ?y ?z)
      :precondition (and (BlockP ?x) (Clear? ?z))
      :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))
   (:action pickup
      :parameters (?x)
      :precondition (and (BlockP ?x) (Clear? ground))
      :effect (and (not (On? ?x ground)) (Clear? ground)))
   (:action putdown
      :parameters (?x)
      :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
      :effect (and (not (Clear? hand)) (Clear? goal) (On? ?x goal)))))
```

**API CALL 4:**
**USER:**
The above code produces the following error -> There was an error in parsing the code. Got unexpected token: ).

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
<CODE>
:domain blocks-world
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location
          ?type)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?x ?y ?z)
    :precondition (and (BlockP ?x) (Clear? ?z))
    :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))
  (:action pickup
    :parameters (?x)
    :precondition (and (BlockP ?x) (Clear? ground))
    :effect (and (not (On? ?x ground)) (Clear? ground)))
  (:action putdown
    :parameters (?x)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?x goal))))
</CODE>
```

**API CALL 5:**
**USER:**
The above code produces the following error -> There was an error in parsing the code. Expected '(', got <code>.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
<CODE>
:domain blocks-world
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location
          ?type)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?x ?y ?z)
    :precondition (and (BlockP ?x) (Clear? ?z))
    :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))
  (:action pickup
    :parameters (?x)
    :precondition (and (BlockP ?x) (Clear? ground))
    :effect (and (not (On? ?x ground)) (Clear? ground)))
  (:action putdown
    :parameters (?x)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?x goal))))
</CODE>
```

**API CALL 6:**
**USER:**
The above code produces the following error -> There was an error in parsing the code. Expected '(', got <code>.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
<CODE>
:domain blocks-world
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location
          ?type)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?x ?y ?z)
    :precondition (and (BlockP ?x) (Clear? ?z))
    :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))
  (:action pickup
    :parameters (?x)
    :precondition (and (BlockP ?x) (Clear? ground))
    :effect (and (not (On? ?x ground)) (Clear? ground)))
  (:action putdown
    :parameters (?x)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?x goal))))
</CODE>
```

**API CALL 7:**
**USER:**
The above code produces the following error -> There was an error in parsing the code. Expected '(', got <code>.

Requirement 1: Correct the error and give the entire PDDL domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.

<span style="color:red">_**NOTE:** In the above prompt I removed the 3rd Requirement and also made pddl Uppercase. This helped the model understand the syntax for pddl code and final returned the same output._</span>

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(:domain blocks-world
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?x ?y ?z)
    :precondition (and (BlockP ?x) (Clear? ?z))
    :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))
  (:action pickup
    :parameters (?x)
    :precondition (and (BlockP ?x) (Clear? ground))
    :effect (and (not (On? ?x ground)) (Clear? ground)))
  (:action putdown
    :parameters (?x)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?x goal))))
```
---
**API CALL 8:**
**USER:**
The above code produces the following error -> There is a value error where there is invalid domain definition. Domain definition must start with 'define'.

Requirement 1: Correct the error and give the entire PDDL domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.

<span style="color:red">_**NOTE:** I have completely remove the 3rd Requirement Prompt to not confuse the model._</span>

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```pddl
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?x ?y ?z)
    :precondition (and (BlockP ?x) (Clear? ?z))
    :effect (and (not (Clear? ?y)) (Clear? ?z) (On? ?x ?z)))
  (:action pickup
    :parameters (?x)
    :precondition (and (BlockP ?x) (Clear? ground))
    :effect (and (not (On? ?x ground)) (Clear? ground)))
  (:action putdown
    :parameters (?x)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?x goal))))
```

---
**API CALL 9:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?".

Requirement 1: Correct the error and give the entire PDDL domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?block ?location1 ?location2)
    :precondition (and (BlockP ?block) (Clear? ?location2))
    :effect (and (not (Clear? ?location1)) (Clear? ?location2) (On? ?block ?location2) (Not (On? ?block ?location1))))
  (:action pickup
    :parameters (?block)
    :precondition (and (BlockP ?block) (Clear? ground))
    :effect (and (not (On? ?block ground)) (Clear? ground)))
  (:action putdown
    :parameters (?block)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?block goal))))
```

---
**API CALL 10:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?".

Requirement 1: Correct the error and give the entire PDDL domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?b ?loc1 ?loc2)
    :precondition (and (BlockP ?b) (Clear? ?loc2))
    :effect (and (not (Clear? ?loc1)) (Clear? ?loc2) (On? ?b ?loc2) (not (On? ?b ?loc1))))
  (:action pickup
    :parameters (?b)
    :precondition (and (BlockP ?b) (Clear? ground))
    :effect (and (not (On? ?b ground)) (Clear? ground)))
  (:action putdown
    :parameters (?b)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?b goal))))
  ```
  ---

**API CALL 11:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?".

Requirement 1: Correct the error and give the entire PDDL domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.

**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?b ?loc1 ?loc2)
    :precondition (and (BlockP ?b) (Clear? ?loc2))
    :effect (and (not (Clear? ?loc1)) (Clear? ?loc2) (On? ?b ?loc2) (not (On? ?b ?loc1))))
  (:action pickup
    :parameters (?b)
    :precondition (and (BlockP ?b) (Clear? ground))
    :effect (and (not (On? ground ?b)) (Clear? ground)))
  (:action putdown
    :parameters (?b)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?b goal))))
```
---
**API CALL 15:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?". Please check the syntax for PDDL to solve this.

Requirement 1: Correct the error and give the entire PDDL domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?b ?loc1 ?loc2)
    :precondition (and (BlockP ?b) (Clear? ?loc2))
    :effect (and (not (Clear? ?loc1)) (Clear? ?loc2) (On? ?b ?loc2) (not (On? ?b ?loc1))))
  (:action pickup
    :parameters (?b)
    :precondition (and (BlockP ?b) (Clear? ground))
    :effect (and (not (On? ?b ground)) (Clear? ground)))
  (:action putdown
    :parameters (?b)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?b goal))))
```
---
**API CALL 16:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?". 

Requirement 1: Correct the error and give the entire PDDL domain code. Please check the syntax for PDDL to solve this.
Requirement 2: Do not create a problem file. Do not use conditional expressions.
**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?block ?location1 ?location2)
    :precondition (and (BlockP ?block) (Clear? ?location2))
    :effect (and (not (Clear? ?location1)) (Clear? ?location2) (On? ?block ?location2) (not (On? ?block ?location1))))
  (:action pickup
    :parameters (?block)
    :precondition (and (BlockP ?block) (Clear? ground))
    :effect (and (not (On? ?block ground)) (Clear? ground)))
  (:action putdown
    :parameters (?block)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?block goal))))
```
---
**API CALL 17:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?". 

Requirement 1: Correct the error and give the entire PDDL domain code. Please check the syntax for PDDL to solve this.
**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?block ?location1 ?location2)
    :precondition (and (BlockP ?block) (Clear? ?location2))
    :effect (and (not (Clear? ?location1)) (Clear? ?location2) (On? ?block ?location2) (not (On? ?block ?location1))))
  (:action pickup
    :parameters (?block)
    :precondition (and (BlockP ?block) (Clear? ground))
    :effect (and (not (On? ?block ground)) (Clear? ground)))
  (:action putdown
    :parameters (?block)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?block goal))))
```
---
**API CALL 18:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?". 

Requirement 1: Correct the error and give the entire PDDL domain code. Please check the syntax for PDDL to solve this.
Requirement 2: Check the syntax of predicates and variables defined in them and do not use comments to fix the error.
**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?block ?location1 ?location2)
    :precondition (and (BlockP ?block) (Clear? ?location2))
    :effect (and (not (Clear? ?location1)) (Clear? ?location2) (On? ?block ?location2) (not (On? ?block ?location1))))
  (:action pickup
    :parameters (?block)
    :precondition (and (BlockP ?block) (Clear? ground))
    :effect (and (not (On? ?block ground)) (Clear? ground)))
  (:action putdown
    :parameters (?block)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?block goal))))
```
---
**API CALL 19:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?". 

Requirement 1: Correct the error and give the entire PDDL domain code. Please check the syntax for PDDL to solve this.
Requirement 2: Check the syntax of PDDL for predicates and variables defined in them and do not use comments to fix the error.
**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?block ?location1 ?location2)
    :precondition (and (BlockP ?block) (Clear? ?location2))
    :effect (and (not (Clear? ?location1)) (Clear? ?location2) (On? ?block ?location2) (not (On? ?block ?location1))))
  (:action pickup
    :parameters (?block)
    :precondition (and (BlockP ?block) (Clear? ground))
    :effect (and (not (On? ?block ground)) (Clear? ground)))
  (:action putdown
    :parameters (?block)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?block goal))))
```
---
**API CALL 20:**
**USER:**
The above code produces the following error -> There is a value error where variables must start with a "?". 

Requirement 1: Correct the error and give the entire PDDL domain code. Please check the syntax for PDDL to solve this.
Requirement 2: Check the syntax of PDDL for predicates and variables defined in them and do not use comments to fix the error.
**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (on? - Block Stack - "Block is on top of stack."))
  (:actions)
  (:action move
    :parameters (?block ?location1 ?location2)
    :precondition (and (BlockP ?block) (Clear? ?location2))
    :effect (and (not (Clear? ?location1)) (Clear? ?location2) (On? ?block ?location2) (not (On? ?block ?location1))))
  (:action pickup
    :parameters (?block)
    :precondition (and (BlockP ?block) (Clear? ground))
    :effect (and (not (On? ?block ground)) (Clear? ground)))
  (:action putdown
    :parameters (?block)
    :precondition (and (Clear? hand) (or (Clear? goal) (Stack? goal)))
    :effect (and (not (Clear? hand)) (Clear? goal) (On? ?block goal))))
```

---
**API CALL 21:**
**USER:**
The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.
**LLM MODEL (Mistral-7B-Instruct-v0.2):**
```
(define (domain blocks-world)
  (:requirements :strips :typing)
  (:types Block Stack Location)
  (:predicates
    (clear? - Location - "Location is clear.")
    (stacked? - Block Block - "Block b1 is stacked on top of block b2."))
  (:init
    (forall (?x Block) (clear? ground)))
  (:actions)
  (:action move
    :parameters (?block1 ?from-location ?to-location)
    :precondition (and (clear? ?to-location) (clear? ?from-location) (stacked? ?block1 ?something))
    :effect (and (clear? ?from-location) (clear? ?to-location) (not (stacked? ?block1 ?something)) (stacked? ?block1 ?to-location)))
  (:action pickup
    :parameters (?block)
    :precondition (clear? ground)
    :effect (clear? ground) (not (clear? hand)) (holding ?block))
  (:action putdown
    :parameters (?block)
    :precondition (and (clear? hand) (clear? ?destination))
    :effect (and (clear? hand) (clear? ?destination) (stacked? ?block ?destination))))
```
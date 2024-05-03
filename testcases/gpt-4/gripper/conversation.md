**GPT-4 - GRIPPER**

---
**STEP 1:**
**USER:**
There is a robot with two grippers. It can carry a ball in each. The goal is to take N balls from one room to another; N rises with problem number. Some planners treat the two grippers asymmetrically, giving rise to an unnecessary combinatorial explosion. This domain was created by Jana Koehler.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-4):**
```
(define (domain dual-gripper-transport)
  (:requirements :strips :typing)
  (:types
    ball room gripper)
  
  (:predicates
    (ball-at ?b - ball ?r - room)           ; Ball is at a specific room
    (gripper-at ?g - gripper ?r - room)     ; Gripper is at a specific room
    (free ?g - gripper)                     ; Gripper is not carrying any ball
    (carry ?g - gripper ?b - ball)          ; Gripper is carrying a specific ball
  )
  
  (:action move
    :parameters (?g - gripper ?from - room ?to - room)
    :precondition (and (gripper-at ?g ?from) (free ?g))
    :effect (and (not (gripper-at ?g ?from)) (gripper-at ?g ?to))
  )
  
  (:action pick
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (and (gripper-at ?g ?r) (ball-at ?b ?r) (free ?g))
    :effect (and (not (ball-at ?b ?r)) (not (free ?g)) (carry ?g ?b))
  )
  
  (:action drop
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (and (gripper-at ?g ?r) (carry ?g ?b))
    :effect (and (not (carry ?g ?b)) (ball-at ?b ?r) (free ?g))
  )

  (:action move-carrying
    :parameters (?g - gripper ?b - ball ?from - room ?to - room)
    :precondition (and (gripper-at ?g ?from) (carry ?g ?b))
    :effect (and (not (gripper-at ?g ?from)) (gripper-at ?g ?to))
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
(define (problem dual-gripper-transport-problem)
  (:domain dual-gripper-transport)
  (:objects
    ball1 ball2 ball3 - ball
    room1 room2 - room
    gripper1 gripper2 - gripper
  )

  (:init
    (ball-at ball1 room1)
    (ball-at ball2 room1)
    (ball-at ball3 room1)
    (gripper-at gripper1 room1)
    (gripper-at gripper2 room1)
    (free gripper1)
    (free gripper2)
  )

  (:goal
    (and
      (ball-at ball1 room2)
      (ball-at ball2 room2)
      (ball-at ball3 room2)
    )
  )
)
```

**<span style="color:green">{'success': True, 'action_path': [<Op (pick gripper2 ball1 room1)>, <Op (pick gripper1 ball3 room1)>, <Op (move-carrying gripper2 ball1 room1 room2)>, <Op (drop gripper2 ball1 room2)>, <Op (move gripper2 room2 room1)>, <Op (pick gripper2 ball2 room1)>, <Op (move-carrying gripper2 ball2 room1 room2)>, <Op (drop gripper2 ball2 room2)>, <Op (move-carrying gripper1 ball3 room1 room2)>, <Op (drop gripper1 ball3 room2)>], 'message': 'Action Path Sucessfully Found.'}</span>**

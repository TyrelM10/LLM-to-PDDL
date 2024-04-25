**GPT-3.5 - Managing Context - GRIPPER** [Conversation Link](https://chat.openai.com/share/52539f5b-3b1c-4a5d-8746-36746fbace73)

---
**STEP 1:**
**USER:**
There is a robot with two grippers. It can carry a ball in each. The goal is to take N balls from one room to another; N rises with problem number. Some planners treat the two grippers asymmetrically, giving rise to an unnecessary combinatorial explosion. This domain was created by Jana Koehler.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain robot-domain)
  (:requirements :strips :typing)
  (:types ball gripper room)
  (:predicates 
    (at-robot ?r - room)
    (at-ball ?b - ball ?r - room)
    (in-gripper ?g - gripper ?b - ball)
    (empty ?g - gripper)
    (goal-reached)
  )
  (:action pick-up
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (and (at-ball ?b ?r) (at-robot ?r) (empty ?g))
    :effect (and (in-gripper ?g ?b) (not (at-ball ?b ?r)) (not (empty ?g)))
  )
  (:action put-down
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (and (in-gripper ?g ?b) (at-robot ?r))
    :effect (and (at-ball ?b ?r) (empty ?g) (not (in-gripper ?g ?b)))
  )
  (:action move-robot
    :parameters (?from - room ?to - room)
    :precondition (at-robot ?from)
    :effect (and (not (at-robot ?from)) (at-robot ?to))
  )
  (:action move-ball
    :parameters (?b - ball ?from - room ?to - room)
    :precondition (and (at-ball ?b ?from) (at-robot ?from))
    :effect (and (not (at-ball ?b ?from)) (at-ball ?b ?to))
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
(define (problem robot-problem)
  (:domain robot-domain)
  (:objects
    ball1 ball2 ball3 - ball
    gripper1 gripper2 - gripper
    room1 room2 - room
  )
  (:init
    (at-robot room1)
    (at-ball ball1 room1)
    (at-ball ball2 room1)
    (at-ball ball3 room1)
    (empty gripper1)
    (empty gripper2)
  )
  (:goal (and
          (at-ball ball1 room2)
          (at-ball ball2 room2)
          (at-ball ball3 room2)
          (goal-reached)
        )
  )
)
```
**NOTE:** The problem was parsed and solved without any action path found. Hence further giving a prompt below to the LLM to solve this.
**<span style="color:red">{'success': True, 'action_path': None, 'message': 'Action Path Sucessfully Found.'}</span>**

**USER:**
The above problem solved but did not produce an action path. Please create a new problem such that it outputs a action path when solved by a planner.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (problem robot-problem)
  (:domain robot-domain)
  (:objects
    ball1 ball2 - ball
    gripper1 gripper2 - gripper
    room1 room2 - room
  )
  (:init
    (at-robot room1)
    (at-ball ball1 room1)
    (at-ball ball2 room1)
    (empty gripper1)
    (empty gripper2)
  )
  (:goal (and
          (at-ball ball1 room2)
          (at-ball ball2 room2)
          (goal-reached)
        )
  )
)
```
**NOTE:** Same error where the problem was parsed and solved without any action path found. Hence further giving a prompt below to the LLM to solve this. Trying again.
**<span style="color:red">{'success': True, 'action_path': None, 'message': 'Action Path Sucessfully Found.'}</span>**

**USER:**

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (problem robot-problem)
  (:domain robot-domain)
  (:objects
    ball1 ball2 - ball
    gripper1 gripper2 - gripper
    room1 room2 - room
  )
  (:init
    (at-robot room1)
    (at-ball ball1 room1)
    (at-ball ball2 room1)
    (empty gripper1)
    (empty gripper2)
  )
  (:goal (and
          (at-ball ball1 room2)
          (at-ball ball2 room2)
          (goal-reached)
        )
  )
  (:metric minimize (total-cost))
)
```

**USER:**
On trying to solve the above the following error was received --> There was an error in parsing the code for expected to be at end.

Requirement: Correct the error and give a new problem file only.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (problem robot-problem)
  (:domain robot-domain)
  (:objects
    ball1 ball2 - ball
    gripper1 gripper2 - gripper
    room1 room2 - room
  )
  (:init
    (at-robot room1)
    (at-ball ball1 room1)
    (at-ball ball2 room1)
    (empty gripper1)
    (empty gripper2)
  )
  (:goal (and
          (at-ball ball1 room2)
          (at-ball ball2 room2)
          (goal-reached)
        )
  )
)
```

**NOTE:** Same error as before and leaving to that.
**<span style="color:red">{'success': True, 'action_path': None, 'message': 'Action Path Sucessfully Found.'}</span>**
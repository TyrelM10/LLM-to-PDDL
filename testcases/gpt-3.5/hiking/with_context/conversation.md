**GPT-3.5 - Managing Context - HIKING** [Conversation Link](https://chat.openai.com/share/59ec3602-a0d1-4e55-a0ce-ae61f4e05da0)

---
**STEP 1:**
**USER:**
Imagine you want to walk with your partner a long clockwise circular route over several days (e.g. in the "Lake District" in NW England), and you do one "leg" each day. You want to start at a certain point and do the walk in one direction, without ever walking backwards. You have two cars which you must use to carry your tent/luggage and to carry you and your partner to the start/end of a leg, if necessary. Driving a car between any two points is allowed, but walking must be done with your partner and must start from the place where you left off. As you will be tired when you have walked to the end of a leg, you must have your tent up ready there so you can sleep the night before you set off to do the next leg the morning.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:durative-action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:durative-action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1)))
            (at start (not (at ?p1 ?to)))
            (at start (not (at ?p2 ?to)))
            (at start (tent_at ?from))
            (at end (leg_complete ?from ?to))
        )
        :effect (and
            (at start (not (at ?p1 ?from)) (not (at ?p2 ?from)))
            (at end (at ?p1 ?to) (at ?p2 ?to))
        )
    )

    (:durative-action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1)))
        )
        :effect (and
            (at start (not (at ?p ?loc)))
            (at end (at ?p ?loc))
        )
    )

)
```
---
**STEP 2:**
**USER:**
The above code produces the following error -> There is a value error on finding unknown keyword in domain definition: 'durative-action'. Remove the keyword 'durative-action' from definition, keep the rest of code the same.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
        day
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1)))
            (at start (not (at ?p1 ?to)))
            (at start (not (at ?p2 ?to)))
            (at start (tent_at ?from))
            (at end (leg_complete ?from ?to))
        )
        :effect (and
            (at start (not (at ?p1 ?from)) (not (at ?p2 ?from)))
            (at end (at ?p1 ?to) (at ?p2 ?to))
        )
    )

    (:action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1)))
        )
        :effect (and
            (at start (not (at ?p ?loc)))
            (at end (at ?p ?loc))
        )
    )

)
```
---
**STEP 3:**
**USER:**
The above code produces the following error -> There is a value error where Precondition statement must start with ":precondition" keyword.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
        day
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at start (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1)))
            (at start (not (at ?p1 ?to)))
            (at start (not (at ?p2 ?to)))
            (at start (tent_at ?from))
            (at end (leg_complete ?from ?to))
        )
        :effect (and
            (at start (not (at ?p1 ?from)) (not (at ?p2 ?from)))
            (at end (at ?p1 ?to) (at ?p2 ?to))
        )
    )

    (:action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at start (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1)))
        )
        :effect (and
            (at start (not (at ?p ?loc)))
            (at end (at ?p ?loc))
        )
    )

)
```

**STEP 4:**
**USER:**
The above code produces the following error -> There is a value error where Precondition statement must start with ":precondition" keyword.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
        day
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :condition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1))
            (not (at ?p1 ?to))
            (not (at ?p2 ?to))
            (tent_at ?from)
            (leg_complete ?from ?to)
        )
        :effect (and
            (not (at ?p1 ?from)) (not (at ?p2 ?from))
            (at ?p1 ?to) (at ?p2 ?to)
        )
    )

    (:action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1))
        )
        :effect (and
            (not (at ?p ?loc))
            (at ?p ?loc)
        )
    )

)
```

**STEP 5:**
**USER:**

The above code produces the following error -> There is a value error where Precondition statement in actions must start with ":precondition" keyword.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

<span style="color:blue">**NOTE:** Changed the error prompt a little to fix the error.</span>

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
        day
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1))
            (not (at ?p1 ?to))
            (not (at ?p2 ?to))
            (tent_at ?from)
            (leg_complete ?from ?to)
        )
        :effect (and
            (not (at ?p1 ?from)) (not (at ?p2 ?from))
            (at ?p1 ?to) (at ?p2 ?to)
        )
    )

    (:action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1))
        )
        :effect (and
            (not (at ?p ?loc))
            (at ?p ?loc)
        )
    )

)
```
**STEP 6:**
**USER:**

The above code produces the following error -> There is a value error where Precondition statement in actions must start with ":precondition" keyword. Make sure each action only has keywords of :parameters , :precondition and :effect , nothing other than this.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

<span style="color:red">**NOTE:** Changed the error prompt to fix the error as the same error was repeated.</span>

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
        day
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1))
            (not (at ?p1 ?to))
            (not (at ?p2 ?to))
            (tent_at ?from)
            (leg_complete ?from ?to)
        )
        :effect (and
            (not (at ?p1 ?from)) (not (at ?p2 ?from))
            (at ?p1 ?to) (at ?p2 ?to)
        )
    )

    (:action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1))
        )
        :effect (and
            (not (at ?p ?loc))
            (at ?p ?loc)
        )
    )

)
```
**STEP 7:**
**USER:**

The above code produces the following error -> There is a value error where PreconditionStmt must start with ":precondition" keyword.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

<span style="color:red">**NOTE:** Trying one last time for same error.</span>

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
        day
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1))
            (not (at ?p1 ?to))
            (not (at ?p2 ?to))
            (tent_at ?from)
            (leg_complete ?from ?to)
        )
        :effect (and
            (not (at ?p1 ?from)) (not (at ?p2 ?from))
            (at ?p1 ?to) (at ?p2 ?to)
        )
    )

    (:action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1))
        )
        :effect (and
            (not (at ?p ?loc))
            (at ?p ?loc)
        )
    )

)
```

<span style="color:red">**NOTE: Same error continued and hence stopped at this.**</span>
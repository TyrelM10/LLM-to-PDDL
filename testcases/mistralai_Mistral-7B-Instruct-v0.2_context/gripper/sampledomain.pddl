(define-domain robotic-domain
 :predicates (clear ?x
              holding ?gripper ?ball
              at ?gripper ?room
              on-table ?ball)

 :types :grippers :balls :rooms :integer

 :functions (count (sequence Sequence) (- length (length sequence)))

 :actions (action pick-up
             (:parameters (?gripper - gripper)
                       (?ball - ball)
                       :precondition (and (clear ?gripper)
                                          (not (or (holding ?gripper ?ball)
                                                  (on-table ?ball)
                                                  (exists (?other-ball - ball)
                                                          (and (type ?other-ball Ball)
                                                              (not (equal ?ball ?other-ball))
                                                              (holds ?gripper ?other-ball))))))
                       :effect (and (not (clear ?gripper))
                                    (not (clear ?ball))
                                    (holding ?gripper ?ball)
                                    (not (on-table ?ball))
                                    (clear ?ball)
                                    (clear (nth (position ?other-ball (append (instance-list (all-instances Ball))
                                                                            (remove-duplicates (instance-list (all-instances Ball))))
                                                      :test #'(lambda (?a ?b) (eq ?a ?b)))))))

           (action put-down
             (:parameters (?gripper - gripper)
                       (?ball - ball)
                       :precondition (holding ?gripper ?ball)
                       :effect (and (clear ?gripper)
                                    (clear ?ball)
                                    (not (holding ?gripper ?ball))
                                    (on-table ?ball)
                                    (clear ?ball)
                                    (clear (nth (position ?other-ball (append (instance-list (all-instances Ball))
                                                                            (remove-duplicates (instance-list (all-instances Ball))))
                                                      :test #'(lambda (?a ?b) (eq ?a ?b)))))))

           (action move-robot
             (:parameters ()
                       :precondition t
                       :effect (mapcar (lambda (?ball)
                                        (cond ((and (ball ?ball)
                                                   (not (or (holding Gripper1 ?ball)
                                                         (holding Gripper2 ?ball)
                                                         (on-table ?ball)
                                                         (at Room2 ?ball)
                                                         (at Room1 ?ball)))
                                               (progn
                                                 (let ((available-gripper (if (holds Gripper1 Nothing) 'Gripper2 'Gripper1)))
                                                   (pick-up available-gripper ?ball)
                                                   (put-down available-gripper ?ball)
                                                   (on-table ?ball)
                                                   (clear ?ball)
                                                   (clear (nth (position ?ball (append (instance-list (all-instances Ball))
                                                                                       (remove-duplicates (instance-list (all-instances Ball))))
                                                                     :test #'(lambda (?a ?b) (eq ?a ?b))))))))

 :init (foralls (?x) (clear ?x))

 :goal (and (clear Gripper1)
            (clear Gripper2)
            (at Gripper1 Room1)
            (at Gripper2 Room1)
            (forall (?ball (in-domain Ball))
                    (if (holds Gripper1 ?ball)
                        then (at Gripper2 Room2)
                        else (and (ball ?ball)
                                   (not (holds Gripper1 ?ball))
                                   (not (holds Gripper2 ?ball))
                                   (not (on-table ?ball))
                                   (not (at Room2 ?ball))
                                   (not (at Room1 ?ball))))))
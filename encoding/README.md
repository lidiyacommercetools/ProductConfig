## Choice Rules

1. What "eliminates" an atom from being a valid choice in a choice rule? 
    - Constraint 
    - Example: The "b" is not a valid choice in the choice rule because it is eliminated by the constraint.
      a.
      1{b;c}.
      :- a,b.
      
2. Why was an atom chosen in a choice rule? Was it mandatory or optional?
    - Mandatory:
        * The choice rule asks for Q atoms and there are only Q valid choices.
            - Example: The choice rule asks for 1 atom to be chosen, and there is only 1 valid option, since "b" cannot be chosen due to the constraint.
              a.
              {b;c}=1.
              :- a,b.


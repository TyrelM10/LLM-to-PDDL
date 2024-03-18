# from .pyperplan.llm_to_pddl import llm_to_pddl
# from openapillm import get_code_llm
import sys

def receiver(error):
    
    print("----------------------- ERROR --------------------------")
    print(error)
    print("--------------------------------------------------------")
    sys.exit()
    # get_code_llm(error)
    
# llm_to_pddl()
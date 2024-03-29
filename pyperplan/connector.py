import sys
sys.path.append('LLM-to-PDDL')
import llm_connect

def receiver(error):
    print(" ------ ERROR FROM VALIDATOR ---- > ", error)
    llm_connect.generate_answer(error, "Any", True)
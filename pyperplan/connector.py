import sys
sys.path.append('LLM-to-PDDL')
import llm_connect
import logging

logging.basicConfig(filename="logfilename.log", level=logging.ERROR)

def receiver(error):
    logging.error(error)
    sys.exit(1)
    # print(" ------ ERROR FROM VALIDATOR ---- > ", error["error_number"])
    # llm_connect.generate_answer(error["error"], "Any", True)
import sys
sys.path.append('LLM-to-PDDL')
import llm_connect
import logging

# logging.basicConfig(filename="logfilename.log", level=logging.ERROR)

def receiver(error):
    logging.error(error) # Logging the error.
    # sys.exit(1)
    # print(" ------ ERROR FROM VALIDATOR ---- > ", error["error_number"])
    llm_connect.generate_domain(error["error"], "Any", True) # Calling the LLM model to generate PDDL code for the error.
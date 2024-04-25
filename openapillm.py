import openai

import os

import pandas as pd
from llm_connect import *
import time
import re
from config import OPEN_AI_API
import logging
import sys
from pyperplan.llm_to_pddl import llm_to_pddl

openai.api_key = OPEN_AI_API

def get_code_llm_openai(message):
    try:
        messages = [{"role": "system", "content": "Generate PDDL domain code for natural language text descriptions. Do not add comments and explanations to the code."}]
        print("RUNNING CHAT GPT API CODE")
        while True:
            if message:
                messages.append(
                    {"role": "user", "content": message},
                )
                chat = openai.ChatCompletion.create(
                    model="gpt-3.5-turbo", messages=messages, temperature=1
                )
            try:
                reply = str(chat.choices[0].message.content).split("pddl",1)[1].split('```')[0]
                time.sleep(2)
            except Exception as e:
                logging.error('---- ERROR NO WORD PDDL IN CHAT GPT ------> ' + str(e))
                # print(str(chat.choices[0].message.content))
                try:
                    reply = str(chat.choices[0].message.content).split("lisp",1)[1].split('```')[0]
                except Exception as e:
                    logging.error('---- ERROR NO WORD LISP IN CHAT GPT -------> ' + str(e))
                    
                    # print(str(chat.choices[0].message.content))
                    try:
                        reply = str(chat.choices[0].message.content)
                    except Exception as e:
                        logging.error("------ SOMETHING VERY WRONG IN CHAT GPT -------> " + str(e))
                        return {'success':False, 'answer': "Could not generate code. Please try again later."}
            logging.info(reply)
            return {'success':True, 'answer': reply}
        
    except Exception as e:
        logging.error("ERROR IN CHAT GPT API CODE ------> " + str(e))
        return {'success':False, 'answer': "Could not generate code. Please try again later."}
    
''' # ----- Uncomment to Test The Function ------
def save_text_to_file(text, file_path):
    with open(file_path, 'w') as file:
        file.write(text)
        
file_path = "testingfolder/sampledomain.pddl"

text_to_save = get_code_llm_openai("The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.\n Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.")
if text_to_save['success']:
    save_text_to_file(text_to_save['answer'], file_path)
'''

# solution = llm_to_pddl(True)
# print(solution)
# sys.exit(1)
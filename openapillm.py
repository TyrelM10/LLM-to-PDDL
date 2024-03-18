import openai

import os

import pandas as pd

import time
import re
from config import OPEN_AI_API
# client = OpenAI(
#   organization='org-0Xn8VqLbjo7QZ4DTm9y6KPHT',
# )
from pyperplan.pddl.parser import Parser
from pyperplan.llm_to_pddl import llm_to_pddl



openai.api_key = OPEN_AI_API

def get_code_llm(message):
    messages = [{"role": "system", "content": "You will provide me PDDL code."}]

    while True:
        message = input("User : ")
        if message:
            messages.append(
                {"role": "user", "content": message},
            )
            chat = openai.ChatCompletion.create(
                model="gpt-3.5-turbo", messages=messages,
            )
        
        reply = str(chat.choices[0].message.content).split("pddl",1)[1].split('```')[0]
        
        # test_variable = ['', '(define (domain blocks-world)', '  (:requirements :strips)', '  ', '  (:predicates', '    (on-table ?x - block)', '    (on ?x - block ?y - block)', '    (clear ?x - block)', '    (holding ?x - block)', '    (hand-empty)', '  )', '  ', '  (:action pick-up', '    :parameters (?x - block)', '    :precondition (and (clear ?x) (on ?x on-table) (hand-empty))', '    :effect (and (holding ?x) (not (on ?x on-table)) (not (clear ?x)) (not (hand-empty))', '  )', '  ', '  (:action put-down', '    :parameters (?x - block)', '    :precondition (holding ?x)', '    :effect (and (on ?x on-table) (clear ?x) (hand-empty) (not (holding ?x)))', '  )', '  ', '  (:action stack', '    :parameters (?x - block ?y - block)', '    :precondition (and (holding ?x) (clear ?y))', '    :effect (and (on ?x ?y) (clear ?x) (not (holding ?x)) (not (clear ?y)))', '  )', '  ', '  (:action unstack', '    :parameters (?x - block ?y - block)', '    :precondition (and (on ?x ?y) (clear ?x) (hand-empty))', '    :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (clear ?x)) (not (hand-empty)))', '  )', ')', '']
        # test_variable = test_variable[1:-1]
        # print(test_variable)
        # output = Parser._read_input("x",test_variable)
        # print(output)
        
        # print(f"ChatGPT: {reply}")
        
        # messages.append({"role": "assistant", "content": reply})
        return reply


def save_text_to_file(text, file_path):
    with open(file_path, 'w') as file:
        file.write(text)
        
        
file_path = "testingfolder/sampletest.pddl"

# text_to_save = get_code_llm("Lets convert Natural Language to PDDL")
# save_text_to_file(text_to_save, file_path)
llm_to_pddl()
    

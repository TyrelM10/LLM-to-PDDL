from pyperplan.llm_to_pddl import llm_to_pddl
from openapillm import get_code_llm_openai
from hugchatapi import hugchatter
import sys

file_path = "testingfolder/sampledomain.pddl"

def save_text_to_file(text, file_path):
    with open(file_path, 'w') as file:
        file.write(text)
        
def get_code_from_previous_generated(file_path):
    with open(file_path, 'r') as file:
        code = file.read()
    return code
        
def generate_answer(question, model_name, error_code):
    try:
        # --------------- First run when user inputs the domain text. -------------------
        if error_code == False:
            global conversational_texts
            conversational_texts = []
            global global_counter
            global_counter = 0
            global model_used
            model_used = model_name
            file_path = "testingfolder/sampledomain.pddl"
            question = "```"+question+"```"+"\n Please generate PDDL domain code for the following text description that is delimited by triple backticks above. \n Instructions to follow while generating: \n 1)Give me the answer in PDDL code formatted between triple backticks, for example \n```pddl \n (define (domain domainname) \n (:requirements :strips :typing) \n (:types typesrequired) \n (:predicates predicatesrequired) \n (:action actionrequired) \n (:parameters parametersrequired) \n (:precondition preconditionrequired) \n (:effect effectrequired) \n```"

            if model_name == "CHAT_GPT": # Calling chatgpt api model
                answer = get_code_llm_openai(question)
                
            elif model_name == "HUGGING_FACE": # Calling huggingface api model
                answer = hugchatter(question)
                
            conversational_texts.append("**USER** :" + question) # Appending user input to conversational_texts
            conversational_texts.append("**LLM MODEL** ({}):".format(model_name)+"\n```pddl"+ answer + "\n```") # Appending LLM model output to conversational_texts
            save_text_to_file(answer, file_path)
            global_counter += 1
            final = llm_to_pddl()
            if final or not final:
                pass
        
        # ---------------- Second run when user inputs the error code. -------------------
        elif error_code == True:
            print("----- RUNNING FOR ERROR --- {}".format(model_used))
            code_with_error = get_code_from_previous_generated(file_path="testingfolder/sampledomain.pddl")
            file_path = "testingfolder/sampledomain.pddl"
            error = code_with_error + "\n The above code produces the following error: " + str(question) + "\n Correct the error and give the entire pddl code. Do not create a problem file. \n Instructions to follow while generating: \n 1)Give me the answer in PDDL code formatted between triple backticks, for example \n```pddl \n (define (domain domainname) \n (:requirements :strips :typing) \n (:types typesrequired) \n (:predicates predicatesrequired) \n (:action actionrequired) \n (:parameters parametersrequired) \n (:precondition preconditionrequired) \n (:effect effectrequired) \n```"
            
            # error_formatted = code_with_error + "\n The above code produces the following error: "+"**"+str(question)+"**"+"\n Correct the error and give the entire pddl code. Do not create a problem file. \n Give me the answer in PDDL code formatted between triple backticks, for example ```pddl \n (define (domain domainname) \n (:requirements :strips :typing) \n (:types typesrequired) \n (:predicates predicatesrequired) \n (:action actionrequired) \n (:parameters parametersrequired) \n (:precondition preconditionrequired) \n (:effect effectrequired) \n```"
            conversational_texts.append("**USER** :" + error) # Appending user input to conversational_texts
            print("=========== CHAT COUNT ==========>> ", global_counter)
            
            if model_used == "CHAT_GPT": # Calling chatgpt api model
                if global_counter <= 4:
                    answer = get_code_llm_openai(error)
                    conversational_texts.append("**LLM MODEL** ({}):".format(model_used)+"\n```pddl"+ answer + "\n```") # Appending LLM model output to conversational_texts
                    save_text_to_file(answer, "testingfolder/sampledomain.pddl")
                    global_counter += 1
                    final = llm_to_pddl()
                    if final or not final:
                        pass
                else:
                    paragraph = '\n'.join(conversational_texts)
                    save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
                    return conversational_texts[-2]
                    
            elif model_used == "HUGGING_FACE": # Calling huggingface api model
                
                if global_counter <= 10:
                    answer = hugchatter(error)
                    conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n```pddl"+ answer + "\n```") # Appending LLM model output to conversational_texts
                    save_text_to_file(answer, "testingfolder/sampledomain.pddl")
                    global_counter += 1
                    final = llm_to_pddl()
                    if final or not final:
                        pass
                else:
                    paragraph = '\n'.join(conversational_texts)
                    save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
                    return conversational_texts[-2]
    
    except Exception as e:
        print(" ----- ERROR HANDLED ----- > ", e)
        paragraph = '\n'.join(conversational_texts)
        save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
        return conversational_texts[-2]
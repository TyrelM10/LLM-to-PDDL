from pyperplan.llm_to_pddl import llm_to_pddl
from openapillm import get_code_llm_openai
from hugchatapi import hugchatter
import sys
import logging
import time

file_path = "testingfolder/sampledomain.pddl"

def save_text_to_file(text, file_path):
    with open(file_path, 'w') as file:
        file.write(text)
        
def get_code_from_previous_generated(file_path):
    with open(file_path, 'r') as file:
        code = file.read()
    return code
        
def generate_domain(question, model_name, error_code):
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
            
            question = question+"\n \n Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations."

            #  ------- Calling ChatGPT API for Generating PDDL Code. -------
            if model_name == "CHAT_GPT": # Calling chatgpt api model
                answer = get_code_llm_openai(question)
                time.sleep(3)
                if answer['success']==False:
                    conversational_texts.append("**USER** :\n" + question) 
                    conversational_texts.append("**LLM MODEL** ({}):".format(model_name) +"\n"+str(answer['answer'])+"\n")
                    paragraph = '\n'.join(conversational_texts)
                    save_text_to_file(paragraph, 'testingfolder/conversation.md')
                    time.sleep(3)
                    return conversational_texts[-1]
            
            # ------- Calling HUGGING CHAT API for Generating PDDL Code. -------
            elif model_name == "HUGGING_FACE": # Calling huggingface api model
                answer = hugchatter(question)
                
                if answer['answer']=="NO RESULT FOUND":
                    conversational_texts.append("**USER** :" + question) 
                    conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n"+str(answer['text'])+"\n")
                    paragraph = '\n'.join(conversational_texts)
                    save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
                    return conversational_texts[-1]
            else:
                return "Invalid Model Name. Please provide a valid model name."
            
            conversational_texts.append("**USER** :\n" + question) # Appending user input to conversational_texts
            conversational_texts.append("**LLM MODEL** ({}):".format(model_name)+"\n```pddl"+ answer['answer'] + "\n```") # Appending LLM model output to conversational_texts
            
            save_text_to_file(answer['answer'], file_path) # Saving the generated code to a file
        
            global_counter += 1 # Incrementing the global counter for the number of times the API is called.
            
            final = llm_to_pddl(True) # Calling Pyperplan to check the generated domain code.
            
            if final['success']:
                final['domain'] = conversational_texts[-1]
                paragraph = '\n'.join(conversational_texts)
                save_text_to_file(paragraph, 'testingfolder/conversation.md')
                logging.info(final)
                return final['domain'].split("pddl",1)[1].split('```')[0]
        
        # ---------------- Second run when user inputs the error code. -------------------
        elif error_code == True:
            
            logging.error("----- RUNNING FOR ERROR ---> {}".format(model_used)) # Logging the error for Model.
            
            code_with_error = get_code_from_previous_generated(file_path="testingfolder/sampledomain.pddl") # Getting the code from the file.
            
            file_path = "testingfolder/sampledomain.pddl"
            
            
            #  ------- Calling ChatGPT API for Generating PDDL Code. -------
            if model_used == "CHAT_GPT": # Calling chatgpt api model
                if global_counter <= 5:
                    error = code_with_error + "\n The above PDDL code produces the following error -> " + str(question) + "\n\n Requirement 1: Correct the error and give the entire PDDL code. \n Requirement 2: Do not create a problem file. Do not use conditional expressions. \n Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations."
                    error_formatted = "\n```pddl\n"+code_with_error +"\n```"+"\n The above code produces the following error: " + str(question) + "\n\n Requirement 1: Correct the error and give the entire PDDL code. \n Requirement 2: Do not create a problem file. Do not use conditional expressions. \n Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations."
                    conversational_texts.append("**USER** :" + error_formatted) # Appending user input to conversational_texts
                    logging.info("=========== CHAT COUNT ==========>> " + str(global_counter)) # Printing the global counter for the number of times the API is called.
                    answer = get_code_llm_openai(error) # Calling ChatGPT API for Generating PDDL Code for the error.
                    time.sleep(3)
                    
                    if answer['answer']=="NO RESULT FOUND":
                        conversational_texts.append("**USER** :" + question) 
                        conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n"+str(answer['text'])+"\n")
                        paragraph = '\n'.join(conversational_texts)
                        save_text_to_file(paragraph, 'testingfolder/conversation.md')
                        return conversational_texts[-1]
                    
                    else:
                        conversational_texts.append("**LLM MODEL** ({}):".format(model_used)+"\n```pddl"+ answer['answer'] + "\n```") # Appending LLM model output to conversational_texts
                    
                        save_text_to_file(answer['answer'], file_path) # Saving the generated code to a file.
                        time.sleep(3)
                        global_counter += 1 # Incrementing the global counter for the number of times the API is called.
                        
                        final = llm_to_pddl(True) # Calling Pyperplan to check the generated domain code.
                        
                        if final['success']: # If the domain code is correct.
                            final['domain'] = conversational_texts[-1]
                            paragraph = '\n'.join(conversational_texts)
                            save_text_to_file(paragraph, 'testingfolder/conversation.md') # Saving the conversation to a file.
                            return final['domain'] # Returning the domain code.
                        
                else: # If the global counter exceeds 10.
                    paragraph = '\n'.join(conversational_texts)
                    save_text_to_file(paragraph, 'testingfolder/conversation.md')
                    return conversational_texts[-2] # Returning the last conversation.
                    
            elif model_used == "HUGGING_FACE": # Calling huggingface api model
                
                if global_counter <= 30:
                    error = code_with_error + "\n The above PDDL code produces the following error -> " + str(question) + "\n\n Requirement 1: Correct the error and give the entire PDDL code. \n Requirement 2: Do not create a problem file. Do not use conditional expressions. \n Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations."
            
                    error_formatted = "\n```pddl\n"+code_with_error +"\n```"+"\n The above code produces the following error: " + str(question) + "\n\n Requirement 1: Correct the error and give the entire PDDL code. \n Requirement 2: Do not create a problem file. Do not use conditional expressions. \n Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations."
                    conversational_texts.append("**USER** :" + error_formatted) # Appending user input to conversational_texts
                    logging.info("=========== CHAT COUNT ==========>> " + str(global_counter)) # Printing the global counter for the number of times the API is called.
                    answer = hugchatter(error)
                    # flag = {'flag':False, 'chatID':answer['chatID'], 'cookies':answer['cookies']}
                    if answer['answer']=="NO RESULT FOUND":
                        conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n"+str(answer['text'])+"\n")
                        paragraph = '\n'.join(conversational_texts)
                        save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
                        text_return = conversational_texts[-1].split("**LLM MODEL**",1)[1]
                        return text_return
                    
                    conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n```pddl"+ answer['answer'] + "\n```") # Appending LLM model output to conversational_texts
                    save_text_to_file(answer["answer"], "testingfolder/sampledomain.pddl")
                    global_counter += 1
                    final = llm_to_pddl(True)
                    if final['success']:
                        final['domain'] = conversational_texts[-1]
                        return final
                else:
                    try:
                        paragraph = '\n'.join(conversational_texts)
                        save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
                        text_return = conversational_texts[-1].split("**LLM MODEL**",1)[1]
                        return text_return
                    except Exception as e:
                        print(" ----- API COUNTER ENDED ----- > ", e)
                        return "--- API ERROR: Please try again later !!!!! ----"
    
    except Exception as e:
        logging.error(" < --------- Exited Code -------- > ")
        return conversational_texts[-1].split("pddl",1)[1].split('```')[0]
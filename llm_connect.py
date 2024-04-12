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
            question = question+"\n \n Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```."

            if model_name == "CHAT_GPT": # Calling chatgpt api model
                answer = get_code_llm_openai(question)
                
            elif model_name == "HUGGING_FACE": # Calling huggingface api model
                answer = hugchatter(question)
                
                if answer['answer']=="NO RESULT FOUND":
                    conversational_texts.append("**USER** :" + question) 
                    conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n"+str(answer['text'])+"\n")
                    paragraph = '\n'.join(conversational_texts)
                    save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
                    return conversational_texts[-1]
            
            conversational_texts.append("**USER** :" + question) # Appending user input to conversational_texts
            conversational_texts.append("**LLM MODEL** ({}):".format(model_name)+"\n```pddl"+ answer['answer'] + "\n```") # Appending LLM model output to conversational_texts
            save_text_to_file(answer['answer'], file_path)
            global_counter += 1
            final = llm_to_pddl()
            if final or not final:
                pass
        
        # ---------------- Second run when user inputs the error code. -------------------
        elif error_code == True:
            print("----- RUNNING FOR ERROR --- {}".format(model_used))
            code_with_error = get_code_from_previous_generated(file_path="testingfolder/sampledomain.pddl")
            file_path = "testingfolder/sampledomain.pddl"
            error = code_with_error + "\n The above code produces the following error: " + str(question) + "\n Requirement 1: Correct the error and give the entire pddl code. \n Requirement 2: Do not create a problem file. \n Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```."
            
            error_formatted = "\n```pddl\n"+code_with_error +"\n```"+"\n The above code produces the following error: " + str(question) + "\n Requirement 1: Correct the error and give the entire pddl code. \n Requirement 2: Do not create a problem file. \n Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```."
            conversational_texts.append("**USER** :" + error_formatted) # Appending user input to conversational_texts
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
                    save_text_to_file(paragraph, 'testingfolder/convo_open_ai_blocks.md')
                    return conversational_texts[-2]
                    
            elif model_used == "HUGGING_FACE": # Calling huggingface api model
                
                if global_counter <= 10:
                    answer = hugchatter(error)
                    
                    if answer['answer']=="NO RESULT FOUND":
                        conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n"+str(answer['text'])+"\n")
                        paragraph = '\n'.join(conversational_texts)
                        save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
                        text_return = conversational_texts[-1].split("**LLM MODEL**",1)[1]
                        return text_return
                    
                    conversational_texts.append("**LLM MODEL** ({}):".format(model_used) +"\n```pddl"+ answer['answer'] + "\n```") # Appending LLM model output to conversational_texts
                    save_text_to_file(answer["answer"], "testingfolder/sampledomain.pddl")
                    global_counter += 1
                    final = llm_to_pddl()
                    if final or not final:
                        pass
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
        print(" ----- ERROR HANDLED ----- > ", e)
        paragraph = '\n'.join(conversational_texts)
        save_text_to_file(paragraph, 'testingfolder/convo_mistral_ai_blocks.md')
        # text_return = conversational_texts[-1].split("**LLM MODEL**",1)[1]
        return conversational_texts[-1]
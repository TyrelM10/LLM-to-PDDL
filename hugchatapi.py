from hugchat import hugchat
from hugchat.login import Login
from config import HUGGING_EMAIL, HUGGING_PWD
import logging
import re
import requests
import time

def read_file_length(file_path):
    words = []
    with open(file_path, 'r') as file:
        for line in file:
            line_words = line.strip().split()
            words.extend(line_words)
    return len(words)

def save_text_to_file(text, file_path):
    with open(file_path, 'w') as file:
        file.write(text)

def hugchatter(question):
    print("Hugging Chat API")
    # Log in to huggingface and grant authorization to huggingchat
    cookie_path_dir = "./cookies"
    sign = Login(HUGGING_EMAIL, HUGGING_PWD)
    cookies = sign.login(cookie_dir_path=cookie_path_dir, save_cookies=True)

    # Create your ChatBot
    # CHATBOT FOR LLAMA3
    # chatbot = hugchat.ChatBot(cookies=cookies.get_dict(), default_llm=1, system_prompt="You are an assistant to generate PDDL code for natural language text input descriptions and correct errors in PDDL code to solve in a STRIPS Planner. Please do not add comments and explanations to the output and only give code in PDDL format in code blocks designed as ```pddl (Your Generated Code Here) ```.")  # or cookie_path="usercookies/<email>.json"
    
    # CHATBOT FOR MISTRALAI
    chatbot = hugchat.ChatBot(cookies=cookies.get_dict(), default_llm=3, system_prompt="You are an assistant to generate PDDL code for natural language text input descriptions and correct errors in PDDL code to solve in a STRIPS Planner. Instruction: Please do not add comments and explanations to the output and only give code in PDDL format in code blocks designed as ```pddl (Your Generated Code Here) ```. PLEASE DO NOT USE conditional expressions, functions or derived functions, equality or any syntax from PDDL2.1 and higher.")  # or cookie_path="usercookies/<email>.json"
    
    # Non stream response
    query_result = chatbot.query(question, temperature=0.0, web_search=False, stream=False)
    # time.sleep(10)
    save_text_to_file(query_result['text'], "query_result.txt")
    length_file = read_file_length("query_result.txt")
    
    logging.error("======== LENGTH OF QUERY TEXT : {} ==========".format(length_file))
    
    # FOR MISTRALAI
    while length_file < 300:
        time.sleep(5)
        logging.error(query_result["text"])
        query_result = chatbot.query(question, temperature=0.0, web_search=False, stream=False)
        save_text_to_file(query_result['text'], "query_result.txt")
        length_file = read_file_length("query_result.txt")
        logging.error("======== LENGTH OF QUERY TEXT : {} ==========".format(length_file))
    
    # print(query_result)
    # Get information about the current conversation
    info = chatbot.get_conversation_info()
    logging.error("=========================================================================================")
    logging.error(f"ID:{info.id}, MODEL:{info.model}")
    # logging.info(query_result['text']) # or query_result.text or query_result["text"]
    logging.error("=========================================================================================")
    
    # Parse the response
    try:
        answer = {"answer": query_result['text'].split("pddl",1)[1].split('```')[0], "text": query_result['text']}
        
    except Exception as e:
        logging.error("-------------- Hugging Chat API Result Parsing_Error ---------------")
        logging.error("---- No word PDDL in return -----> "+str(e))
        # print(query_result['text'])
        try:
            answer = {"answer":query_result['text'].split("lisp",1)[1].split('```')[0], "text": query_result['text']}
        except Exception as e:
            logging.error('----No word LISP in return-------> '+str(e))
            # print(query_result['text'])
            try:
                answer = {"answer": query_result['text'].split("ruby",1)[1].split('```')[0], "text": query_result['text']}
            except Exception as e:
                logging.error('---- No word Ruby in return-------> '+str(e))
                
                try:
                    answer = {"answer": query_result['text'].split("less",1)[1].split('```')[0], "text": query_result['text']}
                except Exception as e:
                    logging.error('---- No word Less in return-------> '+str(e))
                    try:
                        answer = {"answer": query_result['text'].split("PDDL",1)[1].split('```')[0], "text": query_result['text']}
                    except Exception as e:
                        logging.error('---- No word PDDL in return-------> '+str(e))
                        try:
                            answer = {"answer": query_result['text'], "text": query_result['text']}
                            logging.error("------ LAST RESORT IN QUERY -------")
                        except Exception as e:
                            logging.error('---- No text in return-------> '+str(e))
                            answer = {"answer": "NO RESULT FOUND", "text": query_result['text']}
        logging.error("--------- Hugging Chat API Result Parsing Error Completed ----------")
    
    # print("=========================================================================================")
    # print(type(answer['answer'])) # or query_result.text or query_result["text"]
    # print("=========================================================================================")
    # answer['chatID'] = info.id
    # answer['cookies'] = cookies.get_dict()
    return answer

# def mistral_ai(question):
#     import requests
#     API_URL = "https://api-inference.huggingface.co/models/mistralai/Mistral-7B-Instruct-v0.2"
#     headers = {"Authorization": "Bearer "}

#     def query(payload):
#         response = requests.post(API_URL, headers=headers, json=payload)
#         return response.json()
        
#     output = query({
#         "inputs": "Give me complete PDDL code for blocks world.",
#     })
#     print(output)
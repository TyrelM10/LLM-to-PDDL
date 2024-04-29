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

# def addId(chatId, cookies):
#           ## cookies should be in 'hf-chat=****-****-....' in this format
#       url = f"https://huggingface.co/chat/conversation/{chatId}/summarize"
#       payload={}
#       headers = {
#         'Cookie': f'{cookies}'
#       }
#       response = requests.request("POST", url, headers=headers, data=payload)
#       if response.status_code == 200:
#           return {'message': "Successfully Added", "status":200}
#       else:
#           return {'message': "Internal Error", "status": 500}
    
# def preserveContext(chatId,cookies):
#     ## cookies should be in 'hf-chat=****-****-....' in this format
#     url = f"https://huggingface.co/chat/conversation/{chatId}/__data.json?x-sveltekit-invalidated=1_"
#     payload={}
#     headers = {
#     'Cookie': f'{cookies}'
#     }
#     response = requests.request("GET", url, headers=headers, data=payload)
#     if response.status_code == 200:
#         return {'message': "Context Successfully Preserved", "status":200}
#     else:
#         return {'message': "Internal Error", "status": 500}

def hugchatter(question):
    print("Hugging Chat API")
    # Log in to huggingface and grant authorization to huggingchat
    cookie_path_dir = "./cookies"
    sign = Login(HUGGING_EMAIL, HUGGING_PWD)
    cookies = sign.login(cookie_dir_path=cookie_path_dir, save_cookies=True)

    # Create your ChatBot
    chatbot = hugchat.ChatBot(cookies=cookies.get_dict(), default_llm=1, system_prompt="You are an assistant to generate PDDL code for natural language text input descriptions and correct errors in PDDL code to solve in a STRIPS Planner. Please do not add comments and explanations to the output and only give code in PDDL format in code blocks designed as ```pddl (Your Generated Code Here) ```.")  # or cookie_path="usercookies/<email>.json"
    # chatbot.new_conversation(modelIndex=6, system_prompt="Generate only PDDL code with no comments.")
    # for i, model in enumerate(models):
    #     print(str(i) + model.name)
    
    # chatbot.switch_llm(3) # Switch to the first model
    
    # Get conversation list(local)
    # conversation_list = chatbot.get_conversation_list()
    # print(len(models))
    # question = "[INST]" + question + "[/INST]"
    # Non stream response
    query_result = chatbot.query(question, temperature=0.0, web_search=False, stream=False)
    # time.sleep(10)
    save_text_to_file(query_result['text'], "query_result.txt")
    length_file = read_file_length("query_result.txt")
    
    logging.error("======== LENGTH OF QUERY TEXT : {} ==========".format(length_file))
    
    # while length_file < 80:
    #     time.sleep(15)
    #     logging.error(query_result["text"])
    #     query_result = chatbot.query(question, temperature=0, web_search=False, stream=False)
    #     save_text_to_file(query_result['text'], "query_result.txt")
    #     length_file = read_file_length("query_result.txt")
    #     logging.error("======== LENGTH OF QUERY TEXT : {} ==========".format(length_file))
    
    # print(query_result)
    # Get information about the current conversation
    info = chatbot.get_conversation_info()
    logging.error("=========================================================================================")
    logging.error(f"ID:{info.id}, MODEL:{info.model}")
    # logging.info(query_result['text']) # or query_result.text or query_result["text"]
    logging.error("=========================================================================================")
    
    # matches = re.search(r'```', query_result['text'], re.DOTALL)
    # pddl_domain = matches.group(0)
    # print(pddl_domain)
    
    # # Managing Context In Hugging Chat
    # try:
    #     if flag['flag']: # Add id and Preserve context
    #         message = addId(info.id, cookies)
    #         print(message['message'])
    #         if message['status'] == 200:
    #             pmessage = preserveContext(info.id, cookies)
    #             logging.info(pmessage)
    #     else: # Only preserve context
    #         pmessage = preserveContext(flag['chatID'], flag['cookies'])
    #         logging.info(pmessage)
    # except Exception as e:
    #     print("Error in managing context in hugging chat")
    #     logging.info("Error in managing context in hugging chat")
    
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
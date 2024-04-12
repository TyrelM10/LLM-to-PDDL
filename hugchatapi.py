from hugchat import hugchat
from hugchat.login import Login
from config import HUGGING_EMAIL, HUGGING_PWD
import logging
import re

def hugchatter(question):
    # Log in to huggingface and grant authorization to huggingchat
    cookie_path_dir = "./cookies"
    sign = Login(HUGGING_EMAIL, HUGGING_PWD)
    cookies = sign.login(cookie_dir_path=cookie_path_dir, save_cookies=True)

    # Create your ChatBot
    chatbot = hugchat.ChatBot(cookies=cookies.get_dict())  # or cookie_path="usercookies/<email>.json"
    # chatbot.new_conversation(switch_to = True)
    models = chatbot.get_available_llm_models()
    chatbot.switch_llm(0) # Switch to the first model
    
    # Get conversation list(local)
    # conversation_list = chatbot.get_conversation_list()
    # print(len(models))
    # Get information about the current conversation
    
    # Non stream response
    query_result = chatbot.chat(question)
    
    # Get information about the current conversation
    info = chatbot.get_conversation_info()
    logging.info(f"ID:{info.id}, TITLE:{info.title}, MODEL:{info.model}")
    logging.info("=========================================================================================")
    logging.info(query_result['text']) # or query_result.text or query_result["text"]
    logging.info("=========================================================================================")
    # matches = re.search(r'```', query_result['text'], re.DOTALL)
    # pddl_domain = matches.group(0)
    # print(pddl_domain)
    
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
                logging.error('---- SAVE MY SOUL -------')
                # print("------ someone save me -------")
                answer = {"answer": "NO RESULT FOUND", "text": query_result['text']}
        logging.error("--------- Hugging Chat API Result Parsing Error Completed ----------")
    
    # print("=========================================================================================")
    # print(type(answer['answer'])) # or query_result.text or query_result["text"]
    # print("=========================================================================================")
    return answer
    
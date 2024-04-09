from hugchat import hugchat
from hugchat.login import Login
from config import HUGGING_EMAIL, HUGGING_PWD
import logging

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
    print(info.id, info.title, info.model, info.system_prompt, info.history)
    print("=========================================================================================")
    print(query_result['text']) # or query_result.text or query_result["text"]
    print("=========================================================================================")
    
    try:
        answer = query_result['text'].split("pddl",1)[1].split('```')[0]
        
    except Exception as e:
        logging.error("-------------- Hugging Chat API Result Parsing_Error ---------------")
        logging.error("---- ERROR IN PDDL CODE ----->"+str(e))
        # print(query_result['text'])
        try:
            answer = query_result['text'].split("lisp",1)[1].split('```')[0]
        except Exception as e:
            logging.error('---- ERROR NO WORD LISP ------->'+str(e))
            # print(query_result['text'])
            try:
                answer = query_result['text'].split("ruby",1)[1].split('```')[0]
            except Exception as e:
                logging.error('---- ERROR NO WORD RUBY ------->'+str(e))
                logging.error('---- SAVE MY SOUL -------')
                # print("------ someone save me -------")
                answer = "NO RESULT FOUND"
        logging.error("--------- Hugging Chat API Result Parsing Error Completed ----------")
        return answer
    
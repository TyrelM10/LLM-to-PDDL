from hugchat import hugchat
from hugchat.login import Login
from config import HUGGING_EMAIL, HUGGING_PWD

# Log in to huggingface and grant authorization to huggingchat
cookie_path_dir = "./cookies"
sign = Login(HUGGING_EMAIL, HUGGING_PWD)
cookies = sign.login(cookie_dir_path=cookie_path_dir, save_cookies=True)

# Create your ChatBot
chatbot = hugchat.ChatBot(cookies=cookies.get_dict())  # or cookie_path="usercookies/<email>.json"
chatbot.new_conversation(switch_to = True)
models = chatbot.get_available_llm_models()

# Get conversation list(local)
# conversation_list = chatbot.get_conversation_list()
# print(len(models))

# Non stream response
query_result = chatbot.chat("PDDL domain code for : The blocks world is one of the most famous planning domains in artificial intelligence. Imagine a set of cubes (blocks) sitting on a table. The goal is to build one or more vertical stacks of blocks. The catch is that only one block may be moved at a time: it may either be placed on the table or placed atop another block. Because of this, any blocks that are, at a given time, under another block cannot be moved.")
print(query_result['text'].split("ruby",1)[1].split('```')[0]) # or query_result.text or query_result["text"]

# Get information about the current conversation
info = chatbot.get_conversation_info()
print(info.id, info.title, info.model, info.system_prompt, info.history)
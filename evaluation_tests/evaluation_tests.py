from nltk.translate.bleu_score import sentence_bleu, SmoothingFunction
from pddl_parser import parse_pddl_domain_from_file as parse_domain
import spacy
# from hugchat import hugchat
# from hugchat.login import Login
# HUGGING_EMAIL = 'tjmenezes08@gmail.com'
# HUGGING_PWD = 'Tkcsmessi@1996'

# def hugger(words):
#     cookie_path_dir = "./cookies"
#     sign = Login(HUGGING_EMAIL, HUGGING_PWD)
#     cookies = sign.login(cookie_dir_path=cookie_path_dir, save_cookies=True)
#     words = str(words) + "\n For the dictionary provided please create a only the sentence as output."
#     # Create your ChatBot
#     chatbot = hugchat.ChatBot(cookies=cookies.get_dict(), default_llm=1, system_prompt="For the dictionary provided please create a only the sentence as output. You will output only the formed in english natural language sentence.")
#     query_result = chatbot.query(words, temperature=0.6)
#     return query_result['text']

nlp = spacy.load("en_core_web_lg")

def read_file(file_path):
    words = []
    with open(file_path, 'r') as file:
        for line in file:
            line_words = line.strip().split()
            words.extend(line_words)
    return words

def bleu_score_(golden_reference, test_reference):
    try:
        score = sentence_bleu([golden_reference], test_reference, weights=(1, 0, 0, 0), smoothing_function=SmoothingFunction().method1)
        # print(score)
        return score
    except Exception as e:
        print("Error in BLEU score calculation definition.", str(e))
        return None

def weighted_ngram_match_(tokens1, tokens2, n=4):
   try:
       score0 = sentence_bleu([tokens1], tokens2, weights=(1, 0, 0, 0), smoothing_function=SmoothingFunction().method1)
       score1 = sentence_bleu([tokens1], tokens2, weights=(0, 1, 0, 0), smoothing_function=SmoothingFunction().method2)
       score2 = sentence_bleu([tokens1], tokens2, weights=(0, 0, 1, 0), smoothing_function=SmoothingFunction().method3)
       score3 = sentence_bleu([tokens1], tokens2, weights=(0, 0, 0, 1), smoothing_function=SmoothingFunction().method4)
       final_score = sum([score0, score1, score2, score3])
       return final_score
   except Exception as e:
         print("Error in weighted n-gram match calculation definition.", str(e))
         return None
   
def ast_score(golden_len, test_len):
    ted = abs(golden_len - test_len)
    ast_score = 1 - (ted / max(golden_len, test_len))
    return ast_score

def ast_match(golden_reference, test_reference):
    try:
        golden_domain = parse_domain(golden_reference)
        test_domain = parse_domain(test_reference)
        try:
            ast_match_predicates = ast_score(len(golden_domain[':predicates']), len(test_domain[':predicates']))
        except Exception as e:
            print("Error in predicates parsing. No predicates.", str(e))
            ast_match_predicates = 0
            pass
        
        # ----------------- Requirements -----------------
        try:
            if not isinstance(golden_domain[':requirements'], list):
                golden_requirements = [golden_domain[':requirements']]
            else:
                golden_requirements = golden_domain[':requirements']
                
            if not isinstance(test_domain[':requirements'], list):
                test_requirements = [test_domain[':requirements']]
            else:
                test_requirements = test_domain[':requirements']
            
            ast_match_requirements = ast_score(len(golden_requirements), len(test_requirements))
            
        except Exception as e:
            print("Error in requirements parsing. No requirements.", str(e))
            ast_match_requirements = 0
            pass
        
        
        try:
            ast_match_structures = ast_score(len(golden_domain['structures']), len(test_domain['structures']))
        except Exception as e:
            print("Error in structures parsing. No structures.", str(e))
            ast_match_structures = 0
            pass
         
        number_of_zeroes = 3 - [ast_match_predicates, ast_match_requirements, ast_match_structures].count(0) 
        total_ast_score = (ast_match_predicates + ast_match_requirements + ast_match_structures) / number_of_zeroes
        return ast_match_predicates, ast_match_requirements, ast_match_structures, total_ast_score
    except Exception as e:
        print("Error in AST match calculation definition.", str(e))
        return None

def semantic_score(tokens1, tokens2):
    try:
        similarity_score = 0
        for token1 in tokens1:
            similarity_score_list = []
            for token2 in tokens2:
                nlp_token1 = nlp(token1)
                nlp_token2 = nlp(token2)
                if nlp_token1.has_vector and nlp_token2.has_vector:
                    # print(nlp_token1)
                    # print(nlp_token2)
                    # print(nlp_token1.similarity(nlp_token2))
                    similarity_score_list.append(nlp_token1.similarity(nlp_token2))
                elif token1 == token2:
                    # print("Token1: {0} Token2: {1}".format(token1, token2))
                    similarity_score_list.append(1.0)
                else:    
                    similarity_score_list.append(0)
            # print(similarity_score_list)
            # print("PRINT: {0} : {1}".format(token1, max(similarity_score_list)))
            similarity_score += max(similarity_score_list)
        # print(similarity_score)
        if len(tokens1) == len(tokens2):
            similarity_score /= len(tokens1)
        else:
            min_len = min(len(tokens1), len(tokens2))
            similarity_score /= min_len
        return similarity_score
    
    except Exception as e:
        print("Error in semantic score calculation definition.", str(e))
        return None
    
def semantic_match(golden_reference, test_reference):
    try:
        golden_domain = parse_domain(golden_reference)
        # print(golden_domain)
        test_domain = parse_domain(test_reference)
        # print(test_domain)
        # ----------------- Predicates -----------------
        #  Not handled for single predicates.
        try:
            golden_predicates = [gold_x[0] for gold_x in golden_domain[':predicates']]
            test_predicates = [test_x[0] for test_x in test_domain[':predicates']]
            
            predicates_similarity = semantic_score(golden_predicates, test_predicates)
        except Exception as e:
            print("Error in predicates parsing similarity. No predicates.", str(e))
            predicates_similarity = 0
            pass
        
        # ----------------- Requirements -----------------
        try:
            if not isinstance(golden_domain[':requirements'], list):
                golden_requirements = [golden_domain[':requirements']]
            else:
                golden_requirements = golden_domain[':requirements']
                
            if not isinstance(test_domain[':requirements'], list):
                test_requirements = [test_domain[':requirements']]
            else:
                test_requirements = test_domain[':requirements']
            
            golden_requirements = [gold_x.split(':')[1] for gold_x in golden_requirements]
            test_requirements = [test_x.split(':')[1] for test_x in test_requirements]
            
            requirements_similarity = semantic_score(golden_requirements, test_requirements)
        except Exception as e:
            print("Error in requirements parsing similarity. No requirements.", str(e))
            requirements_similarity = 0
            pass
        
        try:
            golden_structures = [gold_x['name'] for gold_x in golden_domain['structures']]
            test_structures = [test_x['name'] for test_x in test_domain['structures']]
            # print(golden_structures)
            # print(test_structures)
            structures_similarity = semantic_score(golden_structures, test_structures)
        except Exception as e:
            print("Error in structures parsing similarity. No structures.", str(e))
            structures_similarity = 0
            pass
        
        number_of_zeroes = 3 - [predicates_similarity, requirements_similarity, structures_similarity].count(0)
        total_semantic_score = (predicates_similarity + requirements_similarity + structures_similarity) / number_of_zeroes
        
        return predicates_similarity, requirements_similarity, structures_similarity, total_semantic_score
    
    except Exception as e:
        print("Error in semantic match calculation definition.", str(e))
        return None
    
def run_tests(golden_file_path, test_file_path):
    print("===== STARTING EVALUATION TESTS =====")
    golden_reference = read_file(golden_file_path)
    test_reference = read_file(test_file_path)
    print('-------------------------------------')
    print("| Golden Reference Length: {} |".format(len(golden_reference)))
    print('-------------------------------------')
    print("| Test Reference Length: {}   |".format(len(test_reference)))
    try:
        bleu_score = bleu_score_(golden_reference, test_reference)
        print('-------------------------------------')
        print('| BLEU score: {}                |'.format(round(bleu_score, 4)))
    except Exception as e:
        print("Error in BLEU score calculation.", str(e))
        print('-------------------------------------')
        
    try:
        weighted_ngram_match =  weighted_ngram_match_(golden_reference, test_reference)
        print('-------------------------------------')
        print("| Weighted n-gram match: {}     |".format(round(weighted_ngram_match,4)))
    except Exception as e:
        print("Error in weighted n-gram match calculation.", str(e))
        print('-------------------------------------')
    
    try:
        ast_match_pred, ast_match_req, ast_match_struct, total_ast = ast_match(golden_file_path, test_file_path)
        print('-------------------------------------')
        print("| AST Match for Predicates: {}     |".format(round(ast_match_pred,4)))
        print('-------------------------------------')
        print("| AST Match for Requirements: {}   |".format(round(ast_match_req,1)))
        print('-------------------------------------')
        print("| AST Match for Structures: {}     |".format(round(ast_match_struct,4)))
        print('-------------------------------------')
        print("| Total AST Match: {}           |".format(round(total_ast, 4)))
        
    except Exception as e:
        print("Error in AST match calculation.", str(e))
        print('-------------------------------------')
        
    try:
        semantic_match_pred, semantic_match_req, semantic_match_struct, ts = semantic_match(golden_file_path, test_file_path)
        print('-------------------------------------')
        print("| S_Match for Predicates: {}    |".format(round(semantic_match_pred,4)))
        print('-------------------------------------')
        print("| S_Match for Requirements: {}     |".format(round(semantic_match_req,4)))
        print('-------------------------------------')
        print("| S_Match for Action Names: {}  |".format(round(semantic_match_struct,4)))
        print('-------------------------------------')
        print("| Total Semantic Match: {}      |".format(round(ts, 4)))
    except Exception as e:
        print("Error in semantic match calculation.", str(e))
        print('-------------------------------------')
        
    print("====== ENDING EVALUATION TESTS ======")

golden_file_path = "/Users/tyrelmenezes/Desktop/PDDL using LLM/evaluation_tests/domains/gripper_golden.pddl"
test_file_path = "/Users/tyrelmenezes/Desktop/PDDL using LLM/evaluation_tests/test.pddl"

run_tests(golden_file_path, test_file_path)

# pr = parse_domain("/Users/tyrelmenezes/Desktop/PDDL using LLM/evaluation_tests/domains/depot_golden.pddl")
# sentences = []
# for x in pr['structures']:
#     sentences.append(hugger(x))

# for sentence in sentences:
#     print(sentence)

# test = read_file("/Users/tyrelmenezes/Desktop/PDDL using LLM/evaluation_tests/test1.txt")

# print(len(test))

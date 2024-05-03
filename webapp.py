from flask import Flask, render_template, jsonify, request
import config
from llm_connect import *
import logging
logging.basicConfig(filename="logfilename.log", level=logging.ERROR)

def page_not_found(e):
  return render_template('404.html'), 404


app = Flask(__name__)
# app.config.from_object(config.config['development'])

app.register_error_handler(404, page_not_found)


@app.route('/', methods = ['POST', 'GET'])
def index():
    if request.method == 'POST':
        question = request.form['prompt']
        # print(question)
        answer = generate_domain(question, "HUGGING_FACE", False)
        res = {}
        res['answer'] = answer
        return jsonify(res), 200
      
    return render_template('index.html', **locals())


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
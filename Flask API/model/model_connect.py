import nltk
from nltk.stem.lancaster import LancasterStemmer
nltk.download('punkt')
import numpy as np
import json
import random
import tflearn
from tensorflow.python.framework import ops
import pickle
import os
from pathlib import Path

stemmer = LancasterStemmer()

with open(f"{os.getcwd()}/datasets/symptoms.json") as file:
    data = json.load(file)

try:
    with open(f"{os.getcwd()}/datasets/symptoms.pickle", "rb") as f:
        words, labels, training, output = pickle.load(f)
except:
    words = []
    labels = []
    docs_x = []
    docs_y = []
    training = []
    output = []
    for intent in data['symptoms']:
        for pattern in intent['patterns']:
            wrds = nltk.word_tokenize(pattern)
            words.extend(wrds)
            docs_x.append(wrds)
            docs_y.append(intent['tag'])

            if intent['tag'] not in labels:
                labels.append(intent['tag'])
    words = [stemmer.stem(w.lower()) for w in words if w not in "?"]
    Words = sorted(list(set(words)))
    labels = sorted(labels)

    out_empty = [0 for __ in range(len(labels))]
    for x, doc in enumerate(docs_x):
        bag = []
        wrds = [stemmer.stem(w) for w in doc]

        for w in words:
            if w in wrds:
                bag.append(1)
            else:
                bag.append(0)
        output_row = list(out_empty[:])
        output_row[labels.index(docs_y[x])] = 1
        training.append(bag)
        output.append(output_row)

        with open(f"{os.getcwd()}/datasets/data.pickle", "wb") as f:
            pickle.dump((words, labels, training, output), f)

training = np.array(training)
output = np.array(output)
ops.reset_default_graph()
net = tflearn.input_data(shape=[None, len(training[0])])
net = tflearn.fully_connected(net, 8)
net = tflearn.fully_connected(net, 8)
net = tflearn.fully_connected(net, len(output[0]), activation="softmax")
net = tflearn.regression(net)
model = tflearn.DNN(net)


def bag_of_words(s, words):
    bag = [0 for _ in range(len(words))]
    s_words = nltk.word_tokenize(s)
    s_words = [stemmer.stem(word.lower()) for word in s_words]

    for se in s_words:
        for i, w in enumerate(words):
            if w == se:
                bag[i] = 1

    return np.array(bag)


def chat(message: str):
    print("Start talking with the bot (type quit to stop)!")
    result = model.predict([bag_of_words(message, words)])[0]
    result_index = np.argmax(result)
    tag = labels[result_index]
    if result[result_index] > 0.85:
        for tg in data['symptoms']:
            if tg['tag'] == tag:
                responses = tg['responses']
        print(f"{random.choice(responses)}")
        return random.choice(responses)
    else:
        return "I didn't get you, Try again!"



if Path(f"{os.getcwd()}/model/model.tflearn.meta").exists():
    model.load(f"{os.getcwd()}/model/model.tflearn")
else:
    model.fit(training, output, n_epoch=1000, batch_size=8, show_metric=True)
    model.save(f"{os.getcwd()}/model/model.tflearn")

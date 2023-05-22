import os
from textblob import TextBlob
from couchdb import Server
import ijson
from datetime import datetime
import re

def clean(msg):
    return ' '.join(re.sub("(@[A-Za-z0-9]+) | ([ ^ 0-9A-Za-z \t]) | (\w+: \/\/\S+)", " ", msg).split())

def dict_to_msg(o):
    return o['full_text']

city_list = ['sydney', 'melbourne', 'brisbane', 'adelaide', 'perth', 'hobart', 'darwin']
admin_dict = {'sydney': 'New South Wales', 'melbourne': 'Victoria', 'brisbane': 'Queensland',
              'adelaide': 'South Australia', 'perth': 'Western Australia', 'hobart': 'Tasmania',
              'darwin': 'Northern Territory'}

# Retrieve the credentials and connection details from environment variables
username = os.environ.get('COUCHDB_USERNAME')
password = os.environ.get('COUCHDB_PASSWORD')
host = os.environ.get('COUCHDB_HOST')
port = os.environ.get('COUCHDB_PORT')
database = os.environ.get('COUCHDB_DATABASE')
json_file = os.environ.get('HUGE_JSON_TWEET')

# Create the server URL using the retrieved credentials and connection details
server_url = f"http://{username}:{password}@{host}:{port}/"

server = Server(server_url)
db = []
if database in server:
    db = server[database]
else:
    db = server.create(database)

with open(json_file, 'r', encoding='utf-8') as f:
    objects = ijson.items(f, 'rows.item')
    # Here, 'objects' is like a generator, and you can use the next function to get the next value from it
    while True:
        try:
            raw = objects.__next__()
            json_obj = raw['doc']
            # We only want data with geolocation information
            if 'geo' in dict(json_obj['data']).keys() and json_obj['data']['geo'] != {} and json_obj['data']['lang'] == 'en' and 'includes' in dict(json_obj).keys():

                del json_obj['_id']
                del json_obj['_rev']
                if 'matching_rules' in dict(json_obj).keys():
                    del json_obj['matching_rules']
                del json_obj['data']['author_id']
                if 'conversation_id' in dict(json_obj['data']).keys():
                    del json_obj['data']['conversation_id']
                if 'entities' in dict(json_obj['data']).keys():
                    del json_obj['data']['entities']
                full_name = ''

                if type(json_obj['includes']) == list:
                    if len(json_obj['includes']) >= 1:
                        full_name = json_obj['includes'][0]['full_name']
                    else:
                        full_name = 'aa,aa'
                else:
                    full_name = json_obj['includes']['places'][0]['full_name']

                city = full_name.split(',')[0].lower()
                # Only consider GCC cities
                if city in city_list:
                    json_obj['city'] = city
                    json_obj['admin'] = admin_dict[city]

                    # Sentiment analysis
                    tweet_text = json_obj['data']['text']

                    # Clean unnecessary symbols
                    text = ''
                    if (type(tweet_text) == dict):
                        text = clean(dict_to_msg(tweet_text))
                    else:
                        text = clean(tweet_text)

                    blob = TextBlob(text)
                    polarity, subjectivity = blob.sentiment
                    json_obj['polarity'] = polarity
                    json_obj['subjectivity'] = subjectivity
                    if polarity < -0.3:
                        json_obj['negative'] = 1
                    else:
                        json_obj['negative'] = 0

                    # Get the date
                    date_str = json_obj['data']['created_at']

                    # Parse the date string
                    date_obj = datetime.fromisoformat(date_str[:-1])

                    # Create a dictionary with day, month, and year
                    date_dict = {
                        "day": date_obj.day,
                        "month": date_obj.month,
                        "year": date_obj.year
                    }

                    json_obj['date'] = date_dict

                    # Remove redundant fields
                    del json_obj['includes']
                    del json_obj['data']['sentiment']
                    del json_obj['data']['geo']

                    db.save(json_obj)

        except StopIteration as e:
            print("Data reading completed")
            break

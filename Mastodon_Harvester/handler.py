import couchdb
import configfile as config
from datetime import datetime
from couchdb import Server
import re
import os
from textblob import TextBlob

class CouchDBHandler:

    def __init__(self):
        self.db = None
        self.client = None

        self.post_buffer = []

        if config.DBCONFIG["address"] is None:
            raise Exception("CouchDBHandler: Configuration file has 'None' value for server IP address.")
        if config.DBCONFIG["port"] is None:
            raise Exception("CouchDBHandler: Configuration file has 'None' value for server port number.")
        if config.DBCONFIG["db"] is None:
            raise Exception("CouchDBHandler: Configuration file has 'None' value for server database name.")
        self.__get_parsed_data()


    def __get_parsed_data(self):
        self.__connect_to_db_()
        self.idsDB = set()

        for item in self.db.view('update/all_ids', reduce=False):
            self.idsDB.add(int(item.key))

    def clean(self, msg):
        return ' '.join(re.sub("(@[A-Za-z0-9]+) | ([ ^ 0-9A-Za-z \t]) | (\w+: \/\/\S+)", " ", msg).split())

    def handler_post(self, data):
        post_id = data["id"]
        if post_id not in self.idsDB:

            text = self.clean(msg=data["content"])
            blob = TextBlob(text)
            polarity, subjectivity = blob.sentiment

            negative = 0
            if polarity < -0.3:
                negative = 1
            else:
                negative = 0

            self.idsDB.add(post_id)
            self.post_buffer.append({
                "id": post_id,
                "type": "mastodon_status",
                "content": data["content"],
                "polarity": polarity,
                "subjectivity": subjectivity,
                "negative": negative,
                "created_at": datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            })
            if len(self.post_buffer) >= 200:
                print(f'{datetime.now()}-->Handler insert to CouchDB new:{len(self.post_buffer)} posts')
                self.__store_posts()



    def __store_posts(self):
        self.__connect_to_db_()
        for post in self.post_buffer:
            self.db.save(post)

        self.post_buffer = []



    ##############################
    # Connect to CouchDB
    ##############################
    def __connect_to_db_(self):

        self.server = couchdb.Server(f"https://{config.DBCONFIG['address']}/")
        username = os.environ.get('COUCHDB_USERNAME')
        password = os.environ.get('COUCHDB_PASSWORD')
        # 'admin', 'fM2ViRNmR3X6CLrXhe4X'
        self.server.resource.credentials = (username, password)
        self.db = self.server[config.DBCONFIG["db"]]



import couchdb
import configfile as config
from datetime import datetime


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

        self.deletDB = set()
        for item in self.db.view('deletions/all_ids', reduce=False):
            self.deletDB.add(int(item.key))



    def handler_post(self, data):
        post_id = data["id"]
        if post_id not in self.idsDB:
            self.idsDB.add(post_id)
            self.post_buffer.append({
                "id": post_id,
                "type": "mastodon_status",  
                "content": data["content"], 
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

        self.server = couchdb.Server(f"http://{config.DBCONFIG['address']}:{config.DBCONFIG['port']}/")
        self.server.resource.credentials = ('nsc', '66qqdwbdnk')
        self.db = self.server[config.DBCONFIG["db"]]



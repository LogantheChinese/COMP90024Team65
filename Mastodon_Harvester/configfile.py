#!/usr/bin/env python
import os
"""Configuration of MongoDB connector, used for storing the data in DB and filtering already seen users and tweets"""
# DBCONFIG={
#           "address"   : 'db.quantumlab.cloud',   #IP address of CouchDB, like '127.0.0.1' in string type"""
#           "port"      : 5984, #Port of CouchDB"""
#           "db"        : 'mastodon', #Name of CouchDB Database, like 'CollectedDatabase' in string type"""
#           }
#
#
# ACCOUNT = {
#     "mail": "283945589@qq.com", # account of Mastodon
#     "passwd": "66qqdwbdnk",
#     "file": "pytooter_clientcred.secret", #do not change
#     "URL": "https://mastodon.social", # the server of Mastodon
# }

DBCONFIG={
          "address"   : os.environ.get('DBCONFIG_ADDRESS'),   #'db.quantumlab.cloud',   #IP address of CouchDB, like '127.0.0.1' in string type"""
          "port"      : os.environ.get('DBCONFIG_PORT'), #Port of CouchDB"""
          "db"        :  os.environ.get('DBCONFIG_DB'), #Name of CouchDB Database, like 'CollectedDatabase' in string type"""
          }

ACCOUNT = {
    "mail": os.environ.get('ACCOUNT_MAIL'), # account of Mastodon
    "passwd": os.environ.get('ACCOUNT_PASSWORD'),
    "file": os.environ.get('ACCOUNT_FILE'), #do not change
    "URL": os.environ.get('SERVER_URL'), # the server of Mastodon
}

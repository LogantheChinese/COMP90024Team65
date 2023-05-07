#!/usr/bin/env python

"""Configuration of MongoDB connector, used for storing the data in DB and filtering already seen users and tweets"""
DBCONFIG={
          "address"   : '127.0.0.1',   #IP address of CouchDB, like '127.0.0.1' in string type"""
          "port"      : 5984, #Port of CouchDB"""
          "db"        : 'mastodon', #Name of CouchDB Database, like 'CollectedDatabase' in string type"""
          }


ACCOUNT = {
    "mail": "283945589@qq.com", # account of Mastodon
    "passwd": "66qqdwbdnk",
    "file": "pytooter_clientcred.secret", #do not change
    "URL": "https://mastodon.social", # the server of Mastodon
}

# Streaming crawler of Mastodon social media

## Requirements
This implementetation required following python packages that can be installed via following commands:
```
# Python 3
pip3 install -r requirements.txt
```
## Mastodon API user credentials

Mastodon API requires to create unique user cridentials for crawler authentication. This credentials should be created one time and stored for further usage. In order to create them we developed python script that creates them in case when the file is not exist, in other case credentials creation is ignored. In order to use this script execute:
```
python3 create_user_credentials.py 
```

## Streaming crawling execution

```
python3 mastodon_stream.py  
```

## Deployment

For real time data collection based on our implementation you should do the following:
- Create account at Mastodon socila media server
- Install defined requirements
- Generate Mastodon API user credentials
- Deploy local or remote CouchDB server
- Update configfile.py with your couchdb and account information
- Initiate the streaming crawler 

## view on CouchDB

For showing the content text on couchDB, we need to do the following:
- create a database
- create new view under it, design new document _design/update, then create new view. view code:
```javascript
function (doc) {
  if (doc.type === 'mastodon_status' && doc.content) {
    emit(doc.content, doc);
  }
}
```


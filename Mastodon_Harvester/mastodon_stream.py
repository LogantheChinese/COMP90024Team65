from mastodon import Mastodon
from streaming_listener import CallbackStreamListener
from handler import CouchDBHandler  
import configfile as config
import time

def login():
    mastodon = Mastodon(client_id = 'pytooter_clientcred.secret',)
    mastodon.log_in(config.ACCOUNT["mail"], config.ACCOUNT["passwd"], to_file = 'pytooter_usercred.secret')
    return mastodon

while True:
    try:
        print("start")
        API = login()
        print("API login finish")
        handler = CouchDBHandler()
        print("handler finish")

        listener = CallbackStreamListener(update_handler=handler.handler_post,
                                          local_update_handler=handler.handler_post,
                                          notification_handler=None,
                                          conversation_handler=None,
                                          unknown_event_handler=None,
                                          status_update_handler=None)
        oo = API.stream_public(listener=listener)
        print("listen finish")
    except Exception as e:
        print(f'Exception {e}')
        time.sleep(5*60)



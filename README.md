# erl_chat
A little chat server to introduce students to Erlang

2 versions: simple and advanced

## advanced /chat
- broadcasts to all other connections
- notifies clients on handle changes, connections, disconnections
- expects <handle>::<text>
- /who command prints out a comma-separate list of handles online
- default handle is a pid
- use priv/chat.html or priv/chat2.html

## simple /simple_chat
- broadcasts to all other channels
- notifies clients on connections, disconnections
- use priv/simple_chat.html

## hello handler
- hellow world style HTTP handler

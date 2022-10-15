# erl_chat
A little chat server to introduce students to Erlang

- broadcasts to all other connections
- notifies clients on handle changes, connections, disconnections
- expects <handle>::<text>
- /who command prints out a comma-separate list of handles online
- default handle is a pid

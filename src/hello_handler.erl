-module(hello_handler).

-export([init/2]).

init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/javascript">>},
        <<"jsonp2({\"my_data\": \"Hello from Erlang!\"});">>,
        Req0),
    {ok, Req, State}.

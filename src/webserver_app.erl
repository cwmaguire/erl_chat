%%%-------------------------------------------------------------------
%% @doc webserver public API
%% @end
%%%-------------------------------------------------------------------

-module(webserver_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/hello", hello_handler, []},
               {"/chat", chat_websocket_handler, []},
               {"/simple_chat", simple_chat_websocket_handler, []}]}
    ]),
    {ok, _} = cowboy:start_clear(webserver,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    webserver_sup:start_link().

stop(_State) ->
    ok.

%% internal functions

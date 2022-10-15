-module(chat_websocket_handler).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).
-export([terminate/3]).

-define(HOUR, 60 * 60 * 1000).

init(Req, State) ->
    io:format(user, "Websocket handler init: Req =~n~p~n", [Req]),
    {cowboy_websocket, Req, State, #{idle_timeout => 8 * ?HOUR}}.

websocket_init(State) ->
    chat_server:register_conn(),
    {ok, State}.

websocket_handle({text, Bin}, State) when is_binary(Bin) ->
    chat_server:route(Bin),
    {ok, State};
websocket_handle(_InFrame, State) ->
    %io:format(user, "Handle: State = ~p~n", [State]),
    %io:format(user, "Handle: InFrame = ~p~n", [InFrame]),
    {ok, State}.

websocket_info({send, Text}, State) ->
    {reply, {text, Text}, State};
websocket_info(Info, State) ->
    %io:format(user, "Info: State = ~p~n", [State]),
    io:format(user, "Ignored Info = ~p~n", [Info]),
    {ok, State}.

terminate(Reason, _Req, _State) ->
    chat_server:unregister_conn(Reason),
    ok.

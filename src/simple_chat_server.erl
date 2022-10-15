-module(simple_chat_server).

%% TODO
%%  - get information from Req (IP? User Agent?)
%%    - add an "/ip <handle>" command
%%  - emojies

-behaviour(gen_server).

%% API.
-export([start_link/0]).
-export([register_conn/0]).
-export([unregister_conn/1]).
-export([send/1]).
-export([state/0]).

%% gen_server.
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).

-record(state, {connections = [] :: list()}).

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

register_conn() ->
    gen_server:cast(simple_chat_server, {register, self()}),
    Pid = list_to_binary(pid_to_list(self())),
    Text = <<Pid/binary, " connected">>,
    gen_server:cast(simple_chat_server, {send, Text}).

unregister_conn(Reason) ->
    Pid = list_to_binary(pid_to_list(self())),
    Text = <<Pid/binary, " disconnected">>,
    gen_server:cast(simple_chat_server, {unregister, self()}),
    gen_server:cast(simple_chat_server, {send, Text}).

send(Text) ->
    gen_server:cast(simple_chat_server, {send, Text}).

%% API helpers

state() ->
    gen_server:call(simple_chat_server, state).

%% gen_server.

init([]) ->
	{ok, #state{}}.

handle_call(state, _From, State) ->
    {reply, State, State};
handle_call(_Request, _From, State) ->
	{reply, ignored, State}.

handle_cast({register, Connection}, State = #state{connections = Connections}) ->
    {noreply, State#state{connections = [Connection | Connections]}};
handle_cast({unregister, Connection},
            State = #state{connections = Connections0}) ->
    Connections = lists:delete(Connection, Connections0),
    {noreply, State#state{connections = Connections}};
handle_cast({send, Text},
            State = #state{connections = Connections}) ->
    broadcast(Text, Connections),
	{noreply, State};
handle_cast(_Ignored, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

%% Logic

broadcast(Text, Connections) ->
    %[C ! {send, Text} || C <- Connections, C /= From].
    [C ! {send, Text} || C <- Connections].

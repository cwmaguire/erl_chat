-module(chat_server).

%% TODO
%%  - get information from Req (IP? User Agent?)
%%    - add an "/ip <handle>" command
%%  - emojies

-behaviour(gen_server).

%% API.
-export([start_link/0]).
-export([register_conn/0]).
-export([unregister_conn/1]).
-export([route/1]).
-export([state/0]).

%% gen_server.
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).

-record(state, {connections = [] :: list(),
                conn_handles = #{} :: #{binary() => pid()}}).

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

register_conn() ->
    gen_server:cast(chat_server, {register, self()}),
    notify(connect).

unregister_conn(Reason) ->
    notify(Reason),
    gen_server:cast(chat_server, {unregister, self()}).

notify(timeout) ->
    gen_server:cast(chat_server, {command, self(), <<"[Server]">>, timeout});
notify(connect) ->
    gen_server:cast(chat_server, {command, self(), <<"[Server]">>, connect});
notify(_) ->
    gen_server:cast(chat_server, {command, self(), <<"[Server]">>, disconnect}).

route(HandleAndText) ->
    Self = self(),
    case binary:split(HandleAndText, <<"::">>) of
        [<<>>, <<"/", Command/binary>>] when size(Command) > 0 ->
            command(handle_from_pid(Self), Command);
        [<<"/", Command/binary>>] when size(Command) > 0 ->
            command(handle_from_pid(Self), Command);
        [Handle, <<"/", Command/binary>>] when size(Command) > 0 ->
            command(Handle, Command);
        [Text] ->
            send(handle_from_pid(Self), Text);
        [<<>>, Text] ->
            send(handle_from_pid(Self), Text);
        [Handle, Text] ->
            send(Handle, Text)
    end.

%% API helpers

send(Handle, Text) ->
    gen_server:cast(chat_server, {send, self(), Handle, Text}).

command(Handle, Command) ->
    gen_server:cast(chat_server, {command, self(), Handle, Command}).

state() ->
    gen_server:call(chat_server, state).

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
            State = #state{connections = Connections0,
                           conn_handles = ConnHandles0}) ->
    Connections = lists:delete(Connection, Connections0),
    ConnHandles =
        maps:filtermap(fun(_,V) when V == Connection ->
                               false;
                          (_, _) -> true
                       end,
                       ConnHandles0),
    {noreply, State#state{connections = Connections,
                          conn_handles = ConnHandles}};
handle_cast({command, From, Handle, Event},
            State = #state{connections = Connections,
                           conn_handles = ConnHandles})
  when Event == connect;
       Event  == disconnect;
       Event == timeout ->

    Message = case Event of
                  connect ->
                      <<"connected">>;
                  timeout ->
                      <<"timed out">>;
                  disconnect ->
                      <<"disconnected">>
              end,

    EventHandle = handle(From, ConnHandles),
    broadcast(Handle,
              <<EventHandle/binary, " ", Message/binary>>,
              Connections),
    {noreply, State#state{conn_handles = ConnHandles}};
handle_cast({command, From, Handle, <<"who">>},
             State = #state{conn_handles = ConnHandles0}) ->
    ConnHandles = register_handle(Handle, From, ConnHandles0),
    Text = iolist_to_binary([<<"Online: ">>, lists:join(",", maps:keys(ConnHandles))]),
    send_(From, Text),
    {noreply, State#state{conn_handles = ConnHandles}};
handle_cast({send, From, Handle, Text},
            State = #state{connections = Connections,
                          conn_handles = ConnHandles0}) ->
    OldHandle = handle(From, ConnHandles0),
    case Handle == OldHandle of
        true ->
            ok;
        false ->
            broadcast(<<"[Server]">>,
                      <<OldHandle/binary, " is now ", Handle/binary>>, Connections)
    end,
    ConnHandles = register_handle(Handle, From, ConnHandles0),
    broadcast(Handle, Text, Connections),
	{noreply, State#state{conn_handles = ConnHandles}};
handle_cast(_Ignored, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

%% Logic

register_handle(Handle, Pid, ConnHandles0) ->
    case ConnHandles0 of
        #{Handle := Pid} ->
            ConnHandles0;
        _ ->
            ConnHandles1 =
                maps:filter(fun(_, Pid0) when Pid0 == Pid ->
                                    false;
                               (_, _) ->
                                    true
                            end,
                            ConnHandles0),
            ConnHandles1#{Handle => Pid}
    end.

send_(From, Text) ->
    From ! {send, Text}.

broadcast(Handle, Text, Connections) ->
    %[C ! {send, Text} || C <- Connections, C /= From].
    [C ! {send, <<Handle/binary, ": ", Text/binary>>} || C <- Connections].

handle_from_pid(Pid) ->
    list_to_binary(pid_to_list(Pid)).

handle(Pid, ConnHandles) ->
    MaybeHandle =
        maps:to_list(maps:filter(fun(_, V) when V == Pid ->
                                         true;
                                    (_, _) ->
                                         false
                                 end,
                                 ConnHandles)),
    case MaybeHandle of
        [{Handle, _}] ->
            Handle;
        [] ->
            list_to_binary(pid_to_list(Pid))
    end.

%%%-------------------------------------------------------------------
%% @doc webserver top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(webserver_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    SupFlags = #{strategy => one_for_one,
                 intensity => 1,
                 period => 5},
    ChatServerSpec =
        #{id => chat_server,
          start => {chat_server, start_link, []},
          modules => [chat_server]},
    SimpleChatServerSpec =
        #{id => simple_chat_server,
          start => {simple_chat_server, start_link, []},
          modules => [simple_chat_server]},
    ChildSpecs = [ChatServerSpec,
                  SimpleChatServerSpec],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions

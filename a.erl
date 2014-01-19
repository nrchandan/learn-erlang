-module(a).
-compile(export_all).

sum([]) -> 0;
sum([H | T]) -> H + sum(T).

area2({rectangle, W, H}) -> W*H;
area2({square, S}) -> S*S;
area2(Any1) ->
    io:format("Don't know how to calculate area of ~p~n", [Any1]),
    ok.

sort([]) -> [];
sort([H]) -> [H];
sort([H | T]) ->
    List1=less_than(H, T),
    List2=greater_than(H, T),
    List3=sort(List1),
    List4=sort(List2),
    lists:append([List3, [H], List4]).

less_than(_H, []) -> [];
less_than(H, [H1 | T1]) ->
    less_than2(H, [H1 | T1], []).

less_than2(_H, [], C) -> C;
less_than2(H, [H1 | T1], C) ->
    if
        H1 < H ->
            less_than2(H, T1, [H1 | C]);
        true ->
            less_than2(H, T1, C)
    end.

greater_than(_H, []) -> [];
greater_than(H, [H1 | T1]) ->
    greater_than2(H, [H1 | T1], []).

greater_than2(_H, [], C) -> C;
greater_than2(H, [H1 | T1], C) ->
    if
        H1 > H ->
            greater_than2(H, T1, [H1 | C]);
        true ->
            greater_than2(H, T1, C)
    end.
%

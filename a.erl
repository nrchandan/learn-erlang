-module(a).
-compile(export_all).

%
% Sum of numbers in a list
%
sum([]) -> 0;
sum([H | T]) -> H + sum(T).
%
% Reverses a string
%
reverse([]) -> [];
reverse([H | T]) ->
    reverse2([H | T], []).

reverse2([], C) -> C;
reverse2([H | T], C) ->
    reverse2(T, [H | C]).
%
% Computes area
%
area({rectangle, W, H}) -> W*H;
area({square, S}) -> S*S;
area(Any1) ->
    io:format("Don't know how to calculate area of ~p~n", [Any1]),
    error.
%
% Sorts a list of numbers.
%
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
% Reads two numbers and prints their sum.
% Issue: THIS IS NOT WORKING :(
%
two_sum() ->
    {ok, A} = io:fread("Enter first number>", "~d"),
    io:format("You entered ~p~n", A),
    {ok, B} = io:fread("Enter second number>", "~d"),
    io:format("You entered ~p~n", B),
    C = A + B,
    io:format("Sum of the two numbers: ~p~n", C).
%
% Returns true if provided string is a palindrome.
% Issue: Raises "** exception error: bad argument" for floats
%
palindrome([]) -> true;
palindrome([_H]) -> true;
palindrome([H | T]) ->
    L = [H | T],
    MID = length(L),
    if
        MID rem 2 == 0 ->
            MID1 = MID div 2;
        true ->
            MID1 = (MID div 2) + 1
    end,
    SECOND_HALF = lists:nthtail(MID1, L),
    lists:prefix(lists:reverse(SECOND_HALF), L);
palindrome(N) ->
    palindrome(integer_to_list(N)).
%
% Generates the smallest palindrome number greater than the input number
%
next_palin(N) ->
    next_palin2(N, false).

next_palin2(N, B) ->
    if
        B ->
            N;
        true ->
            next_palin2(N+1, palindrome(N+1))
    end.

    
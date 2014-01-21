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
    {ok, [A]} = io:fread("Enter first number>", "~d"),
    io:format("You entered ~p~n", [A]),
    {ok, [B]} = io:fread("Enter second number>", "~d"),
    io:format("You entered ~p~n", [B]),
    C = A + B,
    io:format("Sum of the two numbers: ~p~n", [C]).
%
% Returns true if provided string or number is a palindrome.
% Issue: Raises "** exception error: bad argument" for floats
%
palindrome([]) -> true;
palindrome([H | T]) ->
    L = [H | T],
    L == lists:reverse(L);
palindrome(N) ->
    palindrome(integer_to_list(N)).
%
% Generates the smallest palindrome number greater than the input number
%
next_palin(N) ->
    Result = palindrome(N),
    if
        Result ->
            N;
        true ->
            next_palin(N+1)
    end.
%
% returns N fibonacci numbers.
%
fibonacci(1) -> [1];
fibonacci(2) -> [1, 1];
fibonacci(N) -> fibonacci(1, 1, [1, 1], N).

fibonacci(_Prev1, _Curr1, Num1, Count) when length(Num1) =:= Count ->
    lists:reverse(Num1);
fibonacci(Prev1, Curr1, Num1, Count) ->
    Next1 = Prev1 + Curr1,
    fibonacci(Curr1, Next1, [Next1 | Num1], Count).
%

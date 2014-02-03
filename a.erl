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
    reverse([H | T], []).

reverse([], C) -> C;
reverse([H | T], C) ->
    reverse(T, [H | C]).
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
palindrome(N) when is_integer(N) ->
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

fibonacci(_Prev, _Curr, Num1, Count) when length(Num1) =:= Count ->
    lists:reverse(Num1);
fibonacci(Prev, Curr, Num1, Count) ->
    Next1 = Prev + Curr,
    fibonacci(Curr, Next1, [Next1 | Num1], Count).
%
% prints a triangle of stars e.g. print_stars(3) gives this:
% ***
% **
% *
print_stars(0) -> ok;
print_stars(N) ->
    print_stars_row(N),
    io:format("\n"),
    print_stars(N-1).
%
print_stars_row(0) -> ok;
print_stars_row(N) ->
    io:format("*"),
    print_stars_row(N-1).
%
% prints a triangle of stars e.g. print_stars(3) gives this:
% ***
%  **
%   *
print_stars2(0) -> ok;
print_stars2(N) ->
    print_stars2(N, 0).
%
print_stars2(0, _) -> ok;
print_stars2(N, S) ->
    print_spaces_row(S),
    print_stars_row(N),
    io:format("\n"),
    print_stars2(N-1, S+1).
%
print_spaces_row(0) -> ok;
print_spaces_row(N) ->
    io:format(" "),
    print_spaces_row(N-1).
    
%
% Finds and prints the smallest fibonacci number that shares a common
% factor with the input number 'k'
% DEBUG THIS.
%
find_fib_factor(K) ->
    find_fib_factor(K, 1, 2).

find_fib_factor(K, Prev, Curr) ->
    A = find_fib_factor(K, Prev, Curr, 2),
    if
        A == 0 ->
            find_fib_factor(K, Curr, Prev + Curr, 2);
        true ->
            A
    end.

find_fib_factor(K, Prev, Curr, N) ->
    if
        (N rem K == 0) and (N rem Curr == 0) ->
            N;
        N == K ->
            0;
        true ->
            find_fib_factor(K, Prev, Curr, N+1)
    end.

%
% Simple factorial
%
factorial1(0) -> 1;
factorial1(N) ->
    N * factorial1(N-1).
%
% Tail recursive factorial
%
factorial(0) -> 1;
factorial(N) ->
    factorial(N, 1).

factorial(0, C) -> C;
factorial(N, C) ->
    factorial(N-1, C*N).
%
%
%
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, C) when C*C > N -> true;
is_prime(N, C) when N rem C =:= 0 -> false;
is_prime(N, C) -> is_prime(N, C+1).
%
%
%
%primeis(N, C, _L) when C*C > N -> true;
%primeis(N, C, _L) when N rem C =:= 0 -> false;
%primeis(N, C, []) ->



    
%
% Returns smallest prime number greater than N
%
next_prime(N) ->
    B = is_prime(N+1),
    if
        B ->
            N+1;
        true ->
            next_prime(N+1)
    end.
%
%
%
fib(0) -> 1;
fib(1) -> 1;
fib(N) -> fib(1, 1, N-2).

fib(_Prev, Curr, 0) ->
    Curr;
fib(Prev, Curr, N) ->
   fib(Curr, Prev + Curr, N-1).
%
% Returns list of elements smaller than N that are multiples of 3 or 5 
% DEBUG THIS.  
%
mult35(N) ->
    mult35(N, []).

mult35(N, L) ->
    if
        N == 0 ->
            L;
        (N rem 3 =:= 0) or (L rem 5 =:= 0) ->
            io:format(N),
            mult35(N, [N | L]);
        true ->
            mult35(N-1, L)
    end.
%
%
%
sum_mult35(N) ->
    lists:sum([X || X <- lists:seq(1, N-1), (X rem 3 ==0) or (X rem 5 == 0)]).
%
%
%
pythogorean(N) -> 
    [{A, B, C} || A <- lists:seq(1, N),
                    B <- lists:seq(1, N),
                    C <- lists:seq(1, N),
                    A >= B,
                    B >= C,
                    A < B + C,
                    A*A =:= B*B + C*C].
%
%
%
fibo(_P, C, S) when C > 4000000 -> S;
fibo(P, C, S) when (C rem 2) =:= 0 -> fibo(C, P+C, S+C);
fibo(P, C, S) -> fibo(C, P+C, S).
%
% Largest Prime Factor
%
prime_factor(N) -> prime_factor(N, 2, []).
prime_factor(N, C, L) ->
    R = is_prime(C),
    if
        C > N ->
            L;
        R and (N rem C) =:= 0 ->
            prime_factor(N, C+1, [C | L]);
        true ->
            prime_factor(N, C+1, L)
    end.
%
%
%
prime_factors(N) -> [X || X <- lists:seq(2, round(math:sqrt(N))),
                                (N rem X) =:= 0,
                                is_prime(X)].
prime_factors_max(N) -> lists:max(prime_factors(N)).
%
% Returns all primes less than N
%
first_palin([H | T]) ->
    R = palindrome(H),
    if
        R ->
            H;
        true ->
            first_palin(T)
    end.

%
% Segmenting the find by S -> 9 to 1; processing 10% at a time
%
largest_palin_product(_N, S) when S =:= 0 -> false;
largest_palin_product(N, S) ->
    L = S * round(math:pow(10, N-1)),
    H = ((S + 1) * round(math:pow(10, N-1))) - 1,
    A = [X * Y || X <- lists:seq(L, H), Y <- lists:seq(L, H)],
    Result = lists:any(fun palindrome/1, A),
    if
        Result ->
            first_palin(lists:reverse(lists:sort(A)));
        true ->
            largest_palin_product(N, S-1)
    end.
%
%
%
primes_upto(N) -> primes_upto(N, 0).
primes_upto(1, C) -> C;
primes_upto(N, C) ->
    R = is_prime(N),
    if
        R ->
            primes_upto(N-1, C+1);
        true ->
            primes_upto(N-1, C)
    end.
%
%
%
primes_to(N) -> primes_to(N, 2, [], 0).
primes_to(N, Next, _List, Count) when Next > N -> 
    %io:format("~p~n", List),
    Count;
primes_to(N, Next, List, Count) ->
    IsNotPrime = not prime_is(Next, List),
    %SmallerList = lists:reverse([X || X <- List, X*X =< Next]),
    %IsNotPrime = lists:any(fun(X) -> (Next rem X) =:= 0 end, SmallerList),
    if
        IsNotPrime ->
            primes_to(N, Next+1, List, Count);
        true ->
            %io:format("~p ~p ~p~n", [N,Next+1,Count+1]),
            primes_to(N, Next+1, List ++ [Next], Count+1)
    end.

prime_is(_N, []) -> true;
prime_is(N, [H | _T]) when N < H*H -> true;
prime_is(N, [H | _T]) when N rem H =:= 0 -> false;
prime_is(N, [_H | T]) -> prime_is(N, T).

main(N) -> 
    length([X || X<-lists:seq(2, N), is_prime(X)]).
%
% Max of a list 
%
max(L) -> lists:foldl(fun(A, B) -> if A > B -> A; true -> B end end, hd(L), tl(L)).
%
% Factorial of a number
%
fact(X) -> lists:foldl(fun(A, B) -> A * B end, 1, lists:seq(1, X)).
%
% Filter using foldl and map
%




import math

def factorial(N):
    return reduce(lambda x, y: x * y, range(1, N))

def is_prime(N):
    for i in range(2, int(math.sqrt(N))):
        if N % i == 0:
            return False
    return True

if __name__ == '__main__':
    #print factorial(100000)
    print is_prime(101000300313001)
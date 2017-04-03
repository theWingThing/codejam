x = {}

def f(N, num):
  if N == num:
    return 1
  elif num in x:
    return x[num]
  x[num] = min(f(N, num+1), f(N, int(str(num)[::-1]))) + 1
  return x[num]

def main():
  for t in range(int(input())):
    N = int(input())
    ans = f(N, 1)
    print("Case #{}: {}".format(t+1, ans))

if __name__ == "__main__":
  main()
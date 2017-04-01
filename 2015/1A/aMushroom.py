def main():
  for t in range(int(input())):
    N = int(input())
    numbers = [int(x) for x in input().split()]

    anyN = 0
    prev = numbers[0]
    maxN = 0
    for n in numbers[1:]:
      if n < prev:
        x = prev - n
        anyN += x
        if x > maxN:
          maxN = x
      prev = n

    total = 0
    for n in numbers[:-1]:
      if n > maxN:
        total += maxN
      else:
        total += n
    print("Case #{}: {}".format(t+1, str(anyN) + " " + str(total)))

if __name__ == "__main__":
  main()
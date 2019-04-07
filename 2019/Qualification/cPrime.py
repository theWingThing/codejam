primeFactors = [5]

def findFactor(n):
  for i in primeFactors:
    if n % i == 0:
      return i

def main():
  for t in xrange(int(raw_input())):
    (N, L) = (int(x) for x in raw_input().split())
    nums = [int(x) for x in raw_input().split()]
    smallest = min(nums)
    n = findFactor(smallest)
    ans = []

    before = nums[:nums.index(smallest)]
    after = nums[nums.index(smallest)+1:]

    if len(after) > 0:    #setting the order of first primes
      if after[0] % n == 0:
        ans = [smallest / n, n]
      else:
        ans = [n, smallest / n]
    else:
      if before[0] % n == 0:
        ans = [n, smallest / n]
      else:
        ans = [smallest / n, n]

    for a in after:
      ans.append(a / ans[-1])
    for b in before:
      ans.insert(0, b / ans[0])
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()
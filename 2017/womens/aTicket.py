def main():
  for t in xrange(int(raw_input())):
    (F, S) = (int(x) for x in raw_input().split())
    seats = set()
    nums = {}
    for s in xrange(1,S+1):
      nums[s] = 0
    for f in xrange(F):
      (a, b) = (int(x) for x in raw_input().split())
      if (a, b) not in seats:
        nums[a] += 1
        if a != b:
          nums[b] += 1
        seats.add((a, b))
    ans = 0
    for n in nums:
      if nums[n] > ans:
        ans = nums[n]
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()

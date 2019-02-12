def main():
  for t in xrange(int(raw_input())):
    n = int(raw_input())
    nums = [int(x) for x in raw_input().split()]
    A = nums[0:][::2]
    B = nums[1:][::2]
    A.sort()
    B.sort()
    done = False
    for i in xrange(len(A)):
      if i > 0 and A[i] < B[i-1]:
        print "Case #{}: {}".format(t+1, i*2-1)
        done = True
        break
      if i < len(B) and A[i] > B[i]:
        print "Case #{}: {}".format(t+1, i*2)
        done = True
        break
    if not done:
      print "Case #{}: {}".format(t+1, "OK")

if __name__ == "__main__":
  main()


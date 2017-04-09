def main():
  for t in xrange(int(raw_input())):
    ans = raw_input()
    num = list(ans)
    prev = num[0]
    for i in xrange(1, len(num)):
      if num[i] < prev:
        #set all except first digit of same number to 0
        for j in xrange(i-1, 0, -1):
          if num[j] == num[j-1]:
            num[j] = '0'
          else:
            break
        #set everything after to 0
        for k in xrange(i, len(num)):
          num[k] = '0'
        ans = int("".join(num)) - 1
        break
      prev = num[i]
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()

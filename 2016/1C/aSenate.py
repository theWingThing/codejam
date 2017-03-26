_A = ord('A')

def checkMajority(senators):
  numSenators = sum(senators)
  for s in senators:
    if s > 0 and numSenators/s < 2:
      return True
  return False

def findLargest(senators):
  largest = senators[0]
  index = 0
  for (i, s) in enumerate(senators):
    if s > largest:
      largest = s
      index = i
  return index

def isEmpty(senators):
  return senators[findLargest(senators)] == 0

def main():
  for t in range(int(raw_input())):
    ans = ""
    N = int(raw_input())
    senators = [int(x) for x in raw_input().split()]
    while not isEmpty(senators):
      one = findLargest(senators)
      removeOne = senators[:]
      removeOne[one] -= 1
      two = findLargest(removeOne)
      removeTwo = removeOne[:]
      if removeTwo[two] > 0:
        removeTwo[two] -= 1
      else:
        removeTwo = None
      if removeTwo and not checkMajority(removeTwo):
        senators = removeTwo[:]
        ans += "" + chr(_A + one) + chr(_A + two) + " "
      else:
        senators = removeOne[:]
        ans += "" + chr(_A + one) + " "
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()

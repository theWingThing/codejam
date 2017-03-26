def main():
  for t in xrange(int(raw_input())):
    numbers = [0] * 10
    text = list(raw_input())
    while 'Z' in text:
      numbers[0] += 1
      text.remove('Z')
      text.remove('E')
      text.remove('R')
      text.remove('O')
    while 'W' in text:
      numbers[2] += 1
      text.remove('T')
      text.remove('W')
      text.remove('O')
    while 'X' in text:
      numbers[6] += 1
      text.remove('S')
      text.remove('I')
      text.remove('X')
    while 'G' in text:
      numbers[8] += 1
      text.remove('E')
      text.remove('I')
      text.remove('G')
      text.remove('H')
      text.remove('T')
    while 'S' in text:
      numbers[7] += 1
      text.remove('S')
      text.remove('E')
      text.remove('V')
      text.remove('E')
      text.remove('N')
    while 'T' in text:
      numbers[3] += 1
      text.remove('T')
      text.remove('H')
      text.remove('R')
      text.remove('E')
      text.remove('E')
    while 'V' in text:
      numbers[5] += 1
      text.remove('F')
      text.remove('I')
      text.remove('V')
      text.remove('E')
    while 'F' in text:
      numbers[4] += 1
      text.remove('F')
      text.remove('O')
      text.remove('U')
      text.remove('R')
    while 'O' in text:
      numbers[1] += 1
      text.remove('O')
      text.remove('N')
      text.remove('E')
    while 'N' in text:
      numbers[9] += 1
      text.remove('N')
      text.remove('I')
      text.remove('N')
      text.remove('E')
    ans = ""
    for (i, num) in enumerate(numbers):
      ans += str(i) * num
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()

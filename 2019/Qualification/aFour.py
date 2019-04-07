def main():
  for t in xrange(int(raw_input())):
    n = raw_input()
    x = ""
    y = ""
    for k in n:
      if k == '4':
        x += '1'
        y += '3'
      else:
        x += '0'
        y += k
    x = x.lstrip('0')
    if x == "":
      x = '0'
    print "Case #{}: {} {}".format(t+1, x, y)

if __name__ == "__main__":
  main()
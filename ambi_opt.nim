# import nimprof
import std/[tables, sequtils]
import os

let ambiChars = {
  'p': 'd', 'd': 'p',
  'o':'o',
  's':'s',
  'x':'x',
  'l':'l',
  'w':'m', 'm':'w',
  'b':'q', 'q':'b',
  'n':'u', 'u':'n',
  # Doubtful
  # 't':'t',
  # 'i':'l', 'l':'i', 'i':'i',
  # 'a':'e', 'e':'a',
  # 'y':'h', 'h':'y',
}.toTable

# The behaviour is slightly wrong for < 11 on the larger wordlist
# I think theres a boundery condition that causes it, but I'm too tired
# to look for it
const bytesRequest = 1 shl 10


proc isAmbi(buffer: array[bytesRequest, char], start: int, en: int): bool =
  var
    s = start
    e = en
  # echo start, " ", en
  while s <= e:
    # echo s, " ", e
    if buffer[e] != ambiChars[buffer[s]]:
      return false
    inc s
    dec e

  return true


if paramCount() < 1:
  echo "Please supply a word file"
  quit(1)


var
  file = open(paramStr(1))
  buffer: array[bytesRequest, char]
  bytesRead = 0
  ambigrams: seq[seq[char]] = @[]
  skip = false
  wStart = 0
  ch = ' '
  word: seq[char]

let bp = addr buffer

while true:
  bytesRead = file.readBuffer(bp, bytesRequest)
  for i in 0..bytesRead-1:
    ch = buffer[i]
    # echo i, ch
    if ch == '\n':
      if not skip and i > 0 and isAmbi(buffer, wStart, i-1):
        ambigrams.add(buffer[wStart..i-1])
      wStart = i + 1
      skip = false
    elif not skip and ch notin ambiChars:
      # echo "skip", ch
      skip = true

  if bytesRead < bytesRequest: break

  file.setFilePos(wStart - bytesRequest, fspCur)
  wStart = 0


echo ambigrams.len
echo ambigrams

# with 2**25 memory
# 0.10user 0.01system 0:00.12elapsed 99%CPU (0avgtext+0avgdata 30648maxresident)k
# 0inputs+0outputs (0major+7354minor)pagefaults 0swaps
#
# with 2**10
# 0.13user 0.01system 0:00.14elapsed 98%CPU (0avgtext+0avgdata 1680maxresident)k
# 0inputs+0outputs (0major+112minor)pagefaults 0swaps

# with 2**25
# total executions of each stack trace:
# Entry: 1/2 Calls: 69/70 = 98.57% [sum: 69; 69/70 = 98.57%]
#   ambi_opt.nim: ambi_opt 69/70 = 98.57%

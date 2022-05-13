import nimprof
import std/[sugar, tables, strutils]
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


proc isAmbi(word: string): bool =
  for i in 0..(word.len div 2):
    if word[i] notin ambiChars or word[word.len - i - 1] != ambiChars[word[i]]:
      return false
  return true

if paramCount() < 1:
  echo "Please supply a word file"
  quit(1)

let
  file = open(paramStr(1))
  wordList = file.readAll()

var
  ambigrams: seq[string] = @[]
  wStart = 0

for i in 0..wordList.len-1:
  if wordList[i] == '\n':
    if wordList[wStart..i-1].isAmbi:
      ambigrams.add(wordList[wStart..i])
    wStart = i+1


echo ambigrams.len
echo ambigrams

# 0.19user 0.01system 0:00.21elapsed 99%CPU (0avgtext+0avgdata 30708maxresident)k
# 0inputs+0outputs (0major+7350minor)pagefaults 0swaps


# total executions of each stack trace:
# Entry: 1/11 Calls: 56/202 = 27.72% [sum: 56; 56/202 = 27.72%]
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 2/11 Calls: 42/202 = 20.79% [sum: 98; 98/202 = 48.51%]
#   comparisons.nim: <=% 44/202 = 21.78%
#   gc.nim: newObj 77/202 = 38.12%
#   system.nim: [] 119/202 = 58.91%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 3/11 Calls: 42/202 = 20.79% [sum: 140; 140/202 = 69.31%]
#   system.nim: [] 119/202 = 58.91%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 4/11 Calls: 21/202 = 10.40% [sum: 161; 161/202 = 79.70%]
#   system.nim: .. 21/202 = 10.40%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 5/11 Calls: 12/202 = 5.94% [sum: 173; 173/202 = 85.64%]
#   gc.nim: newObj 77/202 = 38.12%
#   system.nim: [] 119/202 = 58.91%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 6/11 Calls: 11/202 = 5.45% [sum: 184; 184/202 = 91.09%]
#   comparisons.nim: <% 11/202 = 5.45%
#   gc.nim: newObj 77/202 = 38.12%
#   system.nim: [] 119/202 = 58.91%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 7/11 Calls: 9/202 = 4.46% [sum: 193; 193/202 = 95.54%]
#   arithmetics.nim: +% 10/202 = 4.95%
#   gc.nim: cellToUsr 9/202 = 4.46%
#   gc.nim: newObj 77/202 = 38.12%
#   system.nim: [] 119/202 = 58.91%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 8/11 Calls: 5/202 = 2.48% [sum: 198; 198/202 = 98.02%]
#   ambi_fast.nim: isAmbi 5/202 = 2.48%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%
# Entry: 9/11 Calls: 2/202 = 0.99% [sum: 200; 200/202 = 99.01%]
#   comparisons.nim: <=% 44/202 = 21.78%
#   alloc.nim: interiorAllocatedPtr 2/202 = 0.99%
#   gc.nim: newObj 77/202 = 38.12%
#   system.nim: [] 119/202 = 58.91%
#   ambi_fast.nim: ambi_fast 201/202 = 99.50%

# import nimprof
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
  if word[0] notin ambiChars: return false

  result = true
  for i in 0..(word.len div 2):
    if word[i] notin ambiChars or word[word.len - i - 1] != ambiChars[word[i]]:
      result = false

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

# 0.27user 0.01system 0:00.28elapsed 99%CPU (0avgtext+0avgdata 30608maxresident)k
# 0inputs+0outputs (0major+7347minor)pagefaults 0swaps


# total executions of each stack trace:
# Entry: 1/11 Calls: 73/280 = 26.07% [sum: 73; 73/280 = 26.07%]
#   system.nim: [] 160/280 = 57.14%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 2/11 Calls: 67/280 = 23.93% [sum: 140; 140/280 = 50.00%]
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 3/11 Calls: 48/280 = 17.14% [sum: 188; 188/280 = 67.14%]
#   comparisons.nim: <=% 51/280 = 18.21%
#   gc.nim: newObj 87/280 = 31.07%
#   system.nim: [] 160/280 = 57.14%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 4/11 Calls: 27/280 = 9.64% [sum: 215; 215/280 = 76.79%]
#   system.nim: .. 27/280 = 9.64%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 5/11 Calls: 25/280 = 8.93% [sum: 240; 240/280 = 85.71%]
#   ambi_fast.nim: isAmbi 25/280 = 8.93%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 6/11 Calls: 15/280 = 5.36% [sum: 255; 255/280 = 91.07%]
#   comparisons.nim: <% 16/280 = 5.71%
#   gc.nim: newObj 87/280 = 31.07%
#   system.nim: [] 160/280 = 57.14%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 7/11 Calls: 12/280 = 4.29% [sum: 267; 267/280 = 95.36%]
#   gc.nim: newObj 87/280 = 31.07%
#   system.nim: [] 160/280 = 57.14%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 8/11 Calls: 8/280 = 2.86% [sum: 275; 275/280 = 98.21%]
#   arithmetics.nim: +% 8/280 = 2.86%
#   gc.nim: cellToUsr 8/280 = 2.86%
#   gc.nim: newObj 87/280 = 31.07%
#   system.nim: [] 160/280 = 57.14%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%
# Entry: 9/11 Calls: 3/280 = 1.07% [sum: 278; 278/280 = 99.29%]
#   comparisons.nim: <=% 51/280 = 18.21%
#   alloc.nim: interiorAllocatedPtr 4/280 = 1.43%
#   gc.nim: newObj 87/280 = 31.07%
#   system.nim: [] 160/280 = 57.14%
#   ambi_fast.nim: ambi_fast 279/280 = 99.64%

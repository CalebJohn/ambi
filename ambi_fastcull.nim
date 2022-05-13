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
  for i in 0..(word.len div 2):
    if word[word.len - i - 1] != ambiChars[word[i]]:
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
  skip = false
  wStart = 0
  ch = ' '

for i in 0..wordList.len-1:
  ch = wordList[i]
  if ch == '\n':
    if not skip and wordList[wStart..i-1].isAmbi:
      ambigrams.add(wordList[wStart..i-1])
    wStart = i+1
    skip = false
    continue
  if not skip and ch notin ambiChars:
    skip = true


echo ambigrams.len
echo ambigrams

# 0.08user 0.03system 0:00.12elapsed 99%CPU (0avgtext+0avgdata 30604maxresident)k
# 0inputs+0outputs (0major+7347minor)pagefaults 0swaps

# total executions of each stack trace:
# Entry: 1/3 Calls: 69/71 = 97.18% [sum: 69; 69/71 = 97.18%]
#   ambi_fastcull.nim: ambi_fastcull 70/71 = 98.59%

#!/usr/bin/python
# coding: UTF-8
import MySQLdb
import sys
import MeCab
import operator
connector = MySQLdb.connect(host="localhost",db="anatock_development",user="ne250240",passwd="1006",charset="utf8")
cursor = connector.cursor()
n = sys.argv
sql = "select * from news where date = "+"'"+n[1]+"'"
cursor.execute(sql)
mecab = MeCab.Tagger("mecabrc")

def check():
    sql = "select * from words"
    cursor.execute(sql)
    for record in cursor:
        print record[0],record[1],record[2],record[3],record[4],record[5],record[6],record[7],record[8],record[9]

def wordcount(wordnum):
    for word,count in word_items:
        if(len(word) <= 3):
            None
        else:
            for i in moji:
                for num in range(0,wordnum):
                    if(word == twenty[num]):
                        twentycnt[num] = count
    s = ""
    for num in range(0,wordnum):
        s = (s + str(twentycnt[num])+" ")
    print s, record[1],record[2]
    cursor.executemany('INSERT INTO words(num,date,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',[(record[1],record[2],twentycnt[0],twentycnt[1],twentycnt[2],twentycnt[3],twentycnt[4],twentycnt[5],twentycnt[6],twentycnt[7],twentycnt[8],twentycnt[9],twentycnt[10],twentycnt[11],twentycnt[12],twentycnt[13],twentycnt[14],twentycnt[15],twentycnt[16],twentycnt[17],twentycnt[18],twentycnt[19],'2015-1-1','2015-1-1')])


wordss = {}
for record in cursor:
    text = record[4].encode('utf-8')
    data = []
    data.append(text)
    node = mecab.parseToNode("\n".join(data))
    words = {}
    moji = ['1','2','3','4','5','6','7','8','9','0','<','>','[',']','%','(',')','-']
    twenty = ['順位','下位','前日','前回','続落','人気','先物','上場','現在','下げ','相場','強気','年初来','進捗','後場','反落','出来高','小売','市況','大福']
    wordnum = 20
    
#1ニュース
    while node:
        word = node.surface
        if word and node.posid >= 36 and node.posid <= 67:
            if not words.has_key(word):
                words[word] = 0
            words[word] += 1
        node = node.next
    word_items = words.items()
    word_items.sort(key=operator.itemgetter(1),reverse=True)
    twentycnt = [0]*wordnum
    countword = 0
    wordcount(wordnum)
    
check()
#connector.commit()
cursor.close()
connector.close()

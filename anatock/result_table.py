#!/usr/bin/python
# coding: UTF-8
import MySQLdb
import sys
import math
import MeCab
import operator
from scipy.stats import norm
connector = MySQLdb.connect(host="localhost",db="anatock_development",user="root",passwd="3115",charset="utf8")
cursor = connector.cursor()
reg_coef = [0.0001387,-0.0064,-0.0009045,0.001662,-0.001982,0.0028084,-0.0004749,-0.0006142,0.0018674,-0.004725,0.001331,-0.0007644,0.0003682,0.0003564,0.0004057,0.005938,0.0003314,-0.001666,0.0042234,0.0011134]
svm_coef = [-1.13772911,-0.730767739,-0.100028385,-0.000281664,-0.396185825,-0.151243711,-0.334388378,-0.289696786,0.071843072,-1.24032214,0.188639729,-0.333403112,-0.01533037,-0.676108823,-0.012559821,0.068759252,-0.25692865,-0.159290923,0.285599286,-0.059775545]
logi_coef = [-1.638911,-0.6864262,-0.085612,0.027606,-0.275321,-0.054965,-0.262145,-0.253026,0.20418,-0.547623,0.267629,-0.516287,-0.004963,-0.293496,-0.124225,0.173072,-0.151901,-0.152731,0.390793,-0.062249]
mecab = MeCab.Tagger("mecabrc")

def new_sprice(cnt):
    sort = " order by date asc"
    snum = str(cnt)
    sql = "select * from prices where num = "+snum+sort
    cursor.execute(sql)
    num = 0
    for record in cursor:
        #print record[2],record[6]
        num = record[6]
    return record[6]

def adjust(pro):
    if(pro > 0.9):
        pro = pro - 0.1
    if(pro < 0.1):
        pro = pro + 0.1
    return pro

def logi_svm(cnt,new_date):
    snum = str(cnt)
    sql = "select * from words where num = "+snum+" and date = '"+new_date+"'"
    cursor.execute(sql)
    count = prob = ratio = 0
    for record in cursor:
        count = count + 1
        svm = 0.928339293
        logi = 0.131892
        reg = -0.002913
        for i in range(2,22):
            svm = svm + record[i]*svm_coef[i-2]
            logi = logi + record[i]*logi_coef[i-2]
            reg = reg + record[i]*reg_coef[i-2]
        prob = prob + adjust(math.exp(logi)) + adjust(math.exp(svm))
        ratio = ratio + reg
        #print svm,logi,prob,reg,record[1]
    if(count > 0):
        #print cnt,new_date,round((prob/(count*2))*100,2),round((1+(ratio/count))*new_sprice(cnt),1)
        cursor.executemany('INSERT INTO results(num,date,prob,ratio,expe,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s)',[(cnt,new_date,round((prob/(count*2))*100,2),round((ratio/count)*new_sprice(cnt),1),round((1+(ratio/count))*new_sprice(cnt),1),'2015-1-1','2015-1-1')])
    if(count == 0):
        arima(cnt)

def check(cnt):
    snum = str(cnt)
    sql = "select * from results where num = "+snum
    cursor.execute(sql)
    print "check"
    for record in cursor:
        print record[0],record[1],record[2],record[3],record[4],record[5]

def a_change(ago,next_price,a_price):
    ago[2] = ago[1]
    ago[1] = ago[0]
    ago[0] = (next_price - a_price)/a_price
    
def z_change(zansa):
    zansa[2] = zansa[1]
    zansa[1] = zansa[0]

def arima_sprice(cnt,ar1,ar2,ar3,ma1,ma2,ma3,ave):
    sort = " order by date asc"
    snum = str(cnt)
    sql = "select * from prices where num = "+snum+sort
    cursor.execute(sql)
    s_id = s_num = s_aprice =  count = arima = s_sprice =  0
    s_date = ""
    arima_k = [ar1,ar2,ar3,ma1,ma2,ma3,ave]
    ago = [0,0,0]
    zansa = [0,0,0]
    var = 0
    stdiv = 0
    for record in cursor:
        count = count + 1
        if(count > 1):
            a_change(ago,record[8],s_aprice)
            if(count > 4):
                zansa[0] = ago[0] - arima
                arima = 0
        if(count > 3):
            for i in range(3):
                arima = arima + arima_k[i] * (ago[i] - ave)
            for i in range(3):
                arima = arima + arima_k[i+3] * zansa[i]
            arima = arima + ave
            z_change(zansa)
            var = var + (arima - ave) * (arima - ave)
        s_sprice = record[6]
        s_num = record[1]
        s_date = record[2]
        s_aprice = record[8]
    if(count == 3):
        count = 4
    normal = norm.cdf(x = arima,loc=0,scale=math.sqrt(var/(count-3)))
    normal = adjust(normal) * 100
    ans_price = (1+arima)*s_sprice
    #print s_num,s_date,round(normal,2),round(ans_price,1)
    #print_arima
    cursor.executemany('INSERT INTO results(num,date,prob,ratio,expe,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s)',[(cnt,s_date,round(normal,2),round(arima*s_sprice,2),round(ans_price,1),'2015-1-1','2015-1-1')])

def ar_sprice(cnt,ar1,ave):
    sort = " order by date asc"
    snum = str(cnt)
    sql = "select * from prices where num = "+snum+sort
    cursor.execute(sql)
    s_aprice = count = s_sprice = 0
    s_date = ""
    var = 0
    for record in cursor:
        count = count + 1
        if(count > 1):
            ar = (((record[8]-s_aprice)/s_aprice)-ave)*ar1+ave
            var = var + (ar*ar) 
            #print ar,var
        s_aprice = record[8]
        s_sprice = record[6]
        s_date = record[2]
    #print math.sqrt(var/count)
    normal = norm.cdf(x = ar,loc=0,scale=math.sqrt(var/count))
    normal = adjust(normal) * 100
    ans_price = (1+ar)*s_sprice
    #print cnt,s_date,round(normal,2),round(ans_price,1)
    #print_arima
    cursor.executemany('INSERT INTO results(num,date,prob,ratio,expe,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s)',[(cnt,s_date,round(normal,2),round(ar*s_sprice,2),round(ans_price,1),'2015-1-1','2015-1-1')])


def arima(cnt):
    snum = str(cnt)
    sql = "select * from arimas where num = "+snum
    cursor.execute(sql)
    a = [0,0,0,0,0,0,"",0]
    for record in cursor:
        for i in range(8):
            if(record[i+2] != None):
                a[i] = record[i+2]
    #print cnt,a[0],a[1],a[2],a[3],a[4],a[5],a[7],a[6]
    if(a[6] == "arima"):
        arima_sprice(cnt,a[0],a[1],a[2],a[3],a[4],a[5],a[7])
    else:
        ar_sprice(cnt,a[0],a[7])
        
def wordcount(wordnum,word_items,moji,twenty,cnt,new_date):
    twentycnt = [0]*wordnum
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
    #print s,cnt,new_date
    cursor.executemany('INSERT INTO words(num,date,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',[(cnt,new_date,twentycnt[0],twentycnt[1],twentycnt[2],twentycnt[3],twentycnt[4],twentycnt[5],twentycnt[6],twentycnt[7],twentycnt[8],twentycnt[9],twentycnt[10],twentycnt[11],twentycnt[12],twentycnt[13],twentycnt[14],twentycnt[15],twentycnt[16],twentycnt[17],twentycnt[18],twentycnt[19],'2015-1-1','2015-1-1')])

def check_w():
    sql = "select * from words"
    cursor.execute(sql)
    for record in cursor:
        print record[0],record[1],record[2],record[3],record[4],record[5],record[6],record[7],record[8],record[9]

def wordtable(cnt,new_date):
    sql = "select * from news where num = "+ str(cnt) + " and date = '"+new_date+"'"
    cursor.execute(sql)
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
        countword = 0
        wordcount(wordnum,word_items,moji,twenty,cnt,new_date)
    
n = sys.argv
wordtable(int(n[1]),n[2])
#check_w()
logi_svm(int(n[1]),n[2])
#check(int(n[1]))
connector.commit()

cursor.close()
connector.close()

#prices_tables
#1:num(int)
#2:date(date)
#6:sprice(float)
#8:aprice(float)

#arimas_tables
#0:id(int)
#1:num(int)
#2:ar1(float)
#3:ar2(float)
#4:ar3(float)
#5:ma1(float)
#6:ma2(float)
#7:ma3(float)
#8:arima_ar(varchar(255))
#9:intercept(float)

#results_table
#1:num(int)
#2:date(date)
#3:prob(float)
#4:ratio(float)
#5:created_at(datetime)
#6:updated_at(datetime)
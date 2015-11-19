#!/usr/bin/python
# coding: UTF-8
import MySQLdb
import sys
connector = MySQLdb.connect(host="localhost",db="anatock_development",user="root",passwd="3115",charset="utf8")
cursor = connector.cursor()

def check(cnt):
    snum = str(cnt)
    string = "results where num = "
    sql = "select * from "+string+snum
    cursor.execute(sql)
    for record in cursor:
        print record[0],record[1],record[2],record[3],record[4],record[5],record[6],record[7],record[8],record[9]

def sprice(cnt,ar1,ar2,ar3,ma1,ma2,ma3):
    sort = " order by date asc"
    snum = str(cnt)
    string = "prices where num = "
    sql = "select * from "+string+snum+sort
    cursor.execute(sql)
    s_id = s_num = s_sprice = ave = count = ago3 = ago2 = ago1 = arima = 0
    s_date = ""
    for record in cursor:
        count = count + 1
        if(count > 1):
            ago3 = ago2
            ago2 = ago1
            ago1 = (record[6] - s_sprice)/s_sprice
            ave = ave + ago1
        s_id = record[0]
        s_num = record[1]
        s_date = record[2]
        s_sprice = record[6]
    #print s_id,s_num,s_date,s_sprice,ago1,ago2,ago3
    if(count == 1):
        ave = 0
    else:
        ave = ave / (count-1)
        #print ave
    arima = (ago1-ave)*(ar1+ma1) + (ago2-ave)*(ar2+ma2) + (ago3-ave)*(ar3+ma3)
    #print arima
    cursor.executemany('INSERT INTO results(num,date,logi,arima,svm,rf,infw,logiarima,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',[(cnt,s_date,0,arima,0,0,0,s_sprice + arima*s_sprice,'2015-1-1','2015-1-1')])

def arima(cnt):
    snum = str(cnt)
    string = "arimas where num = "
    sql = "select * from "+string+snum
    cursor.execute(sql)
    ar1 = ar2 = ar3 = ma1 = ma2 = ma3 = ave = 0
    for record in cursor:
        if(record[2] != None):
            ar1 = record[2]
        if(record[3] != None):
            ar2 = record[3]
        if(record[4] != None):
            ar3 = record[4]
        if(record[5] != None):
            ma1 = record[5]
        if(record[6] != None):
            ma2 = record[6]
        if(record[7] != None):
            ma3 = record[7]
    #print record[0],record[1],ar1,ar2,ar3,ma1,ma2,ma3
    sprice(cnt,ar1,ar2,ar3,ma1,ma2,ma3)

n = sys.argv
arima(int(n[1]))
#check(int(n[1]))
connector.commit()

cursor.close()
connector.close()

#prices_table
#0:id(int)
#1:num(int)
#2:date(date)
#3:start(float)
#4:high(float)
#5:low(float)
#6:sprice(float)
#7:volume(float)
#8:created_at(datetime)
#9:updated_at(datetime)

#results_table
#0:num(int)
#1:date(date)
#2:logi(float)
#3:arima(float)
#4:svm(float)
#5:rf(float)
#6:infw(float)
#7:logiarima(float)
#8:created_at(datetime)
#9:updated_at(datetime)

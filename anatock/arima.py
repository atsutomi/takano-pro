#!/usr/bin/python
# coding: UTF-8
import MySQLdb
import sys
connector = MySQLdb.connect(host="localhost",db="anatock_development",user="root",passwd="3115",charset="utf8")
cursor = connector.cursor()

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
        s_sprice = record[6]
        s_num = record[1]
        s_date = record[2]
        s_aprice = record[8]
    #print s_id,s_num,s_date,s_sprice,ago[0],ago[1],ago[2],zansa[0],zansa[1],zansa[2]
    #print_arima
    cursor.executemany('INSERT INTO results(num,date,prob,ratio,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s)',[(cnt,s_date,arima,s_sprice + arima*s_sprice,'2015-1-1','2015-1-1')])

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

n = sys.argv
arima(int(n[1]))
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
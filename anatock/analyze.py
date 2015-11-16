import MySQLdb
import sys
connector = MySQLdb.connect(host="localhost",db="anatock_development",user="root",passwd="3115",charset="utf8")
cursor = connector.cursor()

def function(cnt):
    sort = " order by date asc"
    snum = str(cnt)
    string = "prices where num = "
    sql = "select * from "+string+snum+sort
    cursor.execute(sql)
    s_id = 0
    s_num = 0
    s_date = ""
    s_sprice = 0
    for record in cursor:
        s_id = record[0]
        s_num = record[1]
        s_date = record[2]
        s_sprice = record[6]  
    print s_id,s_num,s_date,s_sprice
        
#for count in range(9999):
#     function(count)

n = sys.argv
function(int(n[1]))
print cursor.executemany('INSERT INTO prices(id,num,date,start,high,low,sprice,volume,created_at,updated_at) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',[(1000005,9999,'2015-10-7',1.2,1.0,1.0,1.0,1.0,'2015-1-1','2015-1-1')])
function(9999)
#connector.commit()

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


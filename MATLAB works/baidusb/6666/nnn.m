% matlab数据库基本操作速成实例(access)
%matlab数据库基本操作速成实例(access) 
%edit by 213 31-Mar-2013

%数据库的链接与基本信息查询
tutor=database('tutorial','','')
%matlabroot\toolbox\database\dbdemos\tutorial.mdb
ping(tutor)
tables(tutor)
columns(tutor)

curs=exec(tutor,'select * from inventoryTable')

data = fetch(curs,2)
data.data
data2 = fetch(curs,3)
data2.data
data3 = fetch(data)
data4 = fetch(data2)
data.data


rows(data)
cols(data)
columnnames(data)

width(data,1)
width(data,4)

attr(data4,1)
attr(data4)

close(curs)
close(data)
close(data2)
close(data3)
close(data4)
close(tutor)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%表的操作
asp=database( 'guestDB' , '' , '' )

asp.AutoCommit
set(asp,'autoCommit','off')

tables(asp)
curs=exec(asp,'CREATE table mytry')
tables(asp)

curs=exec(asp,'ALTER TABLE mytry ADD c1 date')
curs=exec(asp,'ALTER TABLE mytry ADD c2 Integer')
curs.Message
columns(asp)

curs=exec(asp,'INSERT INTO mytry (c1) VALUES (20)')

curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs2=fetch(curs2)
curs2.data
 

insert(asp,'mytry',{'c1','c2'},randi(3,3,2))

curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs2=fetch(curs2)
curs2.data


%--------------------
curs=exec(asp,'INSERT INTO mytry (c2) VALUES (10)')

curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs3=fetch(curs2)
curs3.data

attr(curs2,1)

curs=exec(asp,'ALTER TABLE mytry ALTER COLUMN c1 Byte')
curs.Message
close(curs)
curs=exec(asp,'ALTER TABLE mytry ALTER COLUMN c1 Byte')
curs.Message
close(curs3)
curs=exec(asp,'ALTER TABLE mytry ALTER COLUMN c1 Byte')
curs.Message
close(curs2)
curs=exec(asp,'ALTER TABLE mytry ALTER COLUMN c1 Byte')
curs.Message

 


curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs2=fetch(curs2)
curs2.data
attr(curs2,1)
%----------------------------

curs=exec(asp,'ALTER TABLE mytry ADD c3 AUTOINCREMENT')
curs.Message
close(curs2)
curs=exec(asp,'ALTER TABLE mytry ADD c3 AUTOINCREMENT')
curs.Message
curs=exec(asp,'ALTER TABLE mytry ADD c4 INTEGER')
curs.Message

curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs2=fetch(curs2)
curs2.data

curs=exec(asp,'UPDATE mytry SET c2 = 100 WHERE c3 = 2')

curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs2=fetch(curs2)
curs2.data

update(asp,'mytry',{'c4','c2'},num2cell(10*ones(2,2)),'WHERE c3 BETWEEN 3 AND 5')

curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs3=fetch(curs2)
curs3.data

a=curs;b=curs2;c=curs3;
curs=exec(asp,'ALTER TABLE mytry DROP COLUMN c4')
curs.Message
close(curs3)
curs=exec(asp,'ALTER TABLE mytry DROP COLUMN c4')
curs.Message


commit(asp)
% curs=exec(asp,'commit')

%--------------------------
tables(asp)

curs2=exec(asp,'SELECT * FROM mytry')
curs2.Message
curs3=fetch(curs2)
curs3.data

a=curs;b=curs2;c=curs3;
curs=exec(asp,'DROP TABLE mytry')
curs.Message
close(curs3)
curs=exec(asp,'DROP TABLE mytry')
curs.Message
% close(curs2)
% curs=exec(asp,'DROP TABLE mytry')
% curs.Message


tables(asp)

rollback(asp)
% curs=exec(asp,'rollback')

set(asp,'autoCommit','on')
asp.AutoCommit

curs=exec(asp,'DROP TABLE mytry')
curs.Message

close(asp)
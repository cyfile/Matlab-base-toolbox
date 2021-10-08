% Matlab 数据库命令集合
tutor=database('tutorial','','') 
  
ping(tutor) 
tables(tutor) 
columns(tutor) 
  
curs=exec(tutor,'select * from inventoryTable') 
data = fetch(curs,10) 
  
rows(data) 
cols(data) 
columnnames(data) 
  
width(data,1) 
  
attr(data4,1) 
attr(data4) 
  
close(data) 
close(curs) 
close(tutor) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
asp.AutoCommit 
set(asp,'autoCommit','off') 
  
commit(asp) 
% curs=exec(asp,'commit') 
  
rollback(asp) 
% curs=exec(asp,'rollback') 
  
set(asp,'autoCommit','on') 
asp.AutoCommit 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%表的操作 
asp=database( 'guestDB' , '' , '' ) 
  
tables(asp) 
curs=exec(asp,'CREATE table mytry (c1 DATETIME)') 
tables(asp) 
  
close(curs3) 
curs=exec(asp,'DROP TABLE mytry') 
curs.Message 
%------------------------------------------ 
  
curs=exec(asp,'ALTER TABLE mytry ADD c1 date') 
curs.Message 
  
curs=exec(asp,'ALTER TABLE mytry ADD c3 AUTOINCREMENT') 
curs.Message 
  
columns(asp) 
attr(curs2,1) 
  
close(curs2) 
curs=exec(asp,'ALTER TABLE mytry ALTER COLUMN c1 Byte') 
curs.Message 
  
attr(curs2,1) 
  
close(curs2) 
curs=exec(asp,'ALTER TABLE mytry DROP COLUMN c4') 
curs.Message 
  
curs2=exec(asp,'SELECT * FROM mytry') 
curs2.Message 
curs2=fetch(curs2) 
curs2.data 
%---------------------------------------------------- 
curs=exec(asp,'INSERT INTO mytry (c1) VALUES (0)') 
  
insert(asp,'mytry',{'c1','c2'},randi(3,3,2)) 
  
curs=exec(asp,'UPDATE mytry SET c2 = 100 WHERE c3 = 2') 
  
update(asp,'mytry',{'c4','c2'},num2cell(10*ones(2,2)),'WHERE c3 BETWEEN 3 AND 5') 
  
  
curs2=exec(asp,'SELECT * FROM mytry') 
curs2.Message 
curs2=fetch(curs2) 
curs2.data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555 
close(curs2) 
close(curs) 
close(asp)
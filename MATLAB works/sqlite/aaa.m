%% candeleteall (no hesitate)
 conn = sqlite("C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default\History")
%%
a = fetch(conn,'SELECT * FROM sqlite_master;');
tablename = fetch(conn,"SELECT name FROM sqlite_master WHERE type='table';");
tablesql = fetch(conn,"SELECT sql FROM sqlite_master WHERE type='table';");
%%
inf = strings(2,3);
k=2;
n = fetch(conn,['SELECT count(*) FROM ',tablename{k}]);
inf(1,:)=[string(tablename{k}),string(n),tablesql{k}];
k=4;
n = fetch(conn,['SELECT count(*) FROM ',tablename{k}]);
inf(2,:)=[string(tablename{k}),string(n),tablesql{k}]
%%
k=10;
[string(k),string(tablename{k})]
results = fetch(conn,['SELECT * FROM ',tablename{k}],40);
%% ---------------------------------------
results = fetch(conn,'SELECT * FROM urls ORDER BY url',40);
sqlquery = "SELECT * FROM urls WHERE url LIKE 'https://www.baidu%'ORDER BY url";
results = fetch(conn,sqlquery,40);
results(:,3)=cellfun(@(x) {native2unicode( unicode2native(x,'GBK') ,'UTF-8' )},results(:,3));
%%
sqlstatement = "DELETE FROM urls WHERE  url LIKE 'f%';";
exec(conn,sqlstatement)
sqlstatement = "DELETE FROM urls WHERE  url LIKE '%.baidu.%';";
exec(conn,sqlstatement)
sqlstatement = "DELETE FROM urls WHERE  url LIKE '%.douyu.%';";
exec(conn,sqlstatement)
sqlstatement = "DELETE FROM urls WHERE  url LIKE '%.bilibili.%';";
exec(conn,sqlstatement)
%% 
%% ---------------------------------------
results = fetch(conn,'SELECT * FROM visits ORDER BY visit_time DESC LIMIT 40 ;');
results = fetch(conn,'SELECT visit_time FROM visits ORDER BY visit_time LIMIT 1 OFFSET 40 ;');
sqlstatement = "DELETE FROM visits WHERE visit_time < "+...
    "(SELECT visit_time FROM visits ORDER BY visit_time LIMIT 1 OFFSET 40 ); ";
exec(conn,sqlstatement)
fetch(conn,'SELECT count(*) FROM visits ;')
%%
results = fetch(conn,'SELECT * FROM visits ORDER BY visit_time LIMIT 40 ;');
b= (now-584755-80)*24*60*60*1e7;
b =b / 10;
fetch(conn,['SELECT count(*) FROM visits WHERE visit_time <',num2str(b,20)])
sqlstatement = ['DELETE FROM visits WHERE visit_time < ',num2str(b,20)];
exec(conn,sqlstatement)
fetch(conn,'SELECT count(*) FROM visits ;')
%%
%% ---------------------------------------
exec(conn,'DELETE FROM visits WHERE url NOT in (SELECT id FROM urls);')
fetch(conn,'SELECT count(*) FROM visits ;')
%%
% 删除表的条目不会使数据库文件变小,删除表才会.
% 似乎可以通过 vacuum 重建表腾出删除条目所占空间近而使数据库文件变小
% 但是执行出错
% exec(conn,"VACUUM")
%%
close(conn)
%% ----------------
%% https://www.sans.org/blog/google-chrome-forensics/
%% ----------------
conn2 = sqlite('testfile','create')
a2 = fetch(conn2,"SELECT * FROM sqlite_master");
% 生成history 中和浏览历史记录相关的两个表
% 表urls   存储访问的URL -----------------
sqlstatement = ['CREATE TABLE urls(id INTEGER PRIMARY KEY AUTOINCREMENT,'...
    'url LONGVARCHAR,'...
    'title LONGVARCHAR,'... 
    'visit_count INTEGER DEFAULT 0 NOT NULL,'... 用户浏览次数
    'typed_count INTEGER DEFAULT 0 NOT NULL,'... 用户手动输入次数
    'last_visit_time INTEGER NOT NULL,'... 最后访问时间
    'hidden INTEGER DEFAULT 0 NOT NULL);'...不知道
    ] ;
exec(conn2,sqlstatement );
% 表visits 存储web浏览数据 -----------------
sqlstatement = ['CREATE TABLE visits(id INTEGER PRIMARY KEY,'...
    'url INTEGER NOT NULL,'... 表urls中的 id,
    'visit_time INTEGER NOT NULL,'...浏览时间
    'from_visit INTEGER,'...
    'transition INTEGER DEFAULT 0 NOT NULL,'... 访问方式(跳转,直链,搜藏夹,手动输入网址等)
    'segment_id INTEGER,'...
    'visit_duration INTEGER DEFAULT 0 NOT NULL,'...
    'incremented_omnibox_typed_score BOOLEAN DEFAULT FALSE NOT NULL);'...
    ];
exec(conn2,sqlstatement );
close(conn2)


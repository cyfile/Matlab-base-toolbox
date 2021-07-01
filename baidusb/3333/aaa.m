% 读取网络图片
urldefault='http://www.ilovematlab.cn/uc/images/noavatar_middle.gif';
defaultimage=imread(urldefault);
%%%%%%%%%
url_ava='http://www.ilovematlab.cn/uc/avatar.php?uid=';
url_suf='&size=middle';
%%%%%%%%%
%url_id='http://www.ilovematlab.cn/home.php?mod=space&do=home&uid=';
%url_id='http://www.ilovematlab.cn/space-uid-549070.html';
url_id='http://www.ilovematlab.cn/?';
%%
n=0;
forump=struct('PIP',cell(1,12), 'PID',cell(1,12));
for k=0:200%549070%167483
    PIP=num2str(k);
    A=imread([url_ava,PIP]);
   
    if ~isequal(A,defaultimage)
       
        str=urlread([url_id,PIP]);
        %regexp(str,'<span>(.*?)的资料</span>','tokens','once')
        %PID=regexp(str,'<h2
        %class="name">(.*?)</h2>','tokens','once');%这个返回的是cell类型
        PID=regexp(str,'(?<=<h2 class="name">).*?(?=</h2>)','match','once');
       
        subplot(3,4,n+1)
        imshow(A)
        title({['IP:',PIP],['ID:',PID]})
       
       
        forump(n+1).PIP=PIP;
        forump(n+1).PID=PID;
        if n==11,break,end
        n=mod(n+1,12);
       
    end
   
end
%%%%%%
%%
% ull='http://www.ilovematlab.cn/home.php?mod=space&uid=771292&do=doing&view=me&from=space';
% str2=urlread(ull);
% ull='http://www.ilovematlab.cn/?549070';
% str2=urlread(ull);
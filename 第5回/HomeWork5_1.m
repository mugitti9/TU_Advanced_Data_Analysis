clear all; rand('state',0); randn('state',0);
load digit.mat

t={};
for i=1:10
    X_remove=X;
    X_remove(:,:,i)=[];
    X_remove=reshape(X_remove, 256, 500*9);
    x=[X(:,:,i) X_remove]; y=[ones(500,1); -ones(500*9,1)];   %数値行列作成
    n=length(y); x2=sum(x.^2,1); hh=2*10^2; l=1;    %初期値の定義
    k=exp(-(repmat(x2,n,1)+repmat(x2',1,n)-2*x'*x)/hh); %カーネル作成
    t=[t, (k^2+l*eye(n))\(k*y)]; %最小二乗回帰
end

v={};
for i=1:10
    u=T(:,:,i);
    v_kari=[];
    
    for j=1:10
        X_remove=X;
        X_remove(:,:,j)=[];
        X_remove=reshape(X_remove, 256, 500*9);
        x=[X(:,:,j) X_remove]; y=[ones(500,1); -ones(500*9,1)];   %数値行列作成
        n=length(y); x2=sum(x.^2,1);hh=2*10^2; l=1;        
        v_kari=[v_kari, exp(-(repmat(x2,200,1)+repmat(sum(u.^2,1)',1,n)-2*u'*x)/hh)*cell2mat(t(j))];
    end
    v=[v, v_kari];
end

result=[];
for i=1:10
    v_use=cell2mat(v(i));
    [M,I]=max(v_use, [], 2);
    result=[result, I];
end

graph=[];
for i=1:10
    result_num=result(:,i);
    graph_kari=[];
    for j=1:10
        graph_kari=[graph_kari, numel(find(result_num == j))];
    end
    graph=[graph; graph_kari];
end

graph



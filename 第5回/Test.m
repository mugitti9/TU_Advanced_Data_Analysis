clear all; rand('state',0); randn('state',0);
load digit.mat
x=[X(:,:,1) X(:,:,2)]; y=[ones(500,1); -ones(500,1)];
x2=[X(:,:,1)];
X(:,:,1)=[];

n=length(y); x2=sum(x.^2,1); hh=2*10^2; l=1;
k=exp(-(repmat(x2,n,1)+repmat(x2',1,n)-2*x'*x)/hh);
t=(k^2+l*eye(n))\(k*y);
u=T(:,:,1); % Test patterns 1
v=exp(-(repmat(x2,200,1)+repmat(sum(u.^2,1)',1,n)-2*u'*x)/hh)*t;
C(1,1)=sum(sign(v)>=0); C(1,2)=sum(sign(v)<0);
u=T(:,:,2); % Test patterns 2
v=exp(-(repmat(x2,200,1)+repmat(sum(u.^2,1)',1,n)-2*u'*x)/hh)*t;
C(2,1)=sum(sign(v)>=0); C(2,2)=sum(sign(v)<0);
C
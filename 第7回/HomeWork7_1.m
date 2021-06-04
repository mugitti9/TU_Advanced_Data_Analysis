%初期値定義
clear all; rand('state',0); randn('state',0);
n=90; c=3; y=ones(n/c,1)*[1:c]; y=y(:); x=randn(n/c,c)+repmat(linspace(-3,3,c),n/c,1); x=x(:); h=1; hh=2*h*h; l=1;

%モデルの解を計算
theta_group={}; x2=x.^2;
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh);
for i=1:3
    pi= (y ==i);
    theta=(k^2+l*eye(length(x2))) \ (k*pi);
    theta_group=[theta_group, theta];
end

figure(1); clf; hold on; axis([-5 5 -0.3 1.8]);

N=100; X=linspace(-5,5,N)';
K=exp(-(repmat(X.^2,1,n)+repmat(x.^2',N,1)-2*X*x')/hh);

C=[];
for i=1:3
    t=cell2mat(theta_group(i));
    C =[C, K*t];
end

%確率にする
C(C<0)=0;
for i=1:N
    sum_value=sum(C(i,:));
    for j=1:3
        C(i,j)=C(i,j)/sum_value;
    end
end

plot(X,C(:,1),'b-'); 
plot(X,C(:,2),'r--');
plot(X,C(:,3),'g:');

plot(x(y==1),-0.1*ones(n/c,1),'bo');
plot(x(y==2),-0.2*ones(n/c,1),'rx');
plot(x(y==3),-0.1*ones(n/c,1),'gv');
legend('q(y=1|x)','q(y=2|x)','q(y=3|x)')
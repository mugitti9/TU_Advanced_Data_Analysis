clear all; rand('state',0); randn('state',0);
n=100; x=randn(n,2);
x(1:n/2,1)=x(1:n/2,1)-4; x(n/2+1:end,1)=x(n/2+1:end,1)+4; 
%x(1:n/4,1)=x(1:n/4,1)-4; x(n/4+1:n/2,1)=x(n/4+1:n/2,1)+4; 
x=x-repmat(mean(x),[n,1]); y=[ones(n/2,1); 2*ones(n/2,1)];

V_Val=FDA(x,y);

figure(1); clf; hold on; axis([-10 10 -10 10]);
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==2,1),x(y==2,2),'rx');
plot([-10 10],-([-10 10]*V_Val(1))/V_Val(2),'k-');

function V_Val=FDA(x,y)
    myu_1=mean([x(y==1,1) x(y==1,2)])/length(x(y==1));
    myu_2=mean([x(y==2,1) x(y==2,2)])/length(x(y==2));

    x1=[x(y==1,1) x(y==1,2)];
    x2=[x(y==2,1) x(y==2,2)];
    S_w=zeros(2);
    for i=1:length(x1)
       S_w=S_w+(x1(i)-myu_1)' * (x1(i)-myu_1);
    end
    for i=1:length(x2)
       S_w=S_w+(x2(i)-myu_2)' * (x2(i)-myu_2);
    end

    S_b=zeros(2);
    S_b=S_b+length(x(y==1))* myu_1' * myu_1;
    S_b=S_b+length(x(y==2))* myu_2' * myu_2;
    [V,D] = eig(S_b,S_w);
    [M,I] = max(V);
    V_Val=V(:,I(1));
end
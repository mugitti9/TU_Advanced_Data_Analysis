clear all; rand('state',0); randn('state',0);
n=100; x=randn(n,1)/4+1; u=randn(n,1)/2;
x2=x.^2; xx=repmat(x2,1,n)+repmat(x2',n,1)-2*x*x';
u2=u.^2; ux=repmat(u2,1,n)+repmat(x2',n,1)-2*u*x';
k=exp(-xx/0.1); r=exp(-ux/0.1);
w=r*((r'*r/n+0.1*eye(n))\(mean(k)'));
figure(1); clf; hold on; plot(u,w,'rx');
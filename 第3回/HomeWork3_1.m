clear all; rand('state',0); randn('state',0); n=50; N=1000;
x=linspace(-3,3,n)'; X=linspace(-3,3,N)'; pix=pi*x; y=sin(pix)./(pix)+0.1*x+0.2*randn(n,1);
x2=x.^2; X2=X.^2;   hh=2*0.3^2;
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh); 
error=[];   
non_sparse_num=[];
theta_first=rand(n,1);
z_first=rand(n,1);
u_first=rand(n,1);

lamba=linspace(0.01,1,100);
for num=1:100
    theta=theta_first;
    z=z_first;
    u=u_first;
    l=lamba(num);
    for i=1:10000
        test=inv((k*k+eye(n)));
        theta=(k*k+eye(n))\(k*y+z-u);
        for i=1:n
            if theta(i)+u(i)-l>0
                z(i)=theta(i)+u(i)-l;
            elseif (theta(i)+u(i)+l)*(-1)>0
                z(i)=theta(i)+u(i)+l;
            else
                z(i)=0;
            end
        end
        u=u+theta-z;
    end

    K=exp(-(repmat(X2,1,n)+repmat(x2',N,1)-2*X*x')/hh);
    F=K*theta;
    %figure(1); clf; hold on; axis([-2.8 2.8 -1 1.5]); plot(X,F,'g-'); plot(x,y,'bo');

    f_dash=k*theta;
    error=[error, immse(f_dash, y)];
    
    non_sparse= abs(theta) >0.001;
    non_sparse_num=[non_sparse_num, sum(non_sparse)];
end

results=[lamba.', non_sparse_num.', error.'];
%データの作成
rng(5,'twister')
clear all; rand('state',0); randn('state',0);
n=200; x=[randn(1,n/2)-5 randn(1,n/2)+5; randn(1,n)]';
x(:,3)=1;
y=[ones(n/2,1);-ones(n/2,1)]; y(1:3)=-1; y(n/2+1:n/2+3,1)=1;
x(1:3,2)=x(1:3,2)-5; x(n/2+1:n/2+3,2)=x(n/2+1:n/2+3,2)+5;

%データから学習(サポートベクトルマシン)
w=rand(1,3);
C=100;
stepsize=0.01;
for o=1:10000
    x_learn=x(rem(o,200)+1,:);
    y_learn=y(rem(o,200)+1);
  if (1-(y_learn*w'*x_learn))>=0
      %disp("enter");
      w=w-stepsize*(2*w-C*y_learn*x_learn);
  else
      %disp("enter")
      w=w-stepsize*(2*w);
  end
  
end

%データから学習(最小二乗回帰)
w_nizyou=(x'*x)\(x'*y);

%結果のプロット
figure(1); clf; hold on; axis([-10 10 -10 10]);
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==-1,1),x(y==-1,2),'rx');
plot([-10 10],-(w(3)+[-10 10]*w(1))/w(2),'k-');
plot([-10 10],-(w_nizyou(3)+[-10 10]*w_nizyou(1))/w_nizyou(2),'g-')

plot([-10 10],-(w(3)+[-10 10]*w(1))/w(2),'k-');


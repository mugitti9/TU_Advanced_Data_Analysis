clear all; rand('state',0); randn('state',4);
n=100; k=20;
% x=[2*randn(n,1) randn(n,1)];
x=[2*randn(n,1) 2*round(rand(n,1))-1+randn(n,1)/3];

V_Val=LPP_knn(x,k);

figure(1); clf; hold on; axis([-5 6 -4 4]);
plot([-5 6],-([-5 6]*V_Val(1))/V_Val(2),'k-');
plot(x(:,1),x(:,2),'rx');

function V_Val=LPP_knn(x,k)
    S=squareform(pdist(x));
    [Q,I]=sort(S,'ascend');
    I(1,:)=[];
    I_Change=I([1:k],:);

    % 近傍に基づく類似度行列を作成
    W=zeros(length(I));
    for i=1:length(I)
        for j=1:k
           W(i,I_Change(j,i))=1 ;
        end
    end
    for i=1:length(I)
        for j=1:length(I)
            if(W(i,j)==1)
               W(j,i)=1 ;
            end
        end
    end

    D=diag(sum(W));
    L=D-W;
    XLX=x'*L*x;
    XDX=x'*D*x;
    %固有値問題
    [V,D] = eig(XLX,XDX);
    [M,I] = min(V);
    V_Val=V(:,I(1));
end
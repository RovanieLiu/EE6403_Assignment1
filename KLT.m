X=[0 0 0 1 2 1 1 2 4;0 0 0 1 2 2 2 3 4;0 1 1 1 2 4 1 3 4;0 1 2 1 4 4 2 3 4];
res=[0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
XN=[mean(X(1,:)),mean(X(2,:)),mean(X(3,:)),mean(X(4,:))]'
for i=1:9
    T=X(:,i)-XN;
    res=res+T.*(T');
end
res=res/8
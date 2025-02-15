% Phase-1 Input parameters

c=[2 3 4 7];
A=[2 3 -1 4;1 -2 6 -7];
b=[8;-3];

%Phase-2 No of concentrates & No of Variables

m=size(A,1);
n=size(A,2);

%Phase-3 Compute nCm

nv=nchoosek(n,m);
t=nchoosek(1:n,m);

%Phase-4 Construct basic solution test
sol=[];
for i=1:nv
    y=zeros(n,1);
    x=A(:,t(i,:))\b;
    if all(x>=0 & x~=inf & x~=-inf)
        y(t(i,:))=x;
        sol=[sol y]
    end
end

%Phase-5 Objective solution
z=c*sol;
[zmax,zind]=max(z)
BFS=sol(:,zind);

%Phae-6 Print the solution

optval=[BFS',zmax];
array2table(optval,'variablenames',{'x1','x2','x3','x4','z'})



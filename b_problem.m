% Phase-1 Input parameters

A=[2 1 4; 3 1 5];
b=[11; 14];

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



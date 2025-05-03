% Input Data
cost=[11 20 7 8;21 16 10 12;8 12 18 9];
a=[50 40 70];
b=[30 25 35 40];

% Check balanced or unbalanced
if sum(a)==sum(b)
    fprintf('Given Transformation problem is balances\n')
else
    fprintf('Given Transformation problem is unbalanced\n')
    if sum(a)<sum(b)
        cost(end+1,:)=zeros(1,size(A,2))
        a(end+1)=sum(b)-sum(a)
    elseif sum(b)<sum(a)
        cost(:,end+1)=zeros(1,size(a,2))
        b(end+1)=sum(a)-sum(b)
    end
end
ICost=cost;
X=zeros(size(cost));
[m,n]=size(cost);
BFS=m+n-1;

for i=1:size(cost,1)
    for j=1:size(cost,2)
        % Find the cell with min cost
        hh=min(cost(:));
        [rowind,colind]=find(hh==cost);
        
        x11=min(a(rowind),b(colind));
        [val,ind]=max(x11);
        ii=rowind(ind);
        jj=colind(ind);
        y11=min(a(ii),b(jj));
        x(ii,jj)=y11;
        a(ii)=a(ii)-y11;
        b(jj)=b(jj)-y11;
        cost(ii,jj)=inf;
    end
end

% Print initial BFS
fprintf('Initial BFS=\n')
IB=array2table(x);
disp(IB)

% Check for degenerate or degenerate
totalBFS=length(nonzeros(x))
if totalBFS==BFS
    fprintf('Intial BFS is non degenerate\n')
else
    fprintf('Initial BFS is degenerate\n')
end

Icost=cost;
% Comput the Cost
InitialCost = sum(sum(ICost .* x));
fprintf('Initial BFS cost = %d\n', InitialCost);

function mat=packr(temp)


temp1=isnan(temp);
if size(temp,2)>1
temp2=sum( temp1')';
else
    temp2=temp1;
end
mat=temp(temp2==0,:);

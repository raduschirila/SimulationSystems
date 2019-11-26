function result=interpol(t)
global time2 f

 M=ones(11,3);
 M(:,2)=time2;
 M(:,3)=time2.^2;
 N=transpose(M);
beta=inv(N*M)*transpose(M)*transpose(f);
beta=transpose(beta)
result=t^2*beta(3)+t*beta(2)+beta(1);
end

%n=11;
%s=0;
%p=1;
%for I=1:1:n
 %   p(I)=f(I);
  %  for J=1:1:n
   %     if I~=J
    %    p(I)=p(I)*((t-time2(J))/(time2(I)-time2(J)));
     %   end
   % end
   % s=s+p(I);
%end
%result=s;
%end

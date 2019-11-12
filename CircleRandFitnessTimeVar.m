% clear
% clc
% tic
% 
% clear all
% close all

tmax=1000;
iteration=10000;

v=zeros(1,11);
v(1,5)=1;
u = v;
N= size(v,2);

x=sum(v);   % Number of mutant in the Line model

var1 = zeros(iteration,tmax);
var = zeros(1,tmax);
vv=zeros(1,N);

% V2=zeros(1,N);
% VV = zeros(tmax,N);

    
    
for i=1:1:iteration
        i
        
        v = u;
        var1(i,1)=1;
        x=sum(v);
        
        for t=1:1:tmax-1
            [XX,vv]=CircleRandFitness(x,N,v);
            
            var1(i,t+1)= XX;
            
            if(XX==0 || XX==N)
                
                for ii=t+1:1:tmax
                    var1(i,ii)=XX;
                end
                break;
            end
            v=vv;
            %           VV(t,:) = vv;
            x=XX;
        end
        
        
end 
   

% (1-(uu/(1-uu)))/(1-(uu/(1-uu))^N)

var(1,:) = (1/iteration)*sum(var1,1);

est=var(1,tmax)/N

% r=0.9231;
% analytic=(1-1/r)/(1-(1/r)^N)

 hold on

figure(1) 
plot(var,'c','LineWidth',2);
xlabel('Time'); ylabel('Number of tumor Cells-Circle mu=1,N=11')

toc
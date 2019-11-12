% clear
% clc
% tic
% 
% clear all
% close all

tmax=8000;
iteration=1000;

v=zeros(1,21);
v(1,1)=1;
% v= [1 0 0 0];
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
            [XX,vv]=lineRandFitness(x,N,v);
            
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

estimation = var(1,tmax)/N


hold on
figure(1)
plot(var,'y','LineWidth',2);
xlabel('Time'); ylabel('Number of tumor Cells <r>=1.5')

toc




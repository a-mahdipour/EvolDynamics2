function [XX,vv]=CircleFitness(x,N,v)

% The Line model of Moran model in the case of Birth-Death
% We assume that there are N connected cells arranged in a line
% Assume that we have a new mutatnt with fitness/death rate $r/d$ compare
% to 1 of host individuals


h=0.1;  % 2h: the standard deviation
mu=1.5;

ra=1;
rb=2*h*rand+(mu-h);
da=1;
db=1;
r=rb/ra;
d=db/da;

% W = zeros(N,N);

% W(1,2)=1;
% W(N,N-1)=1;
%  for i=2:N-1
%      W(i,i-1) = 1/2;
%      W(i,i+1)=1/2;
%  end

alpha_a= (N-x)/(r*x+(N-x));
% alpha_b(x)= (r*x)/(r*x+(N-x));
% beta_a = (N-x)/(d*x+(N-x));
% beta_b(x) = (d*x)/(d*x+(N-x));


rng;
gamma=rand(1,2);
alpha = gamma(1,1);
beta = gamma(1,2);
n = randi([1 2],1,1);

% v(rr)=1;

% while(t < tt + 1)

%     pp(x) = (r/(r*x+(N-x)))*(1/(d*x+(N-x)));
%     qq(x) = (1/(r*x+(N-x)))*(d/(d*x+(N-x)));
%     rng;
%     if(0>=sum(v) && sum(v)>= N)
%         break;
%     end
idx1 = find(v);
idx2 = find(v ==0 );


% Now the probability of having increase, pp+ in the number of mutants is
% corresponding to choose a 1 for proliferation. Similarly qq is related to
% choosing one zero element of v for birth which may reduce the number of
% mutants.

if(alpha <= alpha_a)
    if( size(idx2,2)==1)
       s = datasample(idx2,1); 
    else
    s = randsample(idx2,1);
    end
elseif(alpha_a < alpha)
    if( size(idx1,1)==1)
       s = datasample(idx1,1); 
    else
    s = randsample(idx1,1);
    end
end


if(1< s && s< N)
    q = mod(s-1,N+1);
    p = mod(s+1,N+1);
elseif(s==1)
    q= N;
    p=mod(s+1,N+1);
elseif(s==N)
    q = mod(s-1,N+1);
    p = 1;
end

if(v(s)==1)
    
    x1 = mod(1+v(p),2);
    x2 = mod(1+v(q),2);
    
    if(x1 < x2)
        if( beta <= 1/(d+1))
            v(q)=v(s);
        end
    elseif(x2 < x1)
        if( beta <= 1/(d+1))
            v(p)=v(s);
        end 
    else
        if(n==1)
            v(q)=v(s);
        else
            v(p)=v(s);
        end
    end
    
elseif(v(s)==0)
    x1 = mod(v(p),2);
    x2 = mod(v(q),2);
    
    if(x1 < x2)
            if( beta <= d/(d+1))
                v(q)=v(s);
            end
        elseif(x2 < x1)
            if( beta <= d/(d+1))
                v(p)=v(s);
            end      
    else
        if(n==1)
            v(q)=v(s);
        else
            v(p)=v(s);
        end
    end
    
end




vv = v ;
XX = sum(v);



end


%     end

%     x = sum(v);
%     xvec(1,nn)=sum(v);
%     tvec(1,nn)=t;


%     t=t+1;
%     nn=nn+1;

%
%     figure(1)
%  for t=1:Tmax
%   spy(X(t,:),'rs',30 )
%   set(get(gca,'Children'),'MarkerFaceColor','g')
%   M(t) = getframe;
%   spy(u,':bs', 40)
%  end
%   numtimes=1;
%   fps=10;
%   movie(M,numtimes,fps)
%
% hold on
%
% figure(1)
% spy(v,'rs',30 )
% set(get(gca,'Children'),'MarkerFaceColor','g')
% spy(u,':bs', 40)
% eval(touchup)

% figure(2)
% h = bar3(v,.8);
% a = gca;
% set(a,'CameraPosition',[mean(xlim) mean(ylim) 4],...
%       'CameraUpVector',[0 -1 5], ...
%       'Box','on', ...
%       'YDir','reverse', ...
%       'ZLim',[1e-6 1])
% eval(touchup)
% xlabel('Time'); ylabel('Number of Stem Cells')
%plot(v,  '--gs','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]));


% end


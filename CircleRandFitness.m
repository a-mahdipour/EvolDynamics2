
#######################################################
###      Random fitness function on circle model    ###
###    University of Waterloo, Waterloo,Canada      ###
###            copyright@AliMahdipour               ###
#######################################################

function [XX,vv]=fit.circle.func(x,N,v)

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
alpha_a= (N-x)/(r*x+(N-x));
rng;
gamma=rand(1,2);
alpha = gamma(1,1);
beta = gamma(1,2);
n = randi([1 2],1,1);

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


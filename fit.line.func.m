
#######################################################
###      Random fitness function in line model      ###
###     University of Waterloo, Waterloo,Canada     ###
###            copyright@AliMahdipour               ###
#######################################################

function [XX,vv]=fit.line.func.m(x,N,v)

% The Line model of Moran model in the case of Birth-Death
% We assume that there are N connected cells arranged in a line
% Assume that we have a new mutatnt with fitness/death rate $r/d$ compare
% to 1 of host individuals

h=0.1;% 2h: the standard deviation
mu=1.5;

ra=1;
rb=2*h*rand+(mu-h);
da=1;
db=1;
r=rb/ra;
d=db/da;
alpha_a = (N-x)/(r*x+(N-x));

idx1 = find(v);
idx2 = find(v ==0 );

% Now the probability of having increase, pp+ in the number of mutants is
% corresponding to choose a 1 for proliferation. Similarly qq is related to
% choosing one zero element of v for birth which may reduce the number of
% mutants.

rng;
alpha=rand;

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

rng;
beta = rand;
n = randi([1 2],1,1);

if( 1 < s && s < N)
    if(v(s)==1)
        x1 = mod(v(s)+v(s+1),2);
        x2 = mod(v(s)+v(s-1),2);
        
        if(x1 < x2)
            if( beta <= 1/(d+1))
                v(s-1)=v(s);
            end
        elseif(x2 < x1)
            if( beta <= 1/(d+1))
                v(s+1)=v(s);
            end
            
            
        else
            v(s+(-1)^n)=v(s);
        end
        
    elseif(v(s)==0)
        x1 = mod(v(s+1),2);
        x2 = mod(v(s-1),2);
        
        if(x1 < x2)
            if( beta <= d/(d+1))
                v(s-1)=v(s);
            end
        elseif(x2 < x1)
            if( beta <= d/(d+1))
                v(s+1)=v(s);
            end
            
            
        else
            v(s+(-1)^n)=v(s);
        end
    end
    
    
    
elseif(s==1)
    v(s+1)= v(s);
        
elseif(s==N)
    v(s-1)= v(s);
end



vv = v;
XX = sum(v);


end


function u = rndcopula(family,varargin)
    
switch lower(family)
    case 't'
        rho = varargin{1};
        nu = varargin{2};
        n = varargin{3};
        u = copularnd(family,rho,nu,n);
    case {'gaussian','clayton','frank','gumbel'}
        param = varargin{1}; 
        n = varargin{2};
        u = copularnd(family,param,n);
    case 'fgm'
        param = varargin{1}; 
        n = varargin{2};
        
        u = rand(n,1);
        t = rand(n,1);
        a = 1 + param*(1 - 2*u);
        b = sqrt(a.^2 - 4*(a-1).*t);
        v = (2*t)./(b+a);
        u = [u,v];
    case 'joe'
        param = varargin{1}; 
        n = varargin{2};
        
        w = zeros(n,1);
        u1 = rand(n,1);
        v2 = rand(n,1);
        K = @(u1,u2) -(1 - u1).^(-1 + param) .* (-1 + (1 - u2).^param).*...
            ((1 - u1).^param + (1 - u2).^param - ...
            (1 - u1).^param .* (1 - u2).^param).^(-1 + 1/param);
        for i = 1:n
            w(i) = fminbnd(@(u2) abs( K(u1(i),u2) - v2(i)), 0,1);
        end
        u = [u1,w];
    case 'amh'
        param = varargin{1}; 
        n = varargin{2};
        
        w = zeros(n,1);
        u1 = rand(n,1);
        v2 = rand(n,1);
        K = @(u,v) (v + param .* (-1 + v) .* v) ./ (-1 + param .* (-1 + u) .* (-1 + v)).^2;
        for i = 1:n
            w(i) = fminbnd(@(u2) abs( K(u1(i),u2) - v2(i)), 0,1);
        end
        u = [u1,w];
    case 'galambos'
        param = varargin{1}; 
        n = varargin{2};
        
        w = zeros(n,1);
        u1 = rand(n,1);
        v2 = rand(n,1);
        K = @(u,v) exp(((-log(u))^-param + (-log(v))^-param)^(-1/param))* ...
            v - exp(((-log(u))^-param + (-log(v))^-param)^(-1/param))* v* ...
            (-log(u))^(-1 - param)* ((-log(u))^-param + (-log(v))^-param)^(-1 - 1/param);
        for i = 1:n
            w(i) = fminbnd(@(u2) abs( K(u1(i),u2) - v2(i)), 0,1);
        end
        u = [u1,w];
    case 'bb1'
        theta = varargin{1}; 
        delta = varargin{2};
        n = varargin{3};
        
        w = zeros(n,1);
        u1 = rand(n,1);
        v2 = rand(n,1);
        K = @(u,v) u.^(-1 - theta).* (-1 + u.^-theta).^(-1 + delta).* ...
            ((-1 + u.^-theta).^delta + (-1 + v.^-theta).^delta).^(-1 + 1/delta).* ...
            (1 + ((-1 + u.^-theta).^delta + ...
            (-1 + v.^-theta).^delta).^(1/delta)).^(-((1 + theta)./theta));
        for i = 1:n
            w(i) = fminbnd(@(u2) abs( K(u1(i),u2) - v2(i)), 0,1);
        end
        u = [u1,w];
    case 'bb6'
        theta = varargin{1}; 
        delta = varargin{2};
        n = varargin{3};
        
        u2 = zeros(n,1);
        u1 = rand(n,1);
        v2 = rand(n,1);
        e = exp(1);
        w = @(u,v) (-log(1 - (1 - u).^theta)).^delta + (-log(1 - (1 - v).^theta)).^delta;
        K = @(u,v) (1/(1 - (1 - u).^theta)).*e^(-w(u,v)^(1/ delta)).* (1 - e^(-w(u,v)^(1/delta))).^(-1 + 1/theta).* ...
            (1 - u).^(-1 + theta).* (-log(1 - (1 - u)^theta))^(-1 + delta).* ...
            ((-log(1 - (1 - u)^theta))^delta + (-log(1 - (1 - v)^theta)).^delta)^(-1 + 1/delta);
        for i = 1:n
            u2(i) = fminbnd(@(u2) abs( K(u1(i),u2) - v2(i)), 0,1);
        end
        u = [u1,u2];
    case 'bb7'
        theta = varargin{1}; 
        delta = varargin{2};
        n = varargin{3};
        
        u2 = zeros(n,1);
        u1 = rand(n,1);
        v2 = rand(n,1);
        K = @(u,v) (1 - (1 - u)^theta)^(-1 - delta)* (1 - u)^(-1 + theta)*...
            (1 - (-1 + (1 - (1 - u)^theta)^-delta + (1 - (1 - v)^theta)^-delta)^...
            (-1/delta))^(-1 + 1/theta)* (-1 + (1 - (1 - u)^theta)^-delta + ...
            (1 - (1 - v)^theta)^-delta)^(-1 - 1/delta);
        for i = 1:n
            u2(i) = fminbnd(@(u2) abs( K(u1(i),u2) - v2(i)), 0,1);
        end
        u = [u1,u2];
    case 'bb8'
        theta = varargin{1}; 
        delta = varargin{2};
        n = varargin{3};
        
        u2 = zeros(n,1);
        u1 = rand(n,1);
        v2 = rand(n,1);
        K = @(u,v) ((1 - delta* u)^(-1 + theta)* (1 - (1 - delta* v)^theta)* ...
            (1 - ((1 - (1 - delta* u)^theta)* (1 - (1 - delta* v)^theta))/...
            (1 - (1 - delta)^theta))^(-1 + 1/theta))/(1 - (1 - delta)^theta);
        for i = 1:n
            u2(i) = fminbnd(@(u2) abs( K(u1(i),u2) - v2(i)), 0,1);
        end
        u = [u1,u2];
end
        








    
    
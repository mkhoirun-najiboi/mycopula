function c = cdfcopula(family,u,param1,param2,U3)
    if nargin<3
        error('Jumlah input tidak sesuai')
    end
    c = [];
    
    numVar = size(u,2);
    if numVar < 2
        error('u harus berisi 2 atau 3 matriks kolom')
    end
    
    if numVar == 2
        switch lower(family)
            case 't'
                c = copulacdf(family,u,param1,param2);
            case 'joe'
                c = cdfJoe2(u,param1);
            case 'joe-90'
                c = u(:,2)-cdfJoe2([1-u(:,1),u(:,2)],-param1);
            case 'joe-180'
                c = u(:,1)+u(:,2)-1+cdfJoe2([1-u(:,1),1-u(:,2)],param1);
            case 'joe-270'
                c = u(:,1)-cdfJoe2([u(:,1),1-u(:,2)],-param1);
            case 'amh'
                c = cdfAMH2(u,param1);
            case 'fgm'
                c = cdfFGM2(u,param1);
            case 'galambos'
                c = cdfGalambos(u,param1);
            case 'galambos-90'
                c = u(:,2)-cdfGalambos([1-u(:,1),u(:,2)],-param1);
            case 'galambos-180'
                c = u(:,1)+u(:,2)-1+cdfGalambos([1-u(:,1),1-u(:,2)],param1);
            case 'galambos-270'
                c = u(:,1)-cdfGalambos([u(:,1),1-u(:,2)],-param1);
            case 'bb1'
                c = cdfBB1(u,param1,param2);
            case 'bb1-90'
                c = u(:,2)-cdfBB1([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb1-180'
                c = u(:,1)+u(:,2)-1+cdfBB1([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb1-270'
                c = u(:,1)-cdfBB1([u(:,1),1-u(:,2)],-param1,-param2);
            case 'bb6'
                c = cdfBB6(u,param1,param2);
            case 'bb6-90'
                c = u(:,2)-cdfBB6([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb6-180'
                c = u(:,1)+u(:,2)-1+cdfBB6([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb6-270'
                c = u(:,1)-cdfBB6([u(:,1),1-u(:,2)],-param1,-param2);
            case 'bb7'
                c = cdfBB7(u,param1,param2);
            case 'bb7-90'
                c = u(:,2)-cdfBB7([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb7-180'
                c = u(:,1)+u(:,2)-1+cdfBB7([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb7-270'
                c = u(:,1)-cdfBB7([u(:,1),1-u(:,2)],-param1,-param2);
            case 'bb8'
                c = cdfBB8(u,param1,param2);
            case 'bb8-90'
                c = u(:,2)-cdfBB8([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb8-180'
                c = u(:,1)+u(:,2)-1+cdfBB8([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb8-270'
                c = u(:,1)-cdfBB8([u(:,1),1-u(:,2)],-param1,-param2);
            case 'clayton-90'
                c = u(:,2)-copulacdf('clayton',[1-u(:,1),u(:,2)],-param1);
            case 'clayton-180'
                c = u(:,1)+u(:,2)-1+copulacdf('clayton',[1-u(:,1),1-u(:,2)],param1);
            case 'clayton-270'
                c = u(:,1)-copulacdf('clayton',[u(:,1),1-u(:,2)],-param1);
            case 'gumbel-90'
                c = u(:,2)-copulacdf('gumbel',[1-u(:,1),u(:,2)],-param1);
            case 'gumbel-180'
                c = u(:,1)+u(:,2)-1+copulacdf('gumbel',[1-u(:,1),1-u(:,2)],param1);
            case 'gumbel-270'
                c = u(:,1)-copulacdf('gumbel',[u(:,1),1-u(:,2)],-param1);
            case 'frank-90'
                c = u(:,2)-copulacdf('frank',[1-u(:,1),u(:,2)],-param1);
            case 'frank-180'
                c = u(:,1)+u(:,2)-1+copulacdf('frank',[1-u(:,1),1-u(:,2)],param1);
            case 'frank-270'
                c = u(:,1)-copulacdf('frank',[u(:,1),1-u(:,2)],-param1);
            otherwise
                c = copulacdf(family,u,param1);
        end
    elseif numVar == 3
        switch lower(family)
            case 'gaussian'
                c = copulacdf(family,u,param1); 
            case 't'
                c = copulacdf(family,u,param1,param2);
            case 'clayton'
                c = cdfClayton(u,param1);
            case 'gumbel'
                c = cdfGumbel(u,param1);
            case 'gumbelasim'
                c = cdfGumbelAsim(u,param1,param2,U3);
            case 'claytonasim'
                c = cdfClaytonAsim(u,param1,param2,U3);
            case 'frank'
                c = cdfFrank(u,param1);
            case 'joe'
                c = cdfJoe3(u,param1);
            case 'amh'
                c = cdfAMH3(u,param1);
        end
        
    end
end
% ----------------------------------------
function c = cdfClayton(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    u3 = u(:,3); 
    c = (u1.^-param + u2.^-param + u3.^-param -2 ).^(-1/param);
end

function c = cdfGumbel(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    u3 = u(:,3); 
    w = (-log(u1)).^param + (-log(u2)).^param + (-log(u3)).^param; 
    c = exp(-w.^(1/param));
end

function c = cdfGumbelAsim(u,theta1,theta2,U3)
    switch U3
        case 1
            u1 = u(:,2);
            u2 = u(:,3);
            u3 = u(:,1);
        case 2
            u1 = u(:,1);
            u2 = u(:,3);
            u3 = u(:,2);
        case 3
            u1 = u(:,1);
            u2 = u(:,2);
            u3 = u(:,3);
    end
    w1 = (-log(u1)).^theta2;
    w2 = (-log(u2)).^theta2;
    w3 = (-log(u3)).^theta1;
    c1 = (w1+w2).^(theta1/theta2) + w3;
    c = exp(-(c1.^(1/theta1)));
end

function c = cdfClaytonAsim(u,theta1,theta2,U3)
    switch U3
        case 1
            u1 = u(:,2);
            u2 = u(:,3);
            u3 = u(:,1);
        case 2
            u1 = u(:,1);
            u2 = u(:,3);
            u3 = u(:,2);
        case 3
            u1 = u(:,1);
            u2 = u(:,2);
            u3 = u(:,3);
    end 
    c1 = (u1.^(-theta2)+u2.^(-theta2)-1).^(theta1/theta2);
    c = (c1+u3.^(-theta1)-1).^(-1/theta1);
end

function c = cdfFrank(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    u3 = u(:,3);
    x = (exp(-param*u1)-1).*(exp(-param*u2)-1).*(exp(-param*u3)-1);
    c = -1/param.*log(1+ x./ (exp(-param)-1).^2);
end

function c = cdfJoe2(u,param)
    u1 = u(:,1);
    u2 = u(:,2);  
    c = 1 - ((1-u1).^param + (1-u2).^param - (1-u1).^param .*(1-u2).^param ).^(1/param);
end

function c = cdfJoe3(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    u3 = u(:,3);
    w = @(u) 1 - (1 - u).^param;
    c = 1 - (1 - w(u1).*w(u2).*w(u3)).^(1/param);
end

function c = cdfAMH2(u,param)
    u1 = u(:,1);
    u2 = u(:,2);  
    c = (u1.*u2) ./ (1-param.*(1-u1).*(1-u2));
end

function c = cdfAMH3(u,param)
    u1 = u(:,1);
    u2 = u(:,2);  
    u3 = u(:,3);  
    c = (u1.*u2.*u3) ./ (1-param.*(1-u1).*(1-u2).*(1-u3));
end

function c = cdfFGM2(u,param)
    u1 = u(:,1);
    u2 = u(:,2);  
    c =  u1.*u2 + param .* u1 .* u2 .* (1 - u1) .* (1 - u2);
end
 
function c = cdfGalambos(U,param)
    u = U(:,1);
    v = U(:,2);  
    c = u .* v .*exp(((-log(u)).^-param + (-log(v)).^-param).^(-1/param));
end
 
function c = cdfBB1(U,theta,delta)
    u = U(:,1);
    v = U(:,2);
    w = (u.^(-theta) - 1) .^ delta + (v.^(-theta) - 1) .^ delta;
    c = (1 + w.^(1/delta)).^(-1/theta);
end
 
function c = cdfBB6(U,theta,delta)
    u = U(:,1);
    v = U(:,2);
    w = (-log(1 - (1 - u).^theta)).^delta + (-log(1 - (1 - v).^theta)).^delta;
    c = 1 - (1 - exp(-w.^(1/delta))).^(1/theta); 
end
 
function c = cdfBB7(U,theta,delta)
    u = U(:,1);
    v = U(:,2); 
    c = 1 - (1 - ((1 - (1 - u).^theta).^(-delta) + (1 - (1 - v).^theta).^(-delta) - 1).^(-1/delta)).^(1/theta);
end

function c = cdfBB8(U,theta,delta)
    u = U(:,1);
    v = U(:,2); 
    c = 1/delta * (1 - (1 - 1 /(1 - (1 - delta)^theta) * ...
        (1 - (1 - delta.* u).^theta).* (1 - (1 - delta.* v).^theta)).^(1/theta));
end







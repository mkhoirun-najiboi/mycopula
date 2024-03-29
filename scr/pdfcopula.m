function c = pdfcopula(family,u,param1,param2)
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
                c = copulapdf(family,u,param1,param2);
            case 'joe'
                c = pdfJoe2(u,param1);
            case 'joe-90'
                c = pdfJoe2([1-u(:,1),u(:,2)],-param1);
            case 'joe-180'
                c = pdfJoe2([1-u(:,1),1-u(:,2)],param1);
            case 'joe-270'
                c = pdfJoe2([u(:,1),1-u(:,2)],-param1);
            case 'amh'
                c = pdfAMH2(u,param1);
            case 'fgm'
                c = pdfFGM2(u,param1);
            case 'galambos'
                c = pdfGalambos(u,param1);
            case 'galambos-90'
                c = pdfGalambos([1-u(:,1),u(:,2)],-param1);
            case 'galambos-180'
                c = pdfGalambos([1-u(:,1),1-u(:,2)],param1);
            case 'galambos-270'
                c = pdfGalambos([u(:,1),1-u(:,2)],-param1);
            case 'bb1'
                c = pdfBB1(u,param1,param2);
            case 'bb1-90'
                c = pdfBB1([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb1-180'
                c = pdfBB1([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb1-270'
                c = pdfBB1([u(:,1),1-u(:,2)],-param1,-param2);
            case 'bb6'
                c = pdfBB6(u,param1,param2);
            case 'bb6-90'
                c = pdfBB6([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb6-180'
                c = pdfBB6([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb6-270'
                c = pdfBB6([u(:,1),1-u(:,2)],-param1,-param2);
            case 'bb7'
                c = pdfBB7(u,param1,param2);
            case 'bb7-90'
                c = pdfBB7([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb7-180'
                c = pdfBB7([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb7-270'
                c = pdfBB7([u(:,1),1-u(:,2)],-param1,-param2);
            case 'bb8'
                c = pdfBB8(u,param1,param2);
            case 'bb8-90'
                c = pdfBB8([1-u(:,1),u(:,2)],-param1,-param2);
            case 'bb8-180'
                c = pdfBB8([1-u(:,1),1-u(:,2)],param1,param2);
            case 'bb8-270'
                c = pdfBB8([u(:,1),1-u(:,2)],-param1,-param2);
            case 'clayton-90'
                c = copulapdf('clayton',[1-u(:,1),u(:,2)],-param1);
            case 'clayton-180'
                c = copulapdf('clayton',[1-u(:,1),1-u(:,2)],param1);
            case 'clayton-270'
                c = copulapdf('clayton',[u(:,1),1-u(:,2)],-param1);
            case 'gumbel-90'
                c = copulapdf('gumbel',[1-u(:,1),u(:,2)],-param1);
            case 'gumbel-180'
                c = copulapdf('gumbel',[1-u(:,1),1-u(:,2)],param1);
            case 'gumbel-270'
                c = copulapdf('gumbel',[u(:,1),1-u(:,2)],-param1);
            otherwise
                c = copulapdf(family,u,param1);
        end
        
    elseif numVar == 3
        switch lower(family)
            case 'gaussian'
                c = copulapdf(family,u,param1); 
            case 't'
                c = copulapdf(family,u,param1,param2);
            case 'clayton'
                c = pdfClayton(u,param1);
            case 'gumbel'
                c = pdfGumbel(u,param1);
            case 'frank'
                c = pdfFrank(u,param1);
            case 'joe'
                c = pdfJoe3(u,param1);
            case 'amh'
                c = pdfAMH3(u,param1);
        end
        
    end
end
% ----------------------------------------
function c = pdfClayton(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    u3 = u(:,3); 
    x = param^2*(1/param + 1)*(1/param + 2);
    y = (u1.*u2.*u3).^(param+1) .* (u1.^-param + u2.^-param + u3.^-param -2 ).^(1/param + 3);
    c = x./y;
end

function c = pdfGumbel(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    u3 = u(:,3); 
    w = (-log(u1)).^param + (-log(u2)).^param + (-log(u3)).^param;
    x = (-log(u1).*log(u2).*log(u3)).^(param-1) .* exp(-w.^(1/param)) .* ...
        (w.^(3/param-3) + (3*param - 3).* w.^(2/param - 3) + (param - 1).*(2*param-1).*w.^(1/param-3));
    y = u1.*u2.*u3;
    c = x./y;
end

function c = pdfFrank(U,param)
    u = U(:,1);
    v = U(:,2);
    w = U(:,3);
    e = exp(1);
    x = (e.^((2 + u + v + w).*param).*(-1 + e^param)^2.*(-e.^(2*param) + ...
        e.^((2 + u).*param) + e.^((2 + v).*param ) - ...
        e.^((2 + u + v) .* param) + e.^((2 + w).*param) - ...
        e.^((2 + u + w) .*param) - e.^((2 + v + w) .*param) + ...
        e.^((u + v + w) .*param) - 2.*e.^((1 + u + v + w).*param) + ...
        2.* e.^((2 + u + v + w).*param)) .* param^2);
    y = (e.^(2 .*param) - e.^((2 + u) .*param) - e.^((2 + v) .*param) + ...
        e.^((2 + u + v) .*param) - e.^((2 + w) .*param) + ...
        e.^((2 + u + w) .*param) + e.^((2 + v + w).*param) + ...
        e.^((u + v + w) .*param) - 2*e.^((1 + u + v + w) .*param)).^3;
    c = x./y;
end

function c = pdfJoe3(U,param)
    u = U(:,1);
    v = U(:,2);
    w = U(:,3);
    c = param^2.*(1 - u).^(-1 + param).* (1 - v).^(-1 + param).* ...
        (1 - (1 - (1 - u).^param).* (1 - (1 - v).^param).* ...
        (1 - (1 - w).^param)).^(-1 + 1/param).* (1 - w).^(-1 + param) - ...
        3 *(-1 + 1/param).* param^2.* (1 - (1 - u).^param).* ...
        (1 - u).^(-1 + param).* (1 - (1 - v).^param).* ...
        (1 - v).^(-1 + param).* (1 - (1 - (1 - u).^param).* ...
        (1 - (1 - v).^param).* (1 - (1 - w).^param)).^(-2 + 1/param).* ...
        (1 - (1 - w).^param).* (1 - w).^(-1 + param) + ...
        (-2 + 1/param).* (-1 + 1/param).* param^2.* ...
        (1 - (1 - u).^param).^2.* (1 - u).^(-1 + param).* ...
        (1 - (1 - v).^param).^2.* (1 - v).^(-1 + param).* ...
        (1 - (1 - (1 - u).^param).* (1 - (1 - v).^param).* ...
        (1 - (1 - w).^param)).^(-3 + 1/param).* ...
        (1 - (1 - w).^param).^2.* (1 - w).^(-1 + param);
end

function c = pdfJoe2(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    w = (1-u1).^param - ((1-u1).*(1-u2)).^param + (1-u2).^param;
    c = ((1-u1).*(1-u2)).^(-1+param) .* (param - 1 + w) .* w.^(1/param -2);
end

function c = pdfAMH2(u,param)
    u1 = u(:,1);
    u2 = u(:,2);
    x = -1 + param^2 * (-1 + u1 + u2 - u1.*u2) - param * (-2 + u1 + u2 + u1.*u2);
    y = ( -1 + param .* (-1+u1) .* (-1+u2)).^3;
    c = x./y;
end

function c = pdfFGM2(u,param)
    u1 = u(:,1);
    u2 = u(:,2); 
    c = 1 + param .* (1 - 2 .* u1) .* (1 - 2 .* u2);
end

function c = pdfAMH3(U,param)
    u = U(:,1);
    v = U(:,2); 
    w = U(:,3); 
    c = (1 - param^3.* (-1 + u).^2.* (-1 + v).^2.* (-1 + w).^2 + ...
        param^2.* (-1 + u).* (-1 + v).* (-1 + w).* ...
        (-3 + v + w + v.* w + u.* (1 + v).* (1 + w)) + ...
        param.* (-3 + 2 *v + 2 *w + u.* (2 - 4* v.* w)))./ ...
        (1 + param.* (-1 + u).* (-1 + v).* (-1 + w)).^4;
end

function c = pdfGalambos(U,param)
    u = U(:,1);
    v = U(:,2); 
    x = (exp(((-log(u)).^-param + (-log(v)).^-param).^(-1/param)).* ((-log(u)).^-param + ...
        (-log(v)).^-param).^(-2/param).* (log(u).* ((-log(u)).^-param + ...
        (-log(v)).^-param).^(1/param).* ((-log(u)).^param + (-log(v)).^param).* ...
        ((-log(u)).^param + ((-log(u)).^-param + (-log(v)).^-param).^(1/param).* ...
        ((-log(u)).^param + (-log(v)).^param).* log(v)) + (-log(v)).^param.* ...
        ((-log(u)).^param.* (1 + ((-log(u)).^-param + (-log(v)).^-param).^(1/param) + ...
        param.* ((-log(u)).^-param + (-log(v)).^-param).^(1/param)) + ...
        ((-log(u)).^-param + (-log(v)).^-param).^(1/param).* ((-log(u)).^param + (-log(v)).^param).* log(v))));
    y = (log(u).* ((-log(u)).^param + (-log(v)).^param).^2.* log(v));
    c = x ./ y;
end

function c = pdfBB1(U,theta,delta)
    u = U(:,1);
    v = U(:,2); 
    x = ((-1 + u.^-theta).^delta .*(-1 + v.^-theta).^ delta .*((-1 + u.^-theta).^delta +...
        (-1 + v.^-theta).^delta).^(-2 + 1/delta) .* (1 + ((-1 + u.^-theta).^delta + ...
        (-1 + v.^-theta).^delta).^(1/delta)).^(-2 - 1/theta) .* (((-1 + u.^-theta).^delta + ...
        (-1 + v.^-theta).^delta).^(1/delta) + theta .* (-1 + delta + delta .* ((-1 + u.^-theta).^delta + ...
        (-1 + v.^-theta).^delta).^(1/delta))));
    y = (u .* (-1 + u.^theta) .* v .* (-1 + v.^theta));
    c = x./y;
end

function c = pdfBB6(U,theta,delta)
    u = U(:,1);
    v = U(:,2); 
    e = exp(1);
    w = (-log(1 - (1 - u).^theta)).^delta + (-log(1 - (1 - v).^theta)).^delta;
    x = ((1 - e.^(-w.^(1/delta))).^(1/theta) .* ...
        (1 - u).^(-1 + theta) .* (1 - v).^(-1 + theta).* (-log(1 - (1 - u).^theta)).^(-1 + delta) .* ...
        (theta + delta .* (-1 + e.^(w.^(1/delta))) .* theta + ...
        e.^(w.^(1/delta)) .* theta .* (-1 + ((-log(1 - (1 - u).^theta)).^delta + ...
        (-log(1 - (1 - v).^theta)).^delta).^(1/delta)) - ...
        ((-log(1 - (1 - u).^theta)).^delta + ...
        (-log(1 - (1 - v).^theta)).^delta).^(1/delta)) .* ...
        ((-log(1 - (1 - u).^theta)).^delta + ...
        (-log(1 - (1 - v).^theta)).^delta).^(-2 + 1/delta) .* ...
        (-log(1 - (1 - v).^theta)).^(-1 + delta));
    y = ((-1 + e.^(w.^(1/delta))).^2 .* ...
        (-1 + (1 - u).^theta) .* (-1 + (1 - v).^theta));
    c = x./y;
end

function c = pdfBB7(U,theta,delta)
    u = U(:,1);
    v = U(:,2); 
    x = ((1 - (1 - u).^theta).^(-1 + delta).* (1 - u).^(-1 + theta).*...
        (1 - (-1 + (1 - (1 - u).^theta).^-delta + ...
        (1 - (1 - v).^theta).^-delta).^(-1/delta)).^(1/theta).* ...
        (-1 + delta.* theta.* (-1 + (-1 + (1 - (1 - u).^theta).^-delta +...
        (1 - (1 - v).^theta).^-delta).^(1/delta)) + ...
        theta.* (-1 + (1 - (1 - u).^theta).^-delta +...
        (1 - (1 - v).^theta).^-delta).^(1/delta)).* ...
        (1 - (1 - v).^theta).^(-1 + delta).* (1 - v).^(-1 + theta));
    y = ((-1 + (-1 + (1 - (1 - u).^theta).^-delta + ...
        (1 - (1 - v).^theta).^-delta).^(1/delta)).^2.* ...
        ((1 - (1 - u).^theta).^delta + ...
        (1 - (1 - v).^theta).^delta - ...
        (1 - (1 - u).^theta).^delta.* ...
        (1 - (1 - v).^theta).^delta).^2);
    c = x./y;
end

function c = pdfBB8(U,theta,delta)
    u = U(:,1);
    v = U(:,2); 
    x = (delta.* (1 - delta.* u).^(-1 + theta).* (1 - delta.* v).^(-1 + theta).* ...
        ((-1 + (1 - delta).^theta).* theta + (-1 + (1 - delta.* u).^theta).* ...
        (-1 + (1 - delta.* v).^theta)).* (1 + ((-1 + (1 - delta.* u).^theta).* ...
        (-1 + (1 - delta.* v).^theta))./(-1 + (1 - delta).^theta)).^(1/theta));
    y = (-(1 - delta).^theta + (1 - delta.* u).^theta + ...
        (1 - delta.* v).^theta - (1 - delta.* u).^theta.*...
        (1 - delta.* v).^theta).^2;
    c = -(x./y);
end














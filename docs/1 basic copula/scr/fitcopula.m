function [param1,varargout] = fitcopula(family, u)
    numVar = size(u,2);
     
    if numVar == 2
        switch lower(family)
            case 't'
                [param1,param2] = copulafit(family,u);
                varargout(1) = {param2};
            case {'joe','amh','fgm','galambos'}
                param1 = fitArchi(family,u);
            case {'bb1','bb6','bb7','bb8'}
                [param1,param2] = fitArchi2(family,u);
                varargout(1) = {param2};
            otherwise
                param1 = copulafit(family,u);
        end
    elseif numVar == 3
        switch lower(family)
            case 'gaussian'
                param1 = copulafit(family,u); 
            case 't'
                [param1,param2] = copulafit(family,u);
                varargout(1) = {param2};
            case {'gumbelasim','claytonasim'}
                [param1,param2,U3] = fitArchi3asim(family,u);
                varargout(1) = {param2};
                varargout(2) = {U3};
            otherwise
                param1 = fitArchi(family,u);
        end
        
    end
end

% ---------------------------------
function param = fitArchi(family,u)
    L = @(param) -log(prod(pdfcopula(family,u,param)));
    lb = []; ub = [];
    switch lower(family)
        case 'joe'
            lb = [1];ub = [];
        case 'galambos'
            lb = [0];ub = [];
        case 'amh'
            lb = [-1];ub = [1];
        case 'fgm'
            lb = [-1];ub = [1];
        case 'gumbel'
            lb = [1];ub = [];
        case 'clayton'
            lb = [eps];ub = [];
        case 'frank'
            lb = [eps];ub = [];
    end
    [param,~,flag] = fminsearchbnd(L,[1],lb,ub); 
    if ~flag;param = lb;end
end

function [param1,param2] = fitArchi2(family,u)
    L = @(param) -log(prod(pdfcopula(family,u,param(1),param(2))));
    lb = []; ub = [];
    switch lower(family)
        case 'bb1'
            lb = [eps,1]; 
        case 'bb6'
            lb = [1,1]; 
        case 'bb7'
            lb = [1,eps];  
        case 'bb8'
            lb = [1,eps]; ub = [inf,1]; 
    end
    param = fminsearchbnd(L,[1,1],lb,ub);
    param1 = param(1);
    param2 = param(2);
end 
    
function [param1,param2,U3] = fitArchi3asim(family,u)
    for i = 1:3
        L = @(param) -log(prod(pdfcopula(family,u,param(1),param(2),i)));
        lb = []; ub = [];
        switch lower(family)  
            case 'gumbelasim'
                lb = [1,1];   
            case 'claytonasim'
                lb = [eps,eps];  
        end
        param{i} = fminsearchcon(L,[1,1],lb,ub,[1,-1],0);
        NLogL(i) = L(param{i});
    end
    [~,U3] = min(NLogL);
    param = param{U3};
    param1 = param(1);
    param2 = param(2);
end 
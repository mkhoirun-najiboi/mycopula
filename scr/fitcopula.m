function [param1,varargout] = fitcopula(family, u)
    numVar = size(u,2); 
    if numVar == 2
        switch lower(family)
            case 't'
                [param1,param2] = copulafit(family,u);
                varargout(1) = {param2};
            case {'joe','joe-90','joe-180','joe-270',...
                    'amh','fgm',...
                    'galambos','galambos-90','galambos-180','galambos-270'}
                param1 = fitArchi(family,u);
            case {'bb1','bb1-90','bb1-180','bb1-270',...
                    'bb6','bb6-90','bb6-180','bb6-270',...
                    'bb7','bb7-90','bb7-180','bb7-270',...
                    'bb8','bb8-90','bb8-180','bb8-270'}
                [param1,param2] = fitArchi2(family,u);
                varargout(1) = {param2};
            case 'clayton-90'
                param1 = copulafit('clayton',[1-u(:,2),u(:,1)]);
                param1 = -param1;
            case 'clayton-180'
                param1 = copulafit('clayton',[1-u(:,1),1-u(:,2)]);
            case 'clayton-270'
                param1 = copulafit('clayton',[u(:,2),1-u(:,1)]);
                param1 = -param1;
            case 'gumbel-90'
                param1 = copulafit('gumbel',[1-u(:,2),u(:,1)]);
                param1 = -param1;
            case 'gumbel-180'
                param1 = copulafit('gumbel',[1-u(:,1),1-u(:,2)]);
            case 'gumbel-270'
                param1 = copulafit('gumbel',[u(:,2),1-u(:,1)]);
                param1 = -param1;
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
            otherwise
                param1 = fitArchi(family,u);
        end
        
    end 
end

% ---------------------------------
function param = fitArchi(family,u)
    L = @(param) -log(prod(pdfcopula(family,u,param)));
    halfrot = lower(family);
    if strcmp(halfrot(end-1:end),'90') || strcmp(halfrot(end-1:end),'70')
        L = @(param) -log(prod(pdfcopula(family,u,-param)));
    end
    lb = []; ub = [];
    switch lower(family)
        case {'joe','joe-90','joe-180','joe-270'}
            lb = [1];ub = [];
        case {'galambos','galambos-90','galambos-180','galambos-270'}
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
    opt = optimset('Display','off');
    [param,~,flag] = fminsearchbnd(L,[1],lb,ub,opt); 
    if ~flag;param = lb;end
    halfrot = lower(family);
    if strcmp(halfrot(end-1:end),'90') || strcmp(halfrot(end-1:end),'70')
        param = -param;
    end
end

function [param1,param2] = fitArchi2(family,u)
    L = @(param) -log(prod(pdfcopula(family,u,param(1),param(2))));
    halfrot = lower(family);
    if strcmp(halfrot(end-1:end),'90') || strcmp(halfrot(end-1:end),'70')
        L = @(param) -log(prod(pdfcopula(family,u,-param(1),-param(2))));
    end
    lb = []; ub = [];
    switch lower(family)
        case {'bb1','bb1-90','bb1-180','bb1-270'}
            lb = [eps,1]; 
        case {'bb6','bb6-90','bb6-180','bb6-270'}
            lb = [1,1]; 
        case {'bb7','bb7-90','bb7-180','bb7-270'}
            lb = [1,eps];  
        case {'bb8','bb8-90','bb8-180','bb8-270'}
            lb = [1,eps]; ub = [inf,1]; 
    end
    opt = optimset('Display','off');
    param = fminsearchbnd(L,[1,1],lb,ub,opt);
    param1 = param(1);
    param2 = param(2);
    halfrot = lower(family);
    if strcmp(halfrot(end-1:end),'90') || strcmp(halfrot(end-1:end),'70')
        param1 = -param(1);
        param2 = -param(2);
    end
end
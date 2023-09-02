function cc = evalcopula(C,u,cp)

switch lower(cp)
    case {'pdf'}
        if isempty(C.param2)
            c = @(u) pdfcopula(C.copulaName,u,C.param1);
        else
            c = @(u) pdfcopula(C.copulaName,u,C.param1,C.param2);
        end 
    case {'cdf'} 
        if isempty(C.param2)
            c = @(u) cdfcopula(C.copulaName,u,C.param1);
        else
            c = @(u) cdfcopula(C.copulaName,u,C.param1,C.param2);
        end 
end

cc = c(u);

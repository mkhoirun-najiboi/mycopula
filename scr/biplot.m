function biplot(x,varargin)

okargs = {'showdata','showtext','verbosity'};
defaults = {0           1        1};
[showdata,showtext,verbosity] = internal.stats.parseArgs(okargs,defaults,varargin{:});

C = bivariatefit(x,'verbosity',verbosity);
if min(x(:,1))<0
    x1 = linspace(min(x(:,1))-std(x(:,1))/2, max(x(:,1))+std(x(:,1))/2, 100);
else
    x1 = linspace(max(0,min(x(:,1))-std(x(:,1))/2), max(x(:,1))+std(x(:,1))/2, 100);
end
if min(x(:,2))<0
    x2 = linspace(min(x(:,2))-std(x(:,2))/2, max(x(:,2))+std(x(:,2))/2, 100);
else
    x2 = linspace(max(0,min(x(:,2))-std(x(:,2))/2), max(x(:,2))+std(x(:,2))/2, 100);
end
[a,b] = meshgrid(x1,x2);
xp = [a(:),b(:)];
f = jointpdf(C,xp);
fx = reshape(f,length(x1),length(x2));

hold on;box on
contour(x1,x2,fx,'linewidth',1.5,'showtext',showtext,'color','k')
% colorbar 
scatter(x(:,1),x(:,2),'k*','markeredgealpha',showdata) 
xlabel('X1')
ylabel('X2')
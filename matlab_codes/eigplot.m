function eigplot(lamt,lam,res,title,xlbl,ylbl,lgnd)

%% defaults
if nargin < 3, res = []; end
if nargin < 4, title = []; end
if nargin < 5, xlbl = 'real(lam)'; end
if nargin < 6, ylbl = 'imag(lam)'; end
if nargin < 7, lgnd = []; end

%% colors
colors = get(gca,'ColorOrder');
index  = get(gca,'ColorOrderIndex');

%% figure
plot(real(lamt),imag(lamt),'xk'); hold on
if isempty(res)
    plot(real(lam),imag(lam),'o','Markersize',10);
else
    idx = 1e-2 < res;
    plot(real(lam(idx)),imag(lam(idx)),'o','Markersize',12,'Color',colors(2,:));
    idx = (1e-8 < res) & (res <= 1e-2);
    plot(real(lam(idx)),imag(lam(idx)),'o','Markersize',12,'LineWidth',3,'Color',colors(3,:));
    idx = res <= 1e-8;
    plot(real(lam(idx)),imag(lam(idx)),'o','Markersize',12,'LineWidth',3,'Color',colors(5,:));
end
xlabel(xlbl); ylabel(ylbl);

end

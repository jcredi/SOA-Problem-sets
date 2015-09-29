function [fig1, fig2] = FancyPlots( outputTable, f, g )

figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','w');
parulaColours = get(groot,'DefaultAxesColorOrder');

subplot(1,2,1); % function f vs mu
fig1 = semilogx(outputTable(:,1), f(outputTable(:,2),outputTable(:,3)),':.');
xlabel('\mu'); ylabel('f(x_1,x_2)');
set(fig1,'MarkerSize',28,'LineWidth',2);
set(gca,'FontSize',26);
title('Function f(x_1, x_2)');
axis square

subplot(1,2,2); % constraint g vs mu
fig2 = semilogx(outputTable(:,1), g(outputTable(:,2),outputTable(:,3)),':s');
xlabel('\mu'); ylabel('g(x_1,x_2)');
set(fig2,'MarkerSize',11,'LineWidth',2,'Color',parulaColours(2,:));
set(gca,'FontSize',26);
title('Constraint g(x_1, x_2)');
axis square

end


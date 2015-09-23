function [fig1, fig2, fig3] = FancyPlot( outputData, f, g )
%FANCYPLOT

figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','w');
parulaColours = get(groot,'DefaultAxesColorOrder');

subplot(1,2,1);
fig1 = semilogx(outputData(:,1), f(outputData(:,2),outputData(:,3)),':.');
xlabel('\mu'); ylabel('f(x_1,x_2)');
set(fig1,'MarkerSize',28,'LineWidth',2);
set(gca,'FontSize',26);
title('Function f(x_1, x_2)');
axis square

subplot(1,2,2);
fig2 = semilogx(outputData(:,1), g(outputData(:,2),outputData(:,3)),':s');
xlabel('\mu'); ylabel('g(x_1,x_2)');
set(fig2,'MarkerSize',11,'LineWidth',2,'Color',parulaColours(2,:));
set(gca,'FontSize',26);
title('Constraint g(x_1, x_2)');
axis square

figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','w');

X = outputData(1:end-1,2);
Y = outputData(1:end-1,3);
for ii = 1:size(outputData,1)-1
  U(ii) = outputData(ii+1,2) - outputData(ii,2);
  V(ii) = outputData(ii+1,3) - outputData(ii,3);
end
U = U'; V = V';
fig3 = quiver(X,Y,U,V,1.15);
xlabel('x_1'); ylabel('x_2');
set(fig3,'LineWidth',1.5);
set(gca,'FontSize',24);
axis square

end


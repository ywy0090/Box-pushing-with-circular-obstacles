function plotBox(boxPosition, obstacles)
xmin = 0;
xmax = 20;
ymin = 0;
ymax = 20;
boxLength = 2;
boxWidth = 2;

%%
figure(1);
axis([0 xmax+1 0 ymax+1]);
hold on;
plot_box =boxPosition;
rectangle('Position',[plot_box(1) plot_box(2) boxLength boxWidth]);
%%
numObstacles =size(obstacles, 1);
for i=1:numObstacles
    viscircles([obstacles(i,1),obstacles(i,2)], obstacles(i,3));
end
 axis square;
%  pause;    % press the space bar
%   for i=1:20
%       rotateRect = (rotateRect-origin)*transMat+origin;
%       xr = rotateRect(:,1);
%       yr = rotateRect(:,2);
%       h1 = plot(xr,yr);
%       pause;
%   end
hold off;  
% % rotate square
% t = hgtransform('Parent',gca);
% set(h,'Parent',t);
% Txy = makehgtform('zrotate',rotateAngle);     % define a transform matrix
% set(t,'Matrix',Txy)
% pause;  
%  h1 = plot(xr,yr);
%  xlim([-1, 1]);
%  ylim([-1, 1]);
%  axis square;
%  pause; 
%  hold off;
end
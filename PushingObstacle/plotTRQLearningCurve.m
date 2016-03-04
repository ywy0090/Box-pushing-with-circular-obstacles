function plotTRQLearningCurve()
obstacles =[6,10,0.5; 5,4,0.4; 7,6,0.5; 8,10,0.6; 14,15,0.3];
[ep_steps] = TRQLearning(2000,obstacles);
 plot(mean(reshape(ep_steps(1:2000), 100, 20)));
xlabel('Training Process');
ylabel('Steps');
title('TRQ Learning Pushing Box Learning Curve(2k)','FontSize',12);
end
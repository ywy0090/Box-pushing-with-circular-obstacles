function ComparisonLearningCurves()
obstacles =[6,10,0.5; 5,4,0.4; 7,6,0.5; 8,10,0.6; 14,15,0.3; ...
           20,10,0.5; 10,2,0.4; 15,4,0.5; 15,6,0.3];
episodes = 2000;
[ep_steps1] = singleQ(episodes, obstacles, 1);

 xlabel('Training Process');
 ylabel('Steps');
 title('SingleQ and Team Pushing Box Learning Curve(1k)','FontSize',12)
 [ep_steps2] = singleQ(episodes, obstacles, 0);
% [totalSteps, ep_steps2] = TRQLearning(episodes, obstacles);
% plot(mean(reshape(ep_steps(1:1000), 1000, 1)));
% plot(ep_steps(1:1000));
 plot(mean(reshape(ep_steps1(1:2000), 100, 20)));
 hold on;
 plot(mean(reshape(ep_steps2(1:2000), 100, 20)),'r');
%  plot(mean(reshape(totalSteps(1:2000), 100, 20)),'g');
legend('Leader-Follower','Peer-to-Peer');
xlabel('Training Process');
ylabel('Steps');
title('SingleQ Learning Curve(episode 2k)','FontSize',12)
end
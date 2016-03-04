function comparisonRunningTime()
obstacles =[6,10,0.5; 5,4,0.4; 7,6,0.5; 8,10,0.6; 14,15,0.3];

runningTime = zeros(2,5);
i=1;
filename='runningTime.mat';
for n = 1000:1000:5000
    tic;
    [ep_steps] = singleQ(n,obstacles);
    runningTime(1,i) = toc;
    i=i+1;
end
i=1;
for n = 1000:1000:5000
    tic;
    [ep_steps] = TRQLearning(n,obstacles);
    runningTime(2,i) = toc;
    i=i+1;
end
save(filename, 'runningTime');
steps = 1000:1000:5000;
bar(steps,runningTime');
end
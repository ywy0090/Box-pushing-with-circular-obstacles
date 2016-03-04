function [epSteps] =singleQ(episodes, obstacles, avoidFlag)
alpha = 0.05;
gamma = 0.99;
%num_states = 20*20+20+1;
num_states = 1024+1;
numActions = 4;
%actions = [1,2,3,4];
q1 = zeros(num_states, numActions);
q2 = zeros(num_states, numActions);
initPos = [2,2];
dest = [16,15];
action1 = 2;
action2 = 1;
threshold = 1000;
filename = 'qTable.mat';
%planning 
model1= buildModel(num_states, numActions);
model2 = buildModel(num_states, numActions);
planSteps = 20;
%plotting information
% plotBox = zeros([5000,2]);
% optimalStep = 1000;
epSteps = zeros(10000,1);
plotBoxInf = zeros(2000,3);
optimalStep = 100;
outsteps = 0;
plotBox(initPos, obstacles);
for i=1:episodes
    [currentA1, currentA2, nextPosition, stateId, absorb, isObs, destDirec]= ...
    singlePush(initPos, action1, action2, dest, obstacles);
    [maxq1, currentA1] = max(q1(stateId,:));
    [maxq2, currentA2] = max(q2(stateId,:));
    %qTable, stateId, numAction, currentAction
    currentA1 = selectAction(q1, stateId, numActions, currentA1);
    currentA2 = selectAction(q2, stateId, numActions, currentA2);
    steps = 0;
    while(~absorb)
        [currentA1, currentA2, nextPosition, stateIdNew, absorb, isObs, destDirec]= ...
        singlePush(nextPosition, currentA1, currentA2, dest, obstacles);
    %plotting storage
        plotBoxInf(steps+1,1:2) = nextPosition;
        %computer reward
        
        reward = calculateReward(nextPosition, dest, isObs, absorb);
    % find the best action for the next state and update q value
    
        [maxq1, an1] = max(q1(stateIdNew,:));
        [maxq2, an2] = max(q2(stateIdNew,:));
        an1 = selectAction(q1, stateIdNew, numActions, an1);
        an2 = selectAction(q2, stateIdNew, numActions, an2);
        if(avoidFlag)
        [an1, an2] = avoidContr2(an1, an2, numActions);
        else
        [an1, an2] = avoidContr(an1, an2, numActions); 
        end
%         [an1, an2] = ...
%     avoidContr3(an1,an2, numActions,nextPosition, obstacles, dest);
         q1(stateId,currentA1) = (1 - alpha)*q1(stateId,currentA1) + ...
        alpha*(reward + gamma*maxq1);
        q2(stateId,currentA2) = (1 - alpha)*q2(stateId,currentA2) + ...
        alpha*(reward + gamma*maxq2);
    % introduce dyna plannning
%         model1 = updateModel(model1, stateId, currentA1, stateIdNew, reward);
%         model2 = updateModel(model2, stateId, currentA2, stateIdNew, reward);
%         q1 = planModel(q1, model1, planSteps, alpha, gamma);
%         q2 = planModel(q2, model2, planSteps, alpha, gamma);
    
        currentA1 = an1;
        currentA2 = an2;
        stateId = stateIdNew;
        steps = steps + 1;
        if(steps>threshold)
            disp('Stop searching');
            break;
        end
    end
     if(absorb)
        disp('Found one solution!');
        disp(steps);
        if(steps < optimalStep)
            clf;
%             size =2;
%             if(steps>500)
%                 size=10;
%             end
%             for i=1:size:steps
%             plotBox(plotBoxInf(i,1:2), obstacles);
%             end
            plotTrajectory(plotBoxInf, obstacles, steps);
        optimalStep = steps;    
        end
     end
     epSteps(i) = steps;
     disp(steps);
    outsteps = outsteps+1;
    disp(outsteps);
end
 save(filename, 'q1', 'q2', 'optimalStep');
end
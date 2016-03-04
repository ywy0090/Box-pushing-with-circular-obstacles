function [epTotalSteps,epSteps] = TRQLearning(episodes, obstacles)
alpha = 0.05;
gamma = 0.99;
num_states = 20*20+20+1;
numBoxStates = 41;
% num_states = 5000;
numActions = 4;
%actions = [1,2,3,4];
debug =0;
q1 = zeros(num_states, numActions);
q2 = zeros(num_states, numActions);
t = zeros(numBoxStates, numBoxStates, numActions, numActions,5);

initPos = [2,2];
dest = [16,15];
action1 = 2;
action2 = 1;
threshold = 1000;
%filename = 'qTable.mat';
%planning 
% model1= buildModel(num_states, numActions);
% model2 = buildModel(num_states, numActions);
% planSteps = 20;
%plotting information
% plotBox = zeros([5000,2]);
% optimalStep = 1000;
epSteps = zeros(10000,1);
epTotalSteps = zeros(10000,1);
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
    totalSteps = 0;
    while(~absorb)
        xEntry = nextPosition(1)*2+1;
        yEntry = nextPosition(2)*2+1;
        if(1 && all(t(xEntry, yEntry, currentA1, currentA2,1:3)~=0) && ...
                t(xEntry, yEntry, currentA1, currentA2,4)~= stateId) 
%&&  t(nextPosition(1)*2+1, nextPosition(2)*2+1,currentA1, currentA2)~=stateId)
             %[stateIdNew] = calcState2(t(xEntry, yEntry, currentA1, currentA2,1:2)); 
             nextPosition = reshape(t(xEntry, yEntry, currentA1, currentA2,1:2),1,2);
            reward =  t(xEntry, yEntry,currentA1, currentA2,3);
             stateIdNew = t(xEntry, yEntry, currentA1, currentA2,4);
             absorb = t(xEntry, yEntry, currentA1, currentA2,5);
        else
            [currentA1, currentA2, nextPosition, stateIdNew, absorb, isObs, destDirec]= ...
            singlePush(nextPosition, currentA1, currentA2, dest, obstacles);
        %plotting storage
%             nextPosition
%             stateId
%             stateIdNew
            plotBoxInf(steps+1,1:2) = nextPosition;
        %computer reward
            reward = calculateReward(nextPosition, dest, isObs, absorb);
        %update r table and t table
           t(xEntry, yEntry, currentA1, currentA2,1:2) = nextPosition;
           t(xEntry, yEntry, currentA1, currentA2,3) = reward;
           t(xEntry, yEntry, currentA1, currentA2,4) = stateIdNew;
           t(xEntry, yEntry, currentA1, currentA2,5) = absorb;
           steps = steps + 1;
         end
        % find the best action for the next state and update q value
        [maxq1, an1] = max(q1(stateIdNew,:));
        [maxq2, an2] = max(q2(stateIdNew,:));
        an1 = selectAction(q1, stateIdNew, numActions, an1);
        an2 = selectAction(q2, stateIdNew, numActions, an2);
        [an1, an2] = avoidContr(an1, an2, numActions);  
        q1(stateId,currentA1) = (1 - alpha)*q1(stateId,currentA1) + ...
        alpha*(reward + gamma*maxq1);
        q2(stateId,currentA2) = (1 - alpha)*q2(stateId,currentA2) + ...
        alpha*(reward + gamma*maxq2);
        currentA1 = an1;
        currentA2 = an2;
        stateId = stateIdNew;
        
        totalSteps = totalSteps + 1;
        if(steps>threshold)
            disp('Stop searching');
            break;
        end
    end
%      if(absorb)
%         disp('Simulation steps:');
%         disp(steps);
%         disp('totoal steps:')
%         disp(totalSteps);
%         if(steps < optimalStep)
%             clf;
%             size =2;
%             for i=1:size:steps
%             plotBox(plotBoxInf(i,1:2), obstacles);
%             end
%         optimalStep = steps;    
%         end
%      end
     epSteps(i) = steps;
     epTotalSteps(i) = totalSteps;
     disp(steps);
    outsteps = outsteps+1;
    disp(outsteps);
end
 %save(filename, 'q1', 'q2', 'optimalStep');
end
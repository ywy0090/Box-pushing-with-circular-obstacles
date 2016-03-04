function [currentA1, currentA2, nextPosition, stateId, absorb, isObs, destDirec]= ...
    singlePush(boxPosition, action1, action2, dest, obstacles)
currentA1 = action1;
currentA2 = action2;
shift = 0.5;
xmax = 20;
ymax = 20;
xmin = 0;
ymin = 0;
boxLength = 2;
boxWidth = 2;
rectR = sqrt(boxLength*boxLength/4+boxWidth*boxWidth/4);
numObs = size(obstacles, 1);
isObs = 0;
boxNewPosition = boxPosition;
%agent1 pushing
if (action1 == 1)
    boxNewPosition(1)= boxPosition(1)+shift;
elseif (action1 == 2)
    boxNewPosition(1) = boxPosition(1)-shift;
elseif (action1 == 3)
    boxNewPosition(2)= boxPosition(2)+shift;
elseif (action1 == 4)
    boxNewPosition(2)= boxPosition(2)-shift;
end
%agent2 pushing
if (action2 == 1)
    boxNewPosition(1)= boxPosition(1)+shift;
elseif (action2 == 2)
    boxNewPosition(1) = boxPosition(1)-shift;
elseif (action2 == 3)
    boxNewPosition(2)= boxPosition(2)+shift;
elseif (action2 == 4)
    boxNewPosition(2)= boxPosition(2)-shift;
end
%test obstacles
boxNewCt(1) = boxNewPosition(1) + boxLength/2;
boxNewCt(2) = boxNewPosition(2) + boxWidth/2; 
    for i=1:numObs
        distance = boxNewCt - obstacles(i,1:2);
        if(norm(distance)< (obstacles(i,3)+rectR))
            isObs = 1;
        end
    end
    if(isObs == 0)
        boxPosition = boxNewPosition;
    end
boxPosition(1)=min(xmax,boxPosition(1));
boxPosition(2)=min(ymax,boxPosition(2));
boxPosition(1)=max(xmin, boxPosition(1));
boxPosition(2)=max(ymin,boxPosition(2));
%absorb state
if(floor(boxPosition(1))== dest(1) && floor(boxPosition(2))==dest(2))
    absorb =1;
else 
    absorb =0;
end
nextPosition = boxPosition;
% [stateId, destDirec] = calcState(boxPosition, obstacles, dest);
stateId = calcState2(boxPosition);
%stateId = calcState3(boxPosition, obstacles, dest);
% stateId = calcState4(boxPosition);
destDirec = 0;
end

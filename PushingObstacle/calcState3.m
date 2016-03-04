function [stateId]=calcState3(boxPosition, obstacles, dest)
boxLength = 2;
boxWidth = 2;
rectR = sqrt(boxLength*boxLength/4+boxWidth*boxWidth/4);
boxNewCt(1) = boxPosition(1) + boxLength/2;
boxNewCt(2) = boxPosition(2) + boxWidth/2;
state = zeros(1,8);
stateId = 0;
numObs = size(obstacles, 1);
boxState = [boxNewCt+[-1,+1]; boxNewCt+[0,1]; boxNewCt+[1,1]; boxNewCt+[-1,0];...
            boxNewCt+[1,0];boxNewCt+[-1,-1];boxNewCt+[0,-1];boxNewCt+[1,-1]];
for i=1:numObs
    distance = boxState - ...
        [obstacles(i,1:2);obstacles(i,1:2);obstacles(i,1:2);obstacles(i,1:2);...
         obstacles(i,1:2);obstacles(i,1:2);obstacles(i,1:2);obstacles(i,1:2)];
    for j=1:8
        if(norm(distance(j,:))< (obstacles(i,3)+rectR))
            state(j) = 1;
        end
    end
end
for i =1:8
    if(state(i) == 1)
         stateId = (2^(i-1))+stateId;
    end
end
%destination
toDest = dest - boxNewCt;
rectDirec = [0,boxWidth/2];
if(norm(toDest) ~= 0)
destDirecVal = dot(toDest, rectDirec)/(norm(toDest)*norm(rectDirec));
destDirec = acos(destDirecVal);
destDirec = real(mod(destDirec, pi));
else
    destDirec = 0;
end
% if( dest(2)>boxNewCt(2))
%     double = 1;
% else
%     double = 2;
% end
stateId = ceil(destDirec/(4/pi))*stateId+1;
end
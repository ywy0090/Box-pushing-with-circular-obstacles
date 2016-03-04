function [stateId, destDirec]=calcState(boxPosition, obstacles, dest)
stateId = 1;
boxLength = 2;
boxWidth = 2;
dectRange = 10;
state = zeros(1,8);
rectDirec = [0,boxWidth/2];
boxCenter = boxPosition + [boxLength/2, boxWidth/2];
numObs = size(obstacles, 1);
for i=1:numObs
sideMatrix = [0, boxWidth/2; obstacles(i,1)-boxCenter(1), obstacles(i,2)-boxCenter(2)];
flag = det(sideMatrix);
distance = norm([boxCenter(1)-obstacles(i,1),boxCenter(2)-obstacles(i,2)]) -obstacles(i,3);
if(distance < dectRange)
    if(flag < 0 )
        offset = 4;
    else
        offset = 0;
    end
    toObs = obstacles(i,1:2) - boxCenter; 
    obsDirec = acos(dot(toObs, rectDirec)/norm(toObs)*norm(rectDirec));  
    obsDirec = mod(real(obsDirec),pi);
    for j=0:1:3
        if(obsDirec>=(j*pi/4) && obsDirec<= ((j+1)*pi/4))
            state(j+1+offset) = 1;
        end
    end
end
end
%destination
toDest = dest - boxCenter;
if(norm(toDest) ~= 0)
destDirecVal = dot(toDest, rectDirec)/(norm(toDest)*norm(rectDirec));
destDirec = acos(destDirecVal);
destDirec = mod(destDirec, pi);
else
    destDirec = 0;
end

stateId = stateId +(round(real(destDirec/(pi/180))));
if(isnan(stateId))
        disp('!');
    end
for i =1:8
    if(state(i) == 1)
         stateId = (2^(i-1))+stateId;
    end
end

end
function [stateId] = calcState2(boxPosition)
ymax = 20;
stateId = round(boxPosition(2))*ymax+round(boxPosition(1))+1;
end
function [stateId] = calcState4(boxPosition)
ymax = 20;
stateId = (boxPosition(2)*10)*ymax+boxPosition(1)*10+1;
end
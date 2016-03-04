function reward = calculateReward(boxPosition, dest, isObs, absorb)
boxLength = 2;
boxWidth = 2;
ymax=20;
if(isObs == 1)
    reward1 = -2;
else
    reward1 = -1;
end

boxCenter = boxPosition +[boxLength/2, boxWidth/2];
distance = boxCenter-dest;
if(absorb)
    reward2 = 10;
else
    reward2 = (-1)*norm(distance)/ymax;
end

% 
reward = 0.5*reward1 + 0.5*reward2;
end
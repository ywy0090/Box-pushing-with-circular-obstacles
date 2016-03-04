function testTRQ(steps)
%initPos = [10,10];
%dest = [30,20];
obstacles =[6,10,0.5; 5,4,0.4; 7,6,0.5; 8,10,0.6; 14,15,0.3];
%obstacles =[6,10,0.5; 5,4,0.4; 7,6,0.5; 8,10,0.6; 14,15,0.3; ...
%           20,10,0.5; 10,2,0.4; 15,4,0.5; 15,6,0.3];
%obstacles = initMap(3, dest, initPos);
TRQLearning(steps, obstacles);
end
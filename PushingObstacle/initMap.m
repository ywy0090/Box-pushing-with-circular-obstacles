function [obstacles] = initMap(numObstacles, dest, init)
xmax = 20;
boxLength = 2;
boxWidth = 1;
ymax = 20;
radius = 5;
obstacles = zeros(numObstacles,3);
for i=1:numObstacles
    x = rand*xmax;
    y = rand*ymax;
    r = rand*radius;
    distance1 = norm([x-dest(1)-boxLength/2, y-dest(2)-boxWidth/2]);
    distance2 = norm([x-init(1)-boxLength/2, y-init(2)-boxWidth/2]);
    if(distance1 < (r+boxLength/2))
        x = x+boxLength+r;
        y = y+boxLength+r;
    end
    if(distance2 < (r+boxLength/2))
        x = x+boxLength+r;
        y = y+boxLength+r;
    end
    if(distance1)
    obstacles(i,1) = x;
    obstacles(i,2) = y;
    obstacles(i,3) = r;
end
end
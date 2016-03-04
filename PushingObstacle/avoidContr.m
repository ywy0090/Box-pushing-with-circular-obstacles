function [actionNew1, actionNew2] = avoidContr(action1,action2, numAction)
%action 1-right 2-left 3-up 4-down
actionNew1=action1;
actionNew2=action2;
flag1 = (action1 ==1 && action2 == 2);
flag2 = (action1 ==2 && action2 == 1);
flag3 = (action1 ==3 && action2 == 4);
flag4 = (action1 ==4 && action2 == 3);
if(flag1 || flag2 || flag3 || flag4)
    actionNew1 = ceil(rand*numAction);
    actionNew2 = ceil(rand*numAction);
end

end
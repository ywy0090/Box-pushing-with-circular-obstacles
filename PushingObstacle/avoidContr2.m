function [actionNew1, actionNew2] = avoidContr2(action1,action2, numAction)
%action 1-right 2-left 3-up 4-down
actionNew1=action1;
actionNew2=action2;
actionSet=[1,2,3,4];
flag1 = (action1 ==1 && action2 == 2);
flag2 = (action1 ==2 && action2 == 1);
flag3 = (action1 ==3 && action2 == 4);
flag4 = (action1 ==4 && action2 == 3);
if(flag1 || flag2 || flag3 || flag4)
    sub = actionSet(actionSet~=action2);
    actionNew2 = sub(ceil(rand*(numAction-1)));
end

end
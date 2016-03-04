function [action] = selectAction(qTable, stateId, numAction, current)
action = current;
flag1 = (qTable(stateId,1) == qTable(stateId,2));
flag2 = (qTable(stateId,2) == qTable(stateId,3));
flag3 = (qTable(stateId,3) == qTable(stateId,4));
if(flag1*flag2*flag3 == 1)
    action = ceil(rand*numAction);
end
end
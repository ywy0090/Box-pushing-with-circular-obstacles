function qtable = planModel(qtable, model, planSteps, alpha, gamma)
[s_list, a_list] = find(model(:,:,1));
for j=1:planSteps
    %random index over s_list
    i = randi(numel(s_list));

    % random previously visited state
    s = s_list(i);
    % random action previously taken at state s
    a = a_list(i);

    sp  = model(s,a,1);    
    r   = model(s,a,2);    
    maxq1 = max(qtable(sp,:));
    qtable(s,a) = (1 - alpha)*qtable(s,a) + ...
        alpha*(r + gamma*maxq1);
end
end

% Debug vars
residual_array = zeros(1,10000);
residual_iter = 1;

% Hillclimber vars
loop_iter = 1;
INCREASE = true;
DECREASE = false;
residual = 500;
step = 1; % ***Consider reducing or increasing step size dynamically*** %
minimum_residual = 500;
min_index = -1;
step_decrease_index = -1;

% Known knowns
S1_exp = 200 + 1i*40;
S2_exp = 160 + 1i*80;
Zs1 = 1i*5;
Zs2 = 1i*5;
ZL = 1i*10;

% Known unknowns
Vs1_real = 100;
Vs1_imag = 0;
Vs2_real = 100;
Vs2_imag = 0;      % we probably need to use the unknowns() array instead to allow 
V1_real = 100;       % for simple coding of the hillclimber
V1_imag = 0;
V2_real = 100;
V2_imag = 0;
unknowns = [Vs1_real,Vs1_imag,Vs2_real,Vs2_imag,V1_real,V1_imag,V2_real,V2_imag];
chosen_unknown = 1; % this will cycle through 1 to 8


while residual > 10^-6
    
    Vs1 = unknowns(1) + 1i*unknowns(2);
    Vs2 = unknowns(3) + 1i*unknowns(4);
    V1  = unknowns(5) + 1i*unknowns(6);
    V2  = unknowns(7) + 1i*unknowns(8);

    % debug - maybe delete later - start
%     if abs(Vs1) > 105 || abs(Vs1) < 95 || abs(Vs2) > 105 || abs(Vs2) < 95 || abs(V1) > 105 || abs(V1) < 95 || abs(V2) > 105 || abs(V2) < 95
%         residual = residual + 1; % add penalty to force hillclimber to revert and try something else
%     else
    % debug - maybe delete later - end
        
        % calculations - start
        Is1 = (V1 - Vs1) / Zs1;
        Is2 = (V2 - Vs2) / Zs2;
        IL = (V2 - V1) / ZL;
        
        I1 = Is1 - IL;
        I2 = Is2 + IL;
        
        S1_calc = V1*conj(I1);
        S2_calc = V2*conj(I2);
        
        residual_prev = residual;
        residual = abs(S1_exp - S1_calc) + abs(S2_exp - S2_calc);
        % calculations - end
    % end % debug - if-end

    % did we reduce the residual? 
    % If so, continue
    % ELSE
    % If increased unknown once, now try decreasing
    % If increased unknown +1 times, retain gains by changing unknown to optimize
    % If decreased unknown once, change unknown to optimize
    % If decreased unknwon +1 times, retain gains by changing unknown to optimize

    if residual < residual_prev && INCREASE == true
        unknowns(chosen_unknown) = unknowns(chosen_unknown) + step;
        loop_iter = loop_iter + 1;
    elseif residual < residual_prev && DECREASE == true
        unknowns(chosen_unknown) = unknowns(chosen_unknown) - step;
        loop_iter = loop_iter + 1;
    elseif residual >= residual_prev && INCREASE == true && loop_iter == 1
        DECREASE = true;
        INCREASE = false;
        unknowns(chosen_unknown) = unknowns(chosen_unknown) - 2*step; % 2*step to undo positive step and then step negatively
        loop_iter = 1;
    elseif residual >= residual_prev && (DECREASE == true || (INCREASE == true && loop_iter > 1))
        % track back to better elevation first...
        if DECREASE == true
            unknowns(chosen_unknown) = unknowns(chosen_unknown) + step;
        else
            unknowns(chosen_unknown) = unknowns(chosen_unknown) - step;
        end
        % ...then change the unknown var we are tweaking
        chosen_unknown = chosen_unknown + 1;
        if chosen_unknown > 8
            chosen_unknown = 1;
        end
        % unknowns(chosen_unknown) = unknowns(chosen_unknown) + step;
        loop_iter = 1;
        INCREASE = true;
        DECREASE = false;
    end

    residual_array(residual_iter) = residual;
    residual_iter = residual_iter + 1;
    
    if residual < minimum_residual
        minimum_residual = residual;
        min_index = residual_iter - 1;
    end

    % ---Dynamic Step Size Reduction---
    % Here we reduce the step size if we find our hillclimber stuck
    % on what seems to be a local peak, not the global peak.
    % If we reduce the step size, he can often continue to make progress.
    if residual_iter - min_index > 25 && abs(step_decrease_index - residual_iter) > 25
        step = step / 2;
        step_decrease_index = residual_iter;
    end

end






















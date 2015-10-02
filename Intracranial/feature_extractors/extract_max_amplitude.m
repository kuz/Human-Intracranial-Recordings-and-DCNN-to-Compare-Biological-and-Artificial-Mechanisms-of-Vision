%
% Take all subjects from the Processed/LFP direectory and extract maximal
% LFP value for each (subject, stimulus, probe) triple
%

% load subject list
listing = dir('../../../Data/Intracranial/Processed/LFP/*.mat')

% for each subject

    % for each stimulus

        % for each probe
    
            % compute maximum LFP across the whole signal 
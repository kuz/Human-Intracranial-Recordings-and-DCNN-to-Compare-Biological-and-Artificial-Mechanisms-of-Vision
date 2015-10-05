%
% Take all subjects from the Processed/LFP direectory and extract average
% over high gamma (70-150 Hz) band for each (subject, stimulus, probe)
% triple
%

% load subject list
subjects = textread('../subjects.txt', '%s', 'delimiter', '\n');


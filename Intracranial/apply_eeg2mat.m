%
% Convert .eeg files to .mat matrices
% Elan (http://elan.lyon.inserm.fr/) should be installed so that eeg2mat script in the Matlab path
% See http://elan.lyon.inserm.fr/?q=eeg2mat for more information
%

% add elan scipts to the path
addpath('/home/parallels/Software/Elan/misc/matlab')

% compose a list of .eeg file
eegfiles = dir('../../Data/Intracranial/Restructured/*.EEG');

% process .eeg files one by one
for i = 51:length(eegfiles)

    % display progress
    disp(['Processing ' eegfiles(i).name ' ' num2str(i) '/' num2str(length(eegfiles))])

    % convert an .eeg file
    [m_data, m_events, v_label_selected, s_fs, s_nb_samples_all, s_nb_channel_all, ...
     v_label_all, v_channel_type_all, v_channel_unit_all, str_ori_file1, str_ori_file2] = ...
     eeg2mat(['../../Data/Intracranial/Restructured/' eegfiles(i).name], 1, 'all', 'all', ...
             'save', ['../../Data/Intracranial/Restructured/' eegfiles(i).name '.MAT']);

end

%
% Assemble data about each subject into a Matlab data structure with fixed
% format
%

addpath('./mniplots')

% load the list of subjects
subjects = textread('subjects.txt', '%s', 'delimiter', '\n');

% normally loaded form subjects.txt
% for testing purposes given manually here as
%subjects = {'AB_12JAN10G', 'AL_25FEV13N', 'AM_10JAN12G'};

% load the sequence of stimuli
stimseq = textread('stimsequence.txt', '%s', 'delimiter', '\n');
stimgroups = textread('stimgroups.txt', '%d', 'delimiter', '\n');

for subject = subjects
    
    % set the break flag used in the inner loops
    break_flag = false;
    
    subject = subject{1};
    disp(['Processing ' subject '...'])
    
    % load subject data
    load(['../../Data/Intracranial/Restructured/' subject '_VISU.EEG.MAT'])
    
    % pick the timestamps corrsponding to the moments when images from the
    % stimulus sequence were shown
    picevents = m_events(m_events(:, 2) == 10 | m_events(:, 2) == 20 | ...
                         m_events(:, 2) == 30 | m_events(:, 2) == 40 | ...
                         m_events(:, 2) == 50 | m_events(:, 2) == 80 | ...
                         m_events(:, 2) == 90, :);
    pictimes = picevents(:, 1);
    picstims = picevents(:, 2);
    
    % check that in the list of events all stimuli groups follow in the
    % same order as prescribes in the experiment file (loca_visu.pcl)
    if length(stimgroups) ~= length(picstims) || ~all(stimgroups == picstims)
        disp(['  ERROR: Subject ' subject ' has invalid list of stimuli. Moving on.'])
        continue
    end
    
    % store stimulus information
    s = struct();
    s.stimseq = stimseq;
    s.stimgroups = stimgroups;
    
    % store electrode locations
    mni_pts = ['../../Data/Intracranial/Restructured/' subject '_MNI.PTS'];
    coords_mat = ['../../Data/Intracranial/Restructured/' subject '_COORDS.MAT'];
    if exist(mni_pts, 'file') == 2
        coords = load_mni_pts(mni_pts);
    elseif exist(coords_mat, 'file') == 2
        coords = load_coords_mat(coords_mat);
    else
        disp('  ERROR: No probe position data found, moving on.')
        continue
    end
    
    % extract rod names
    rod_names = {};
    for label = v_label_selected
        rod_name = regexp(label, '^[A-z]+', 'match');
        rod_names{end + 1} = rod_name{1};
    end
    all_rod_names = [rod_names{:}];
    
    % drop labels and data for the electrodes we are not interested in
    to_exclude = {'MKR', 'fz', 'cz', 'pz', 'ecg', 'thor', 'abdo', 'xyz'};
    for excluded_name = to_exclude
        drop_ids = strmatch(excluded_name, char(all_rod_names), 'exact');
        m_data(drop_ids, :) = [];
        v_label_selected(drop_ids) = [];
        all_rod_names(drop_ids) = [];
    end
    
    % take list of possible rod names
    rod_names = unique(all_rod_names, 'stable');
    
    % clazily ugly code to extract probe indices for each rod and MNI
    % coordinates
    active_coords = struct();
    active_coords.rod_names = [];
    active_coords.probe_ids = [];
    active_coords.mni = [];
    for rod_id = 1:length(rod_names)
        
        % extract rod name
        rod_name = rod_names{rod_id};
        
        % find all probes which belong to that rod
        probes = strmatch(rod_name, char(all_rod_names), 'exact');
        last_num = 0;
        for probe_id = probes'
            
            % extract probe names and number of each probe on its rod
            probe_name = regexp(v_label_selected(probe_id), ['^' rod_name '[0-9]*\.'], 'match');
            probe_name = char(probe_name{1});
            probe_name = probe_name(length(rod_name)+1:end-1);
            probe_num = str2num(probe_name);
            if length(probe_num) == 0
                probe_num = last_num + 1;
            end
            last_num = probe_num;
            
            % store the extracted data
            if rod_id <= size(coords, 2)
                active_coords.rod_names = [active_coords.rod_names; rod_name];
                active_coords.probe_ids = [active_coords.probe_ids; probe_num];

                if size(coords{rod_id}, 1) < probe_num
                    disp(['  ERROR: Subject ' subject ' has ' num2str(probe_num) ...
                          'th probe on rod ' num2str(rod_id) ' according to v_label_selected' ...
                          ', but actually coords{' num2str(rod_id) '} has only ' ...
                          num2str(size(coords{rod_id}, 1)) ' rows. Moving on.'])
                    break_flag = true;
                    break
                end
                active_coords.mni = [active_coords.mni; coords{rod_id}(probe_num, :)]; 
            end
        end
        
        if break_flag
            break
        end
    end
    
    if break_flag
        clearvars -except subjects stimseq stimgroups
        break
    end
    
    s.probes = active_coords;
    
    % stimulus is shown for 200ms, extract the corresponding 1000ms of
    % the signal after the stimulus onset
    s.data = zeros(length(stimseq), length(active_coords.probe_ids), 1300);
    for sid = 1:length(stimseq)
        s.data(sid, :, :) = m_data(:, pictimes(sid) - 500:pictimes(sid) + 799);
    end
    
    % add some metadata
    s.name = subject;
    
    % store the data
    save(['../../Data/Intracranial/Processed/LFP/' subject '.mat'], 's');
    
    % drop all variables which are relevant to this subject
    clearvars -except subjects stimseq stimgroups
    
end
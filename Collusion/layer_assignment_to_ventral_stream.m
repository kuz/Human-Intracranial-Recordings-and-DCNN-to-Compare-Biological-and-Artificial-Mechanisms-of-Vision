%
% Compute stats of probe to layer assignments
%

addpath('../Intracranial/lib/mni2name')


%% Parameters
featureset = 'meangamma.onebin';
talareich_level = 5;


%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Probe_to_Layer_Maps/' featureset '/*.txt']);


%% Compute stats
area_id_map = containers.Map();
area_id_map_reverse = {};
stats = {};

areas_of_interest = {'brodmann area 17', 'brodmann area 18', 'brodmann area 19', ...
                     'brodmann area 37', 'brodmann area 20', 'brodmann area 38', ...
                     'brodmann area 28', 'brodmann area 27', 'brodmann area 35'};
for i = 1:length(areas_of_interest)
    area = areas_of_interest{i};
    area_id_map(area) = i;
    area_id_map_reverse{i} = area;
end

% for each subject
for fid = 1:length(listing)
    [pathstr, name, ext] = fileparts(listing(fid).name);
    subject = name;
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' featureset '/' subject '.mat'])
    
    % get the names of the areas
    s.probes.mni(isnan(s.probes.mni)) = 0;
    [~, areas] = mni2name(s.probes.mni);
    
    % load the mapping
    probe_to_layer_map = load(['../../Data/Intracranial/Probe_to_Layer_Maps/' featureset '/' listing(fid).name]);
    probe_to_layer_map(probe_to_layer_map == -1) = 9;
    
    % check
    if sum(probe_to_layer_map) == 0
        disp('  Probes not assigned, skipping...')
        continue
    end
    
    % compute stats
    for i = 1:size(areas, 1)
        
        % keep only Brodmann areas 17, 18, 19, 37, 20, 38, 28, 27, 35
        if ~isKey(area_id_map, areas{i, talareich_level})
            continue
        end
        
        % key area id
        area_id = area_id_map(areas{i, talareich_level});
        
        % update counter
        if area_id > size(stats, 1) || probe_to_layer_map(i) > size(stats, 2)
            stats{area_id, probe_to_layer_map(i)} = 0;
            stats(cellfun(@isempty, stats)) = {0};
        end
        stats{area_id, probe_to_layer_map(i)} = stats{area_id, probe_to_layer_map(i)} + 1;
        
    end
    
    % clear workspace
    clearvars -except listing talareich_level featureset area_id_map area_id_map_reverse ...
                      stats areas_of_interest
    
end

stats = cell2mat(stats);
stats_counts = stats;

% store original counts
%csvwrite('../../Outcome/Mapper/Stats/assigned_to_layer_per_region_counts.csv', stats_counts);

%% for each region compute "assigned to layer L / total in this region"
for r = 1:length(area_id_map)
    for l = 1:8
        stats(r, l) = stats_counts(r, l) / sum(stats_counts(r, 1:9));
    end
end
stats(isnan(stats)) = 0;

%% Plot heatmap
imagesc(stats(:, 1:8));
set(gca, 'XTick', 1:8, 'YTick', 1:length(area_id_map_reverse), 'YTickLabel', area_id_map_reverse)
xlabel('Layer')
set(gca,'Position',[0.35 0.05 0.4 0.9])

% total counts
sums = sum(stats_counts, 2);
for i = 1:length(sums)
    text(8.7, i, [num2str(sums(i))])
end

% numbers on top of imagesc
counts = stats_counts(:, 1:8);
textStrings = num2str(counts(:), '%d');
textStrings = strtrim(cellstr(textStrings));
[x,y] = meshgrid(1:8, 1:size(stats_counts, 1));
hStrings = text(x(:), y(:), textStrings(:), 'HorizontalAlignment', 'center');
%midValue = mean(get(gca,'CLim'));
%textColors = repmat(counts(:) > midValue,1,3);
%set(hStrings,{'Color'},num2cell(textColors,2));

% colorbar
pos=get(gca,'pos');
colorbar('position',[pos(1)+pos(3)+0.1 pos(2) 0.03 pos(4)]);





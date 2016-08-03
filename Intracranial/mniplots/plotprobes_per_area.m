%
% Plot probes with colors based on the assigned layer
%

% imports
addpath('../lib/mni2name');
addpath('../lib/mnimesh');

% parameters
featureset = 'LFP_bipolar_noscram';
%talareich_level = 5;
area_of_interest = '0';
db = load_nii('../lib/mni2name/brodmann.nii');

% list of subjects
listing = dir(['../../../Data/Intracranial/Processed/' featureset '/*.mat']);

% load brain mesh
[tri, coord, nbr, normal]=mni_getmesh('../lib/mnimesh/outersurface.obj');
color = zeros(size(coord(3, :)));

%% Generate figure

% plot the mesh
fig = figure('Position', [0, 0, 1600, 300], 'Visible', 'off');
xview = subplot(1, 3, 1);
mesh = trisurf(tri, coord(1,:), coord(2,:), coord(3,:), color, 'facealpha', 0.1);
colormap(gray);
set(mesh, 'edgecolor', 'none');
hold on;

% for each subject
for fid = 1:length(listing)
    subject = listing(fid).name;
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../../Data/Intracranial/Processed/' featureset '/' subject])
    
    % plot each prob in corresponding color
    for pid = 1:size(s.probes.mni, 1)
        %[~, areas] = mni2name([s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3)]);
        %key = areas{talareich_level}
        [~, areas] = mni2name_brodmann(s.probes.mni, db);
        key = num2str(areas{1});
        if strcmp(key, area_of_interest) == 1
            plot3(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), '.', 'MarkerSize', 20);
        end
    end
    
    % clear workspace
    clearvars -except xview tri normal nbr mesh listing fig coord featureset ...
                      talareich_level area_of_interest db
    
end

% produce x, y, z plane views
view([-1, 0, 0]);
yview = subplot(1, 3, 2);
copyobj(allchild(xview), yview);
view([0, 1, 0]);
zview = subplot(1, 3, 3);
copyobj(allchild(xview), zview);
view([0, 0, 1]);
       
% save the figure
drawnow;
r = 70;
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 1600 300]/r);
print(gcf, '-dpng', sprintf('-r%d', r), ['../../../Outcome/Visualized probe locations/Area_' area_of_interest '.png']);

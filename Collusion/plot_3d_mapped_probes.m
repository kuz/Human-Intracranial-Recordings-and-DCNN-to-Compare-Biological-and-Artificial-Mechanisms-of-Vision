%
% Plot probes with colors based on the assigned layer
%

%% Parameters
featureset = 'meangamma_bipolar_noscram_artif_responsive';

%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Probe_to_Layer_Maps/' featureset '/*.txt']);

%% Load mesh data
addpath('../Intracranial/lib/mnimesh');
[tri, coord, nbr, normal]=mni_getmesh('../Intracranial/lib/mnimesh/outersurface.obj');
color = zeros(size(coord(3, :)));


%% Generate figure
counter = 0;

% plot the mesh
fig = figure('Position', [0, 0, 1600, 300], 'Visible', 'off');
xview = subplot(1, 3, 1);
mesh = trisurf(tri, coord(1,:), coord(2,:), coord(3,:), color, 'facealpha', 0.1);
colormap(gray);
set(mesh, 'edgecolor', 'none');
zlim([-80, 100]);
ylim([-150, 100]);
hold on;

% for each subject
for fid = 1:length(listing)
    [pathstr, name, ext] = fileparts(listing(fid).name);
    subject = name;
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/' featureset '/' subject '.mat'])
    
    % load the mapping
    probe_to_layer_map = load(['../../Data/Intracranial/Probe_to_Layer_Maps/' ...
                              featureset '/' listing(fid).name]);
    probe_to_layer_map = max(probe_to_layer_map');
    
    % plot each prob in corresponding color
    for pid = 1:size(s.probes.mni, 1)
        if probe_to_layer_map(pid) ~= 0
            plot3(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), ...
                  '.', 'MarkerSize', 10);
            counter = counter + 1;
        end
    end
    
    % clear workspace
    clearvars -except xview tri normal nbr mesh listing fig coord color featureset counter
    
end

% produce x, y, z plane views
view([-1, 0, 0]);
yview = subplot(1, 3, 2);
xlim([-100, 100]);
zlim([-80, 100]);
copyobj(allchild(xview), yview);
view([0, 1, 0]);
zview = subplot(1, 3, 3);
xlim([-100, 100]);
zlim([-120, 80]);
copyobj(allchild(xview), zview);
view([0, 0, 1]);
       
% save the figure
drawnow;
r = 70;
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 1600 300]/r);
print(gcf, '-dpng', sprintf('-r%d', r), ['../../Outcome/Figures/' featureset '/mapped_probes.png']);

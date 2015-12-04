%
% Plot probes with colors based on the assigned layer
%

%% Parameters
featureset = 'maxamp';

%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Probe_to_Layer_Maps/' featureset '/*.txt']);

%% Load mesh data
addpath('../Intracranial/lib/mnimesh');
[tri, coord, nbr, normal]=mni_getmesh('../Intracranial/lib/mnimesh/outersurface.obj');
color = zeros(size(coord(3, :)));


%% Generate figure

% layer color scale
layercolors = flipud(autumn(8));

% plot the mesh
fig = figure('Position', [0, 0, 1600, 300], 'Visible', 'off');
xview = subplot(1, 3, 1);
mesh = trisurf(tri, coord(1,:), coord(2,:), coord(3,:), color, 'facealpha', 0.1);
colormap(gray);
set(mesh, 'edgecolor', 'none');
hold on;

% for each subject
for fid = 1:length(listing)
    [pathstr, name, ext] = fileparts(listing(fid).name);
    subject = name;
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/maxamp/' subject '.mat'])
    
    % load the mapping
    probe_to_layer_map = load(['../../Data/Intracranial/Probe_to_Layer_Maps/' ...
                              featureset '/' listing(fid).name]);
    
    % plot each prob in corresponding color
    for pid = 1:length(s.probes.mni)
        if probe_to_layer_map(pid) ~= -1
            plot3(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), ...
                  '.', 'color', layercolors(probe_to_layer_map(pid), :), 'MarkerSize', 20);
        end
    end
    
    % clear workspace
    clearvars -except xview tri normal nbr mesh listing layercolors fig coord color featureset
    
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
r = 60;
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 1600 300]/r);
print(gcf, '-dpng', sprintf('-r%d', r), ['Figures/' featureset '/ALL.png']);

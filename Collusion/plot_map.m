%
% Plot probes with colors based on the assigned layer
%

%% List of subject for whom we have the mapping
listing = dir('../../Data/Intracranial/Probe_to_Layer_Maps/*.txt')

%% Load mesh data
addpath('../Intracranial/lib/mnimesh')
[tri, coord, nbr, normal]=mni_getmesh('../Intracranial/lib/mnimesh/outersurface.obj');
color = zeros(size(coord(3, :)));


%% Generate figures

% layer color scale
layercolors = jet(8);

% for each subject
for fid = 1:length(listing)
    [pathstr, name, ext] = fileparts(listing(fid).name);
    subject = name;
    
    % display progress
    disp(['Processing ' num2str(fid) '/' num2str(length(listing)) ': ' subject '...'])
    
    % load the data
    load(['../../Data/Intracranial/Processed/maxamp/' subject '.mat'])
    
    % load the mapping
    probe_to_layer_map = load(['../../Data/Intracranial/Probe_to_Layer_Maps/' listing(fid).name]);
    
    % plot the mesh
    fig = figure('Position', [0, 0, 1600, 300], 'Visible', 'off');
    xview = subplot(1, 3, 1);
    mesh = trisurf(tri, coord(1,:), coord(2,:), coord(3,:), color, 'facealpha', 0.1);
    colormap(gray);
    set(mesh, 'edgecolor', 'none');
    hold on;
    
    % plot each prob in corresponding color
    for pid = 1:length(s.probes.mni)
        plot3(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), ...
              '.', 'color', layercolors(probe_to_layer_map(pid), :), 'MarkerSize', 20);
    end
    hold off;

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
    r = 50;
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 1600 300]/r);
    print(gcf, '-dpng', sprintf('-r%d', r), ['Figures/' subject '.png']);
    
    % clear workspace
    clearvars -except listing tri coord nbr normal color layercolors
    
end

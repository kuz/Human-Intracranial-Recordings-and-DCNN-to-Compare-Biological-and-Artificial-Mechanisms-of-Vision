%
% Plot probes with colors based on the assigned layer
%

%% Parameters
featureset = 'meangamma_ventral_w250_10hz';

%% List of subject for whom we have the mapping
listing = dir(['../../Data/Intracranial/Probe_to_Layer_Maps/' featureset '/*.txt'])

%% Load mesh data
addpath('../Intracranial/lib/mnimesh')
[tri, coord, nbr, normal]=mni_getmesh('../Intracranial/lib/mnimesh/outersurface.obj');
color = zeros(size(coord(3, :)));


%% Generate figures

% layer color scale
layercolors = flipud(autumn(8));

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
    
    % plot the mesh
    fig = figure('Position', [0, 0, 1600, 300], 'Visible', 'off');
    xview = subplot(1, 3, 1);
    mesh = trisurf(tri, coord(1,:), coord(2,:), coord(3,:), color, 'facealpha', 0.1);
    colormap(gray);
    set(mesh, 'edgecolor', 'none');
    hold on;
    
    % plot each prob in corresponding color
    for pid = 1:size(s.probes.mni, 1)
        
        % If you want to plot all probes
        %plot3(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), ...
        %      '.', 'MarkerSize', 35);
        %text(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), ...
        %     num2str(pid), 'HorizontalAlignment', 'center', 'FontSize', 7);

        if probe_to_layer_map(pid) ~= -1
            plot3(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), ...
                  '.', 'color', layercolors(probe_to_layer_map(pid), :), 'MarkerSize', 60);
            text(s.probes.mni(pid, 1), s.probes.mni(pid, 2), s.probes.mni(pid, 3), ...
                 num2str(pid), 'HorizontalAlignment', 'center', 'FontSize', 7);
        end
    end
    hold off;

    % save the figure
    % If you want to plot all probes
    %savefig(['Figures/LFP/' subject '.fig']);
    %savefig(['Figures/' featureset '/' subject '.fig']);
    
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
    r = 100;
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 4800 900]/r);
    
    % If you want to plot all probes
    %print(gcf, '-dpng', sprintf('-r%d', r), ['Figures/LFP/' subject '.png']);
    print(gcf, '-dpng', sprintf('-r%d', r), ['../../Outcome/Figures/' featureset '/' subject '.png']);
    
    % clear workspace
    clearvars -except listing tri coord nbr normal color layercolors featureset
    
end

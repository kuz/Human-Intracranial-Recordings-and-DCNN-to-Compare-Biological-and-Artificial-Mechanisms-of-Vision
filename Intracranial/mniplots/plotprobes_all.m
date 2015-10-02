%
% Plot electrode potisions given MNI coordinates
%

%% Load data
subjects = textread('../subjects.txt', '%s', 'delimiter', '\n');

%% Load mesh data
addpath('../lib/mnimesh')
[tri, coord, nbr, normal]=mni_getmesh('../lib/mnimesh/outersurface.obj');
color = zeros(size(coord(3, :)));

%% Generate figures

% for each subject
for s = 1:length(subjects)
    subject = subjects{s};
    
    % display progress
    disp(['Processing ' num2str(s) '/' num2str(length(subjects)) ': ' subject '...'])
    
    % load probe coordinates
    mni_pts = ['../../../Data/Intracranial/Restructured/' subject '_MNI.PTS'];
    coords_mat = ['../../../Data/Intracranial/Restructured/' subject '_COORDS.MAT'];
    if exist(mni_pts, 'file') == 2
        coords = load_mni_pts(mni_pts);
    elseif exist(coords_mat, 'file') == 2
        coords = load_coords_mat(coords_mat);
    else
        disp('  No probe position data found, moving on.')
        continue
    end
    
    % plot the mesh
    fig = figure('Position', [0, 0, 1600, 300], 'Visible', 'off');
    xview = subplot(1, 3, 1);
    mesh = trisurf(tri, coord(1,:), coord(2,:), coord(3,:), color, 'facealpha', 0.1);
    colormap(gray);
    set(mesh, 'edgecolor', 'none');
    hold on;

    % for each rod
    for rod = coords
        rod = rod{1};
        rod(sum(rod, 2) == 0, :) = [];
        if size(rod, 1) > 0
            x = [rod(1, 1); rod(end, 1)];
            y = [rod(1, 2); rod(end, 2)];
            z = [rod(1, 3); rod(end, 3)];
            plot3(x, y, z, 'color', 'black', 'LineWidth', 2); 

            for probe = rod'
                plot3(probe(1), probe(2), probe(3), 'o');
            end
        end
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
    print(gcf, '-dpng', sprintf('-r%d', r), ['../Figures/Rods in the brains/' subject '.png']);
    
end

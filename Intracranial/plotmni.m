%
% Plot electrode potisions given MNI coordinates
%

%% Load data
datafiles = struct;
datafiles(1).coords  = '../../Data/Raw_data/AB_coords_2010.mat';
datafiles(1).eeg     = '../../Data/Raw_data/AB_12JAN10G_VISU.eeg.mat';
datafiles(2).coords  = '../../Data/Raw_data/AM_coords_2012.mat';
datafiles(2).eeg     = '../../Data/Raw_data/AM_10JAN12G_VISU.eeg.mat';
datafiles(3).coords  = '../../Data/Raw_data/AP_coords_2011.mat';
datafiles(3).eeg     = '../../Data/Raw_data/AP_15FEV11G_VISU.eeg.mat';
datafiles(4).coords  = '../../Data/Raw_data/CB_coords_2010.mat';
datafiles(4).eeg     = '../../Data/Raw_data/CB_28JAN10G_VISU.eeg.mat';
datafiles(5).coords  = '../../Data/Raw_data/CE_coords_2010.mat';
datafiles(5).eeg     = '../../Data/Raw_data/CE_28SEP10G_VISU.eeg.mat';
datafiles(6).coords  = '../../Data/Raw_data/CQ_coords_2012.mat';
datafiles(6).eeg     = '../../Data/Raw_data/CQ_24JAN12G_VISU.eeg.mat';
datafiles(7).coords  = '../../Data/Raw_data/EC_coords_2012.mat';
datafiles(7).eeg     = '../../Data/Raw_data/EC_25JUI12G_VISU.eeg.mat';
datafiles(8).coords  = '../../Data/Raw_data/EG_coords_2012.mat';
datafiles(8).eeg     = '../../Data/Raw_data/EG_16AVR12G_VISU.eeg.mat';
datafiles(9).coords  = '../../Data/Raw_data/MC_coords_2012.mat';
datafiles(9).eeg     = '../../Data/Raw_data/MC_28FEV12G_VISU.eeg.mat';
datafiles(10).coords = '../../Data/Raw_data/MM_coords_2012.mat';
datafiles(10).eeg    = '../../Data/Raw_data/MM_22OCT12G_VISU.eeg.mat';
datafiles(11).coords = '../../Data/Raw_data/NR_coords_2011.mat';
datafiles(11).eeg    = '../../Data/Raw_data/NR_14FEV12G_VISU.eeg.mat';
datafiles(12).coords = '../../Data/Raw_data/PM_coords_2012.mat';
datafiles(12).eeg    = '../../Data/Raw_data/PM_17JAN12G_VISU.eeg.mat';
datafiles(13).coords = '../../Data/Raw_data/VS_coords_2011.mat';
datafiles(13).eeg    = '../../Data/Raw_data/VS_22FEV11G_VISU.eeg.mat';

%% Load mesh data
addpath('./lib/mnimesh')
[tri, coord, nbr, normal]=mni_getmesh('./lib/mnimesh/outersurface.obj');
color = zeros(size(coord(3, :)));

%% Generate figures

% for each datafile pair
for filepair = datafiles
    
    % display progress
    disp(['Processing ' filepair.eeg])
    
    % load the data
    load(filepair.coords)
    load(filepair.eeg)
    
    % plot the mesh
    mesh = trisurf(tri, coord(1,:), coord(2,:), coord(3,:), color, 'facealpha', 0.1);
    colormap(gray);
    set(mesh, 'edgecolor', 'none');
    hold on;

    % for each rod
    for rod = probecoords_mni
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

    % save the figure
    pathparts = strsplit(filepair.eeg, '/');
    drawnow;
    savefig(['Figures/Rods in the brain/' pathparts{end} '.fig'])
    
end

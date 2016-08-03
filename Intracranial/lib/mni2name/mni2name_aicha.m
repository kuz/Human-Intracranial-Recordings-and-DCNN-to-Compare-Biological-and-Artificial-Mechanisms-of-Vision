%
%                    MNI             XYZ          Nr
%                    ---             ---          --
% Center               0,   0,   0   46, 64, 37    0
% Center +2            2,   2,   2   47, 65, 38    0
% G_Temporal_Mid_1    59,   0, -20   76, 64, 27   90
% S_Postcentral_2    -44, -28,  48   24, 50, 61   37
%
% Usage
%   addpath('lib/nifti')
%   db = load_nii('lib/mni2name/aicha.nii');
%   [~, areas] = mni2name_brodmann([44, -39, 16], db);

function [zombie, areas] = mni2name_aicha(mni, db)
zombie = 0;
areas = {};
for i = 1:size(mni, 1)
    x = round(mni(i, 1) / 2) + 46;
    y = round(mni(i, 2) / 2) + 64;
    z = round(mni(i, 3) / 2) + 37;
    areas{end + 1} = db.img(x, y, z);
end
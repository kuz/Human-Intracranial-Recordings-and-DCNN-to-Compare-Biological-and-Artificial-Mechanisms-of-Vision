%
%   MNI  XYZ
%   ---  ---
% X   0   91
% Y   0  126
% Z   0   72
%
% Usage
%   addpath('lib/nifti')
%   db = load_nii('lib/mni2name/brodmann.nii');
%   [~, areas] = mni2name_brodmann([44, -39, 16], db);

function [zombie, areas] = mni2name_brodmann(mni, db)
zombie = 0;
areas = {};
for i = 1:size(mni, 1)
    x = round(mni(i, 1)) + 91;
    y = round(mni(i, 2)) + 126;
    z = round(mni(i, 3)) + 72;
    areas{end + 1} = db.img(x, y, z);
end

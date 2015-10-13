%
% Loads SUBJECTNAME_COORDS.MAT files and returns probe coordinates
%

function [coords, rod_names] = load_coords_mat(filename)
load(filename);
coords = probecoords_mni;
rod_names = probename;
end
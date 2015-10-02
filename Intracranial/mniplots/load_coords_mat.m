%
% Loads SUBJECTNAME_COORDS.MAT files and returns probe coordinates
%

function coords = load_coords_mat(filename)
load(filename)
coords = probecoords_mni;
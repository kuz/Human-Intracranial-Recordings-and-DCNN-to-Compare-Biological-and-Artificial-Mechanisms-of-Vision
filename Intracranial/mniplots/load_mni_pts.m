%
% Loads SUBJECTNAME_MNI.PTS files and returns probe coordinates
%

function coords = load_mni_pts(filename)

% scan in the .pts file
fid = fopen(filename,'rt'); 
indata = textscan(fid, '%s %f %f %f %*[^\n]', 'HeaderLines', 3); 
fclose(fid);

% transform it to cell structure where one cell is one rod and each row of
% the matrix (PROBES x 3) shows xyz coordinates of the probe
coords = {};
map = containers.Map();
for i = 1:length(indata{1})
    
    % extract data units
    rod = regexp(indata{1}{i}, '[A-z]+', 'match');
    rod = rod{1};
    x = indata{2}(i);
    y = indata{3}(i);
    z = indata{4}(i);
    
    % map rod name to unique id
    if ~isKey(map, rod)
        map(rod) = length(map) + 1;
        coords{map(rod)} = [x y z];
    else
        coords{map(rod)} = [coords{map(rod)}; x y z];
    end    
end

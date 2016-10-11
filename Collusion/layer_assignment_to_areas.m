%
% Compute stats of probe to layer assignments
%   


%% Parameters
mapperset = 'rsa_euclidean_meangamma_bipolar_noscram_artif_responsive_brodmann.01';
nlayers = 9;
nareas = 49;

%% load data
probe_to_area_map = load(['../../Data/Intracranial/Probe_to_Layer_Maps/' mapperset '/all.txt']);

%% variance explained normalized by the number of probes in the area
varexp = (probe_to_area_map .^ 2) * 100;

%% What to plot
toplot = varexp;
%toplot = stats ./ (269);
%toplot = stats ./ repmat(signf_counts', 1, nlayers) ./ nlayers;

%% Plot heatmap
imagesc(toplot(:, 1:nlayers));
set(gca, 'XTick', 1:nlayers, 'YTick', 1:nareas, 'YTickLabel', (1:nareas)-1)
xlabel('Layer')
set(gca,'Position',[0.35 0.05 0.4 0.9])

% numbers on top of imagesc
strings = toplot(:, 1:nlayers);
textStrings = num2str(strings(:), '%2.2f');
textStrings = strtrim(cellstr(textStrings));
[x,y] = meshgrid(1:nlayers, 1:size(toplot, 1));
hStrings = text(x(:), y(:), textStrings(:), 'HorizontalAlignment', 'center');

% colorbar
pos=get(gca,'pos');
colorbar('position',[pos(1)+pos(3)+0.1 pos(2) 0.03 pos(4)]);





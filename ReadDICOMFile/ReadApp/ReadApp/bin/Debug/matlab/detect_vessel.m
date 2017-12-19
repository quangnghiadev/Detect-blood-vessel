function result = detect_vessel()
%% Add necessary paths
addpath(genpath('./data'));
addpath(genpath('./functions'));
%% Demo
acode_main_retin_vessel_seg
result = true;
end
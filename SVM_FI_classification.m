%%% Segmentation should be completed using VAMPIRE. SOFTWARE AVAILABLE UPON DEVELOPERS REQUEST
%% Load the data 
%This model uses features that have been already computed from the images

data_doc = fopen('features_files/features_VAMPIRE_V3_21016_complete.txt'); 

img_data = textscan(data_doc,'%s\t%s\t%s\t%s\n');
fclose(data_doc);

name = string(img_data{1});
wpr = cellfun(@str2num,img_data{2});
lcc =cellfun(@str2num,img_data{3});
ncc = cellfun(@str2num,img_data{4});

parameters = [wpr,lcc,ncc];

%% Load the model and test it


SVMmodel = loadCompactModel('SVM_final_model_trained');

[l,prob] =predict(SVMmodel,parameters);

results = struct();
results.id = name ;
results.classi = num2str(l);

results_table = struct2table(results);


%% Save the results
% 
writetable(results_table, 'classification.txt');
%% Saving the IQS from the classifier


likelihood_results = struct();
likelihood_results.id = name ;
likelihood_results.classi = num2str(prob(:,2));


likelihood_table = struct2table(likelihood_results);
writetable(likelihood_table, 'Quality_score.txt');


%%% Phenotype calculation should be completed using VAMPIRE. SOFTWARE AVAILABLE UPON DEVELOPERS REQUEST

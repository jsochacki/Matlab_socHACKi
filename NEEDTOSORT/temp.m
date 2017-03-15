%%
clear all
%%
lengths = [11, 12.5, 13, 15, 17, 19, 21, 24, 220, 240];
frequencies = (1:1:32);
Times_52091_losses  = [0.233100000000000, 0.258100000000000, 0.266400000000000, ...
           0.299700000000000, 0.333000000000000, 0.366300000000000, ...
           0.399600000000000, 0.449500000000000, 3.71220000000000, ...
           4.04510000000000; ...
           0.335400000000000, 0.371500000000000, 0.383600000000000, ...
           0.431700000000000, 0.479800000000000, 0.528000000000000, ...
           0.576100000000000, 0.648300000000000, 5.36540000000000, ...
           5.84680000000000; ...
           0.416300000000000, 0.461200000000000, 0.476200000000000, ...
           0.536100000000000, 0.596100000000000, 0.656000000000000, ...
           0.716000000000000, 0.805900000000000, 6.67990000000000, ...
           7.27930000000000; ...
           0.486000000000000, 0.538600000000000, 0.556100000000000, ...
           0.626300000000000, 0.696500000000000, 0.766600000000000, ...
           0.836800000000000, 0.942100000000000, 7.81900000000000, ...
           8.52080000000000; ...
           0.548500000000000, 0.608100000000000, 0.627900000000000, ...
           0.707300000000000, 0.786700000000000, 0.866100000000000, ...
           0.945500000000000, 1.06460000000000, 8.84610000000000, ...
           9.64010000000000; ...
           0.606000000000000, 0.672000000000000, 0.693900000000000, ...
           0.781900000000000, 0.869800000000000, 0.957700000000000, ...
           1.04560000000000, 1.17750000000000, 9.79360000000000, ...
           10.6728000000000; ...
           0.659700000000000, 0.731600000000000, 0.755600000000000, ...
           0.851500000000000, 0.947400000000000, 1.04330000000000, ...
           1.13920000000000, 1.28300000000000, 10.6807000000000, ...
           11.6397000000000; ...
           0.710400000000000, 0.787900000000000, 0.813800000000000, ...
           0.917200000000000, 1.02070000000000, 1.12410000000000, ...
           1.22760000000000, 1.38270000000000, 11.5201000000000, ...
           12.5546000000000; ...
           0.758500000000000, 0.841500000000000, 0.869200000000000, ...
           0.979800000000000, 1.09040000000000, 1.20110000000000, ...
           1.31170000000000, 1.47770000000000, 12.3205000000000, ...
           13.4269000000000; ...
           0.804600000000000, 0.892800000000000, 0.922200000000000, ...
           1.03970000000000, 1.15730000000000, 1.27480000000000, ...
           1.39240000000000, 1.56870000000000, 13.0882000000000, ...
           14.2637000000000; ...
           0.848900000000000, 0.942100000000000, 0.973100000000000, ...
           1.09730000000000, 1.22150000000000, 1.34570000000000, ...
           1.47000000000000, 1.65630000000000, 13.8280000000000, ...
           15.0701000000000; ...
           0.891700000000000, 0.989700000000000, 1.02240000000000, ...
           1.15300000000000, 1.28370000000000, 1.41430000000000, ...
           1.54490000000000, 1.74090000000000, 14.5437000000000, ...
           15.8501000000000; ...
           0.933200000000000, 1.03580000000000, 1.07010000000000, ...
           1.20700000000000, 1.34380000000000, 1.48070000000000, ...
           1.61760000000000, 1.82300000000000, 15.2382000000000, ...
           16.6071000000000; ...
           0.973400000000000, 1.08070000000000, 1.11640000000000, ...
           1.25940000000000, 1.40230000000000, 1.54530000000000, ...
           1.68830000000000, 1.90270000000000, 15.9139000000000, ...
           17.3437000000000; ...
           1.01260000000000, 1.12430000000000, 1.16150000000000, ...
           1.31040000000000, 1.45930000000000, 1.60820000000000, ...
           1.75710000000000, 1.98050000000000, 16.5729000000000, ...
           18.0619000000000; ...
           1.05080000000000, 1.16690000000000, 1.20550000000000, ...
           1.36020000000000, 1.51490000000000, 1.66960000000000, ...
           1.82430000000000, 2.05640000000000, 17.2166000000000, ...
           18.7636000000000; ...
           1.08820000000000, 1.20850000000000, 1.24850000000000, ...
           1.40890000000000, 1.56930000000000, 1.72970000000000, ...
           1.89000000000000, 2.13060000000000, 17.8466000000000, ...
           19.4503000000000; ...
           1.12470000000000, 1.24920000000000, 1.29070000000000, ...
           1.45660000000000, 1.62250000000000, 1.78840000000000, ...
           1.95440000000000, 2.20330000000000, 18.4641000000000, ...
           20.1234000000000; ...
           1.16060000000000, 1.28910000000000, 1.33190000000000, ...
           1.50330000000000, 1.67470000000000, 1.84610000000000, ...
           2.01750000000000, 2.27450000000000, 19.0701000000000, ...
           20.7839000000000; ...
           1.19570000000000, 1.32830000000000, 1.37240000000000, ...
           1.54920000000000, 1.72590000000000, 1.90270000000000, ...
           2.07940000000000, 2.34450000000000, 19.6654000000000, ...
           21.4328000000000; ...
           1.23020000000000, 1.36670000000000, 1.41220000000000, ...
           1.59420000000000, 1.77630000000000, 1.95830000000000, ...
           2.14030000000000, 2.41330000000000, 20.2509000000000, ...
           22.0710000000000; ...
           1.26420000000000, 1.40460000000000, 1.45140000000000, ...
           1.63860000000000, 1.82580000000000, 2.01300000000000, ...
           2.20020000000000, 2.48100000000000, 20.8273000000000, ...
           22.6993000000000; ...
           1.29760000000000, 1.44180000000000, 1.48990000000000, ...
           1.68220000000000, 1.87450000000000, 2.06680000000000, ...
           2.25920000000000, 2.54760000000000, 21.3951000000000, ...
           23.3183000000000; ...
           1.33040000000000, 1.47850000000000, 1.52780000000000, ...
           1.72520000000000, 1.92250000000000, 2.11990000000000, ...
           2.31730000000000, 2.61330000000000, 21.9550000000000, ...
           23.9286000000000; ...
           1.36290000000000, 1.51460000000000, 1.56520000000000, ...
           1.76750000000000, 1.96990000000000, 2.17220000000000, ...
           2.37460000000000, 2.67810000000000, 22.5074000000000, ...
           24.5308000000000; ...
           1.39480000000000, 1.55030000000000, 1.60210000000000, ...
           1.80930000000000, 2.01660000000000, 2.22380000000000, ...
           2.43110000000000, 2.74200000000000, 23.0527000000000, ...
           25.1252000000000; ...
           1.42640000000000, 1.58550000000000, 1.63850000000000, ...
           1.85060000000000, 2.06270000000000, 2.27480000000000, ...
           2.48690000000000, 2.80510000000000, 23.5914000000000, ...
           25.7125000000000; ...
           1.45750000000000, 1.62020000000000, 1.67440000000000, ...
           1.89130000000000, 2.10830000000000, 2.32520000000000, ...
           2.54210000000000, 2.86740000000000, 24.1239000000000, ...
           26.2929000000000; ...
           1.48830000000000, 1.65460000000000, 1.71000000000000, ...
           1.93160000000000, 2.15330000000000, 2.37490000000000, ...
           2.59660000000000, 2.92900000000000, 24.6504000000000, ...
           26.8669000000000; ...
           1.51870000000000, 1.68850000000000, 1.74510000000000, ...
           1.97140000000000, 2.19780000000000, 2.42410000000000, ...
           2.65040000000000, 2.98990000000000, 25.1713000000000, ...
           27.4347000000000; ...
           1.54880000000000, 1.72210000000000, 1.77980000000000, ...
           2.01080000000000, 2.24180000000000, 2.47280000000000, ...
           2.70370000000000, 3.05020000000000, 25.6869000000000, ...
           27.9967000000000; ...
           1.57860000000000, 1.75530000000000, 1.81420000000000, ...
           2.04970000000000, 2.28530000000000, 2.52090000000000, ...
           2.75650000000000, 3.10990000000000, 26.1973000000000, ...
           28.5532000000000].';
temperature = 25;
%%
% PT092 = @(length_in_inches) ...
%     round( ( -3e-6 * power(length_in_inches, 2) ) + ...
%            ( 9.34e-2 * length_in_inches ) + (2.645e-1), 1);
% PT092(length)
% plot(length, PT092(length), 'ro', length, PT092(length), 'b-')
% 
% linear_constant = 0.004;
% root_constant = 0.111;
% connector_1_constant = 0.03
% connector_2_constant = 0.03
% 
% physical_constants = [root_constant, ...
%                       linear_constant, ...
%                       connector_1_constant, ...
%                       connector_2_constant];
% 
% frequency = (1:1:40);
% assembly_loss_at_frequencies(frequency, 96, physical_constants)
%%
connector_1_constant = 0.025;
connector_2_constant = 0.025;
%%

[coefficients X]=test_1(Times_52091_losses(1),frequencies);
%%
linear_constant = coefficients(1) ./ (length / 12);
root_constant = ( ...
                    coefficients(2) ...
                    - connector_1_constant ...
                    - connector_2_constant ...
                ) ...
                ./ (length / 12);
linear_constant
root_constant
%%
physical_constants = [root_constant(9), ...
                      linear_constant(9), ...
                      connector_1_constant, ...
                      connector_2_constant];
assembly_loss_at_frequencies(frequency, 220, physical_constants)
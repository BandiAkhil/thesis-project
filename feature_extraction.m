Fs = 1000; %MEG sampling rate

data_folder = uigetdir(pwd);

tic

for fid = 1:36
    finame = [data_folder '/Subjects/' sprintf('subject%02d',fid) '.mat'];
    load(finame);
    fprintf(['Subject' num2str(fid) '\n'])
    tic
    for sig_type = 1:1
        fprintf('.');
        switch sig_type
            case 1
                sig_subset = signal.meg;
            case 2
                sig_subset = signal.planar_x;
            case 3
                sig_subset = signal.planar_y;
            case 4
                sig_subset = signal.vert_meg;
            case 5
                sig_subset = signal.vert_planar_x;
            case 6
                sig_subset = signal.vert_planar_y;
        end
        
        cnt_elec = 0;
        for i=1:size(sig_subset,1) %1-4 --> 117 seconds
            for j=1:size(sig_subset,2) %1-4
                if ~isempty(sig_subset{i,j})
                    cnt_elec = cnt_elec + 1;
                    for trial = 21:24%size(sig_subset{i,j},2) %1-24/36
                        
                        feature{i,j}{1,trial} = [];
                        feature{i,j}{2,trial} = [];
                        feature{i,j}{3,trial} = [];
                        feature{i,j}{4,trial} = [];
                        
                        cnt = 1;
                        win_marker = 1;
                        win_width = Fs*5;
                        win_step = Fs*1;
%                         while win_marker+win_width < length(sig_subset{i,j}{2,trial})
%                             
%                             sig_data = sig_subset{i,j}{2,trial}(win_marker:win_marker+win_width-1); %only for MAIN SONG (Not noise)
% 
%                             window = 1000;
%                             noverlap = 750;
%                             fbin = 2000;
%                             fs = 1000;
%                             [pxx,f] = pwelch(sig_data,window,noverlap,fbin,fs);
% 
%                             theta_range = [find(f>=4,1) find(f>=8,1)];
%                             alpha_range = [find(f>=8,1) find(f>=12,1)];
%                             beta_range = [find(f>=12,1) find(f>=20,1)];
%                             gamma_range = [find(f>=20,1) find(f>=30,1)];
% 
%                             theta_power = mean(log(pxx(theta_range(1):theta_range(2))));
%                             alpha_power = mean(log(pxx(alpha_range(1):alpha_range(2))));
%                             beta_power = mean(log(pxx(beta_range(1):beta_range(2))));
%                             gamma_power = mean(log(pxx(gamma_range(1):gamma_range(2))));
% 
%                             feature{i,j}{1,trial} = [feature{i,j}{1,trial} theta_power];
%                             feature{i,j}{2,trial} = [feature{i,j}{2,trial} alpha_power];
%                             feature{i,j}{3,trial} = [feature{i,j}{3,trial} beta_power];
%                             feature{i,j}{4,trial} = [feature{i,j}{4,trial} gamma_power];
%                             
%                             win_marker = win_marker+win_step;
%                             cnt = cnt+1;
%                         end
                        grand_all_noise_bigset{trial}(:,cnt_elec,fid) = sig_subset{i,j}{2,trial};
                        grand_all_music_bigset{trial}(:,cnt_elec,fid) = sig_subset{i,j}{2,trial};
                    end 
%                     [rho{i,j}(1),pval{i,j}(1)] = corr(feature{i,j}(1,:)',annotation_data.arousal','Type','Spearman');
%                     [rho{i,j}(2),pval{i,j}(2)] = corr(feature{i,j}(2,:)',annotation_data.arousal','Type','Spearman');
%                     [rho{i,j}(3),pval{i,j}(3)] = corr(feature{i,j}(3,:)',annotation_data.arousal','Type','Spearman');
%                     [rho{i,j}(4),pval{i,j}(4)] = corr(feature{i,j}(4,:)',annotation_data.arousal','Type','Spearman');
%                     [rho{i,j}(5),pval{i,j}(5)] = corr(feature{i,j}(1,:)',annotation_data.valence','Type','Spearman');
%                     [rho{i,j}(6),pval{i,j}(6)] = corr(feature{i,j}(2,:)',annotation_data.valence','Type','Spearman');
%                     [rho{i,j}(7),pval{i,j}(7)] = corr(feature{i,j}(3,:)',annotation_data.valence','Type','Spearman');
%                     [rho{i,j}(8),pval{i,j}(8)] = corr(feature{i,j}(4,:)',annotation_data.valence','Type','Spearman');
                end
            end
        end
        feature_indv{fid,sig_type} = feature;
%         rho_indv{fid,sig_type} = rho;
%         pval_indv{fid,sig_type} = pval;
        clearvars feature rho
        toc
    end
    
    toc
    annotation_indv{fid,1} = annotation_data.valence;
    annotation_indv{fid,2} = annotation_data.arousal;
    
    clearvars signal annotation_data
    fprintf('n\n');
end

for trial = 21:24%size(sig_subset{i,j},2) %1-24/36
	grand_all_noise = grand_all_noise_bigset{trial};
	grand_all_music = grand_all_music_bigset{trial};
	save([data_folder '/matlab_for_corrca/' sprintf('noise_trial%02d',trial) '.mat'],'grand_all_noise','-v7.3');
	save([data_folder '/matlab_for_corrca/' sprintf('music_trial%02d',trial) '.mat'],'grand_all_music','-v7.3');
end
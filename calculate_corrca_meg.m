data_folder = uigetdir(pwd);

% epoch = 1;
% win_marker = 1;
% win_my_step = 5000;
% top = 3;
% top_three_mean = zeros(24, 9);
% pvhaTrials = [1, 5, 9, 13, 17, 21];
% pvlaTrials = [2, 6, 10, 14, 18, 22];
% nvlaTrials = [3, 7, 11, 15, 19, 23];
% nvhaTrials = [4, 8, 12, 16, 20, 24];
% 
% for trial = nvhaTrials
%     tic
%     fprintf(['trial' num2str(trial) '\n'])
%     while epoch < 10
%         fprintf(['epoch' num2str(epoch) '\n'])
% %         load([data_folder '/matlab_for_corrca/' sprintf('noise_trial%02d',trial) '.mat']);
% %         [W1,ISC1,~,A1]=corrca(grand_all_noise(win_marker:win_my_step, :, :));
% %         results_noise{1,epoch} = W1;
% %         results_noise{2,epoch} = ISC1;
% %         results_noise{4,epoch} = A1;
%         clearvars W1 ISC1 Y1 A1
%         load([data_folder '/matlab_for_corrca/' sprintf('music_trial%02d',trial) '.mat']);
%         [W2,ISC2,~,A2]=corrca(grand_all_music(win_marker:win_my_step, :, :));
%         results_music{1,epoch} = ISC2;
%         top_three_mean(trial, epoch) = mean(results_music{1,epoch}(1:top),1);
%         win_marker = win_my_step + 1;
%         win_my_step = win_my_step + win_width;
%         if win_my_step > size(grand_all_music, 1)
%             win_my_step = size(grand_all_music, 1);
%         end
%         epoch = epoch + 1;
%     end
%     hold on;
%     plot(1:9, top_three_mean(trial, :), '-o', 'DisplayName', ['Trial ' num2str(trial)])
%     xlim([0 10])
%     ylim([0 0.16])
%     title('Averaged ISC among subjects during songs classified as negative-valence-high-arousal');
%     xlabel('Epoch number'); ylabel('Averaged ISC');
%     epoch = 1;
%     win_marker = 1;
%     win_my_step = 5000;
%     toc
% end


for trial = 1:24
    fprintf(['trial' num2str(trial) '\n'])
    tic
%     load([data_folder '/matlab_for_corrca/' sprintf('noise_trial%02d',trial) '.mat']);
%     [W1,ISC1,~,A1]=c(grand_all_noise);
%     results_noise{1,trial} = W1;
%     results_noise{2,trial} = ISC1;
%     %results_noise{3,trial} = Y1;
%     results_noise{4,trial} = A1;
%     clearvars W1 ISC1 Y1 A1
    load([data_folder '/matlab_for_corrca/' sprintf('music_trial%02d',trial) '.mat']);
    [W2,ISC2,~,A2]=corrca(grand_all_music);
%     results_music{1,trial} = W2;
    results_music{1,trial} = ISC2;
    %results_music{3,trial} = Y2;
%     results_music{4,trial} = A2;
    clearvars W2 ISC2 Y2 A2
    toc
end











music_ISC = cell2mat(results_music(1,:));
% noise_ISC = cell2mat(results_noise(2,:));
% based_song_num = [1,5,9,13,17,21];
% mean_music_isc(:,1) = mean(music_ISC(:,based_song_num),2);
% mean_music_isc(:,2) = mean(music_ISC(:,based_song_num+1),2);
% mean_music_isc(:,3) = mean(music_ISC(:,based_song_num+2),2);
% mean_music_isc(:,4) = mean(music_ISC(:,based_song_num+3),2);
% std_music_isc(:,1) = std(music_ISC(:,based_song_num),[],2);
% std_music_isc(:,2) = std(music_ISC(:,based_song_num+1),[],2);
% std_music_isc(:,3) = std(music_ISC(:,based_song_num+2),[],2);
% std_music_isc(:,4) = std(music_ISC(:,based_song_num+3),[],2);
% 
% top = 1;
% top_three_mean = mean((mean_music_isc(1:top,:)),1);
% top_three_std  = mean((std_music_isc(1:top,:)),1);
% figure; 
% bar(1:4,top_three_mean);
% xticklabels({'HA-HV','LA-HV','LA-LV','HA-LV'});
% ylabel('Averaged ISC');
% ylim([0 0.10])
% hold on
% er = errorbar(1:4,top_three_mean,top_three_std,top_three_std);
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';
% title('Top 1 components');
 
top = 3;
top_three_mean = mean(music_ISC(1:top,:),1);
fprintf(num2str(top_three_mean));
load('annotation_corrected.mat');

% bar(top_three_mean);
% title('Trial 1: Averaged ISC among subjects during nine 5 second epochs');
% xlabel('Epoch number'); ylabel('Averaged ISC');

% subplot(121);
% ann = mean(annotation_arousal,1);
% scatter(top_three_mean,ann);
% %[cc,pval] = corrcoef(top_three_mean,ann);
% [cc_spear,pval] = corr(top_three_mean',ann','Type','Spearman');
% p = polyfit(top_three_mean,ann,1);%This will generate the coefficients of polynomial of degree(1)
% ann_fit = polyval(p,top_three_mean);% This will give the fitted  values for the desired values.
% hold on;
% plot(top_three_mean,ann_fit,'k-');
% %title(['Arousal: r = ' num2str(cc(1,2)) ' p = ' num2str(pval(1,2))]);
% title(['Arousal: r = ' num2str(cc_spear) ', p = ' num2str(pval)]);
% xlabel('Averaged ISC'); ylabel('Annotation score');
% 
% subplot(122);
% ann = mean(annotation_valence,1);
% scatter(top_three_mean,ann);
% %[cc,pval] = corrcoef(top_three_mean,ann);
% [cc_spear,pval] = corr(top_three_mean',ann','Type','Spearman');
% p = polyfit(top_three_mean,ann,1);%This will generate the coefficients of polynomial of degree(1)
% ann_fit = polyval(p,top_three_mean);% This will give the fitted  values for the desired values.
% hold on;
% plot(top_three_mean,ann_fit,'k-');
% %title(['Valence: r = ' num2str(cc(1,2)) ' p = ' num2str(pval(1,2))]);
% title(['Valence: r = ' num2str(cc_spear) ', p = ' num2str(pval)]);
% xlabel('Averaged ISC'); ylabel('Annotation score');

figure;
ann = std(annotation_arousal,1);
scatter(top_three_mean,ann);
[cc_spear,pval] = corr(top_three_mean',ann','Type','Spearman');
p = polyfit(top_three_mean,ann,1);%This will generate the coefficients of polynomial of degree(1)
ann_fit = polyval(p,top_three_mean);% This will give the fitted  values for the desired values.
hold on;
plot(top_three_mean, ann_fit,'k-');
title(['Correlation between ISC and standard Deviation of arousal scores: r = ' num2str(cc_spear) ', p = ' num2str(pval)]);
xlabel('Averaged ISC'); ylabel('Standard Deviation of arousal annotation scores');
 
figure;
ann = std(annotation_valence,1);
scatter(top_three_mean,ann);
[cc_spear,pval] = corr(top_three_mean',ann','Type','Spearman');
p = polyfit(top_three_mean,ann,1);%This will generate the coefficients of polynomial of degree(1)
ann_fit = polyval(p,top_three_mean);% This will give the fitted  values for the desired values.
hold on;
plot(top_three_mean, ann_fit,'k-');
title(['Correlation between ISC and standard Deviation of valence scores: r = ' num2str(cc_spear) ', p = ' num2str(pval)]);
xlabel('Averaged ISC'); ylabel('Standard Deviation of valence annotation scores');
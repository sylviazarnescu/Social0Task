% data = ImportedSocialInfiniteBandit2020S
SocialData = cellfun(@(x)ImportedSocialInfiniteBandit2020S.(x),{'subjectID', 'reward','choice', 'rexploit', 'rexplore', 'version', 'horizon'},'UniformOutput',false);
SocialData = table((SocialData{:}));
SocialData.Properties.VariableNames ([1 2 3 4 5 6 7]) = {'subject','reward','choice', 'rexploit', 'rexplore', 'version', 'horizon'};
%%
SocialData = ImportedSocialInfiniteBandit2020S;
%SOLO GAMES 
SocialData(SocialData.version == 'pc',:) = [];
SocialData(SocialData.version == 'coop',:) = [];
SocialData = removevars(SocialData,{'horizon'});
%%
%determining horizon

rexploitnew = max([SocialData.rexploit, SocialData.reward]')';
SocialData.isconsistent = [0; rexploitnew(1:end-1) == SocialData.rexploit(2:end)];

SocialData.lapsetime = [NaN; SocialData.timestamp_BanditOn(2:end) - SocialData.timestamp_UpdateGameFinish(1:end-1)];

row0 = [find(SocialData.isconsistent == 0 | (SocialData.lapsetime > 1.5 & SocialData.lapsetime < 2.5)); height(SocialData)+1];
horizon = diff(row0);
hs = arrayfun(@(x) ones(x,1)*x, horizon, 'UniformOutput', false);
hs = vertcat(hs{:});
SocialData.horizon = hs;
%%
currenthorizon = SocialData.horizon(1);
SocialData.horizonNow(1) = SocialData.horizon(1);
i = 2;
while i <= height(SocialData)
    if SocialData.horizon(i) == currenthorizon && SocialData.filename(i)==SocialData.filename(i-1) 
%             if SocialData.horizon(i) == currenthorizon && SocialData.lapsetime(i) >= 1.9
        SocialData.horizonNow(i) = SocialData.horizonNow(i-1) - 1;
        if SocialData.horizonNow(i) == 0
            SocialData.horizonNow(i) = currenthorizon;
        end
    else 
        SocialData.horizonNow(i) = SocialData.horizon(i);
        currenthorizon = SocialData.horizon(i);
    end
    i = i + 1;
end
%%
SocialData(SocialData.horizon == 6,:) = [];
SocialData(SocialData.horizon == 4,:) = [];
SocialData(SocialData.horizon == 2,:) = [];

bin_edges = [0: 10: 100];
subs = unique(SocialData.subjectID);
horizons = [1:1:7];
%%
horizons = [1 3 5 7]
thres = []; noise = [];
for si = 1:length(subs)
    for i = 1:length(horizons)
        horizonsi = horizons(i);
        for horizonNow = horizonsi:-1:1
            ttab = SocialData(SocialData.horizon == horizonsi & SocialData.horizonNow == horizonNow & SocialData.subjectID == subs(si), :);
            rexploit = ttab.rexploit;
            choice = ttab.choice == 1;
            [thres(si,i,horizonNow), noise(si,i,horizonNow)] = getMLEfit(choice, rexploit);
        end
    end
end

av_thres_solo = squeeze(mean(thres,1));
ste_thres_solo = squeeze(std(thres,1))./sqrt(length(subs));

%%
clear pchoice_solo

    for si = 1:length(subs)
        ttab = SocialData(SocialData.subjectID == subs(si),:);
        for hi = 1:length(horizons_sub)
            htab = ttab(ttab.horizonNow == horizons_sub(hi),:);
           for bi = 1:length(bin_edges) -1
               tchoice = htab(htab.rexploit > bin_edges(bi)&htab.rexploit <= bin_edges(bi+1),:).choice;
               tchoice = tchoice(~isnan(tchoice));
               pchoice_solo{hi}(si, bi) = mean(tchoice == 2);
           end
        end
    end

for hi = 1:length(horizons_sub)
    
    ave_choice_solo(hi,:) = nanmean(pchoice_solo{hi});
    sterror_choice_solo(hi,:) = nanstd(pchoice_solo{hi})./sqrt(sum(~isnan(pchoice_solo{hi})));
   
end
%%

clear pchoice_solo

for si = 1:length(subs)
    ttab = SocialData(SocialData.subjectID == subs(si),:);
    for hi = 1:length(horizons)
        htab = ttab(ttab.horizon == horizons(hi),:);
        for ni = 1:length(horizons_sub)
            ntab = htab(htab.horizonNow == horizons_sub(ni),:);
            for bi = 1:length(bin_edges) -1
                tchoice = htab(htab.rexploit > bin_edges(bi)&htab.rexploit <= bin_edges(bi+1),:).choice;
                tchoice = tchoice(~isnan(tchoice));
                pchoice_solo{hi}(si, bi) = mean(tchoice == 2);
            end
        end
    end
end


    %%
for hi = 1:length(horizons_sub)
    
    ave_choice_solo(hi,:) = nanmean(pchoice_solo{hi});
    sterror_choice_solo(hi,:) = nanstd(pchoice_solo{hi})./sqrt(sum(~isnan(pchoice_solo{hi})));
   
end
%%
% 
for i = 1:length(horizons_sub)
    figure
   
errorbar(5:10:95, ave_choice_solo(i,:), sterror_choice_solo(i,:))
% legend('horizon 1', 'horizon 2','horizon 3','horizon 4', 'horizon 5', 'horizon 6','horizon 7')
xlabel('Exploit Value'), ylabel('Percentage of Exploration')
title('Solo Condition')
% hold on
% subplot([1:1:7])
end

% legend('horizon 1', 'horizon 2','horizon 3','horizon 4', 'horizon 5', 'horizon 6','horizon 7')
% xlabel('Exploit Value'), ylabel('Percentage of Exploration')
% title('Solo Condition')


%%
figure(1)
for i = 1:length(horizons)
errorbar(5:10:95, ave_choice_solo(i,:), sterror_choice_solo(i,:))
hold on
end
legend('horizon 1', 'horizon 3', 'horizon 5', 'horizon 7')
xlabel('Exploit Value'), ylabel('Percentage of Exploration')
title('Solo Condition')

%%






%%
%PC GAMES
SocialData = ImportedSocialInfiniteBandit2020S;
%computer games only
SocialData(SocialData.version == 'solo',:) = [];
SocialData(SocialData.version == 'coop',:) = [];
SocialData = removevars(SocialData,{'horizon'});

%determining horizon

rexploitnew = max([SocialData.rexploit, SocialData.reward]')';
SocialData.isconsistent = [0; rexploitnew(1:end-1) == SocialData.rexploit(2:end)];

SocialData.lapsetime = [NaN; SocialData.timestamp_BanditOn(2:end) - SocialData.timestamp_UpdateGameFinish(1:end-1)];

row0 = [find(SocialData.isconsistent == 0 | (SocialData.lapsetime > 1.5 & SocialData.lapsetime < 2.5)); height(SocialData)+1];
horizon = diff(row0);
hs = arrayfun(@(x) ones(x,1)*x, horizon, 'UniformOutput', false);
hs = vertcat(hs{:});
SocialData.horizon = hs;
%%
%h = 6
SocialData.horizon(SocialData.horizon == 6) = 7;
SocialData.horizon([37, 77, 157, 313, 758]) = 7;

%h = 4

SocialData.horizon([41:45, 871:875, 1189:1193, 1350:1354, 1391:1395]) = 5;
SocialData.horizon([57:63, 327:333, 451:457]) = 7;

%h=2

SocialData.horizon([64:66, 85:87, 338:340, 350:352, 370:372, 382:384, 399:401, 448:450, 460:462, 477:479, 528:530, 684:686, 792:794, 810:812, 822:824, 889:891, 968:970, 997:999, 1047:1049, 1128:1130, 1236:1238, 1289:1291, 1301:1303, 1318:1320, 1380:1382]) = 3;
SocialData.horizon([107:111, 354:358, 402:406, 419:423, 480:484, 497:501, 629:633, 859:863, 938:942, 1017:1021, 1070:1074, 1096:1100, 1160:1164, 1177:1181, 1338:1342]) = 5;
SocialData.horizon([116:122, 163:169, 274:280, 359:365, 437:443, 517:523, 799:805, 957:963, 1117:1123]) = 7;

SocialData(SocialData.horizon == 4,:) = [];
SocialData(SocialData.horizon == 2,:) = [];
%%
currenthorizon = SocialData.horizon(1);
SocialData.horizonNow(1) = SocialData.horizon(1);
i = 2;
while i <= height(SocialData)
    if SocialData.horizon(i) == currenthorizon && SocialData.filename(i)==SocialData.filename(i-1) 
%             if SocialData.horizon(i) == currenthorizon && SocialData.lapsetime(i) >= 1.9
        SocialData.horizonNow(i) = SocialData.horizonNow(i-1) - 1;
        if SocialData.horizonNow(i) == 0
            SocialData.horizonNow(i) = currenthorizon;
        end
    else 
        SocialData.horizonNow(i) = SocialData.horizon(i);
        currenthorizon = SocialData.horizon(i);
    end
    i = i + 1;
end

%%

horizons = [1 3 5 7]
thres = []; noise = [];
for si = 1:length(subs)
    for i = 1:length(horizons)
        horizonsi = horizons(i);
        for horizonNow = horizonsi:-1:1
            ttab = SocialData(SocialData.horizon == horizonsi & SocialData.horizonNow == horizonNow & SocialData.subjectID == subs(si), :);
            rexploit = ttab.rexploit;
            choice = ttab.choice == 1;
            [thres(si,i,horizonNow), noise(si,i,horizonNow)] = getMLEfit(choice, rexploit);
        end
    end
end

av_thres_comp = squeeze(mean(thres,1));
ste_thres_comp = squeeze(std(thres,1))./sqrt(length(subs));


%%

bin_edges = [0: 10: 100]
subs = unique(SocialData.subjectID);
horizons = [1 3 5 7];
order = unique(SocialData.choiceorder);
partner_choice = unique(SocialData.choice);


clear pchoice_comp

    for si = 1:length(subs)
        ttab = SocialData(SocialData.subjectID == subs(si),:);
        for hi = 1:length(horizons)
            htab = ttab(ttab.horizonNow == horizons(hi),:);
           for bi = 1:length(bin_edges) -1
               tchoice = htab(htab.rexploit > bin_edges(bi)&htab.rexploit <= bin_edges(bi+1),:).choice;
               tchoice = tchoice(~isnan(tchoice));
               pchoice_comp{hi}(si, bi) = mean(tchoice == 2);
           end
        end
    end

for hi = 1:length(horizons)
    
    ave_choice_comp(hi,:) = nanmean(pchoice_comp{hi});
    sterror_choice_comp(hi,:) = nanstd(pchoice_comp{hi})./sqrt(sum(~isnan(pchoice_comp{hi})));
   
end
%%

clear pchoice_comp

for si = 1:length(subs)
    ttab = SocialData(SocialData.subjectID == subs(si),:);
    for hi = 1:length(horizons)
        htab = ttab(ttab.horizon == horizons(hi),:);
        for ni = 1:length(horizons_sub)
            ntab = htab(htab.horizonNow == horizons_sub(ni),:);
            for bi = 1:length(bin_edges) -1
                tchoice = htab(htab.rexploit > bin_edges(bi)&htab.rexploit <= bin_edges(bi+1),:).choice
                tchoice = tchoice(~isnan(tchoice))
                pchoice_comp{hi}(si, bi) = mean(tchoice == 2)
            end
        end
    end
end

for hi = 1:length(horizons)
    
    ave_choice_comp(hi,:) = nanmean(pchoice_comp{hi});
    sterror_choice_comp(hi,:) = nanstd(pchoice_comp{hi})./sqrt(sum(~isnan(pchoice_comp{hi})));
   
end
%%
figure(2)
for i = 1:length(horizons)
errorbar(5:10:95, ave_choice_comp(i,:), sterror_choice_comp(i,:))
hold on
end
legend('horizon 1', 'horizon 3', 'horizon 5', 'horizon 7')
xlabel('Exploit Value'), ylabel('Percentage of Exploration')
title('Computer Condition')




%%
% seperate choice conditions > partner choice
clear pchoice_pc

for si = 1:length(subs)
    ttab = SocialData(SocialData.subjectID == subs(si),:);
    for hi = 1:length(horizons)
        htab = ttab(ttab.horizon == horizons(hi),:);
        for oi = 1:length(order)
            otab = htab(htab.choiceorder == order(oi),:);
            if otab.choiceorder == 2
                for ci = 1:length(partner_choice)
                    if ci == 1
                        
                    else ci == 2
                        
                    if otab.choiceorder == 1
                        
                        for bi = 1:length(bin_edges) -1
                            tchoice = otab(otab.rexploit > bin_edges(bi)&otab.rexploit <= bin_edges(bi+1),:).choice;
                            tchoice = tchoice(~isnan(tchoice));
                            pchoice_pc{hi}(si, bi) = mean(tchoice == 2);
                        end
                    end
                    end
                end
            end
        end
    end
end


%%
%each choice condition per each horizon
for hi = 1:3
    
    ave_choice_pc(hi,:) = nanmean(pchoice_pc{hi});
    sterror_choice_pc(hi,:) = nanstd(pchoice_pc{hi})./sqrt(sum(~isnan(pchoice_pc{hi})));
   
end
%%
%each horizon

for hi = 1:length(horizons)
    
    ave_choice_solo(hi,:) = nanmean(pchoice_solo{hi});
    sterror_choice_solo(hi,:) = nanstd(pchoice_solo{hi})./sqrt(sum(~isnan(pchoice_solo{hi})));
   
end

%%
figure(2)
for i = 1:length(horizons)
errorbar(5:10:95, ave_choice_pc(i,:), sterror_choice_pc(i,:))
hold on
end
% legend('horizon 1', 'horizon 3', 'horizon 5', 'horizon 7')
xlabel('Exploit Value'), ylabel('Percentage of Exploration')
%%





%%
%COOP GAMES

SocialData = ImportedSocialInfiniteBandit2020S;
%computer games only
SocialData(SocialData.version == 'solo',:) = [];
SocialData(SocialData.version == 'pc',:) = [];
SocialData = removevars(SocialData,{'horizon'});



rexploitnew = max([SocialData.rexploit, SocialData.reward]')';
SocialData.isconsistent = [0; rexploitnew(1:end-1) == SocialData.rexploit(2:end)];

SocialData.lapsetime = [NaN; SocialData.timestamp_BanditOn(2:end) - SocialData.timestamp_UpdateGameFinish(1:end-1)];
%%

row0 = [find(SocialData.isconsistent == 0 | (SocialData.lapsetime > 1.5 & SocialData.lapsetime < 2.5)); height(SocialData)+1];
horizon = diff(row0);
hs = arrayfun(@(x) ones(x,1)*x, horizon, 'UniformOutput', false);
hs = vertcat(hs{:});
SocialData.horizon = hs;

%%
%h = 6
SocialData.horizon(SocialData.horizon == 6) = 7;
SocialData.horizon([98, 129]) = 7;

%h = 4
SocialData.horizon([124:128, 223:227, 584:588]) = 5;

SocialData.horizon([188:194,  454:460, 473:479, 571:577]) = 7;

%h = 2
SocialData.horizon([272:274, 465:467]) = 3;

SocialData.horizon([34:38, 75:79, 119:123, 170:174, 311:315, 331:335, 401:405, 468:472]) = 5;

SocialData.horizon([518:524]) = 7;

SocialData(SocialData.horizon == 4,:) = [];
SocialData(SocialData.horizon == 2,:) = [];
%%

currenthorizon = SocialData.horizon(1);
SocialData.horizonNow(1) = SocialData.horizon(1);
i = 2;
while i <= height(SocialData)
    if SocialData.horizon(i) == currenthorizon && SocialData.filename(i)==SocialData.filename(i-1) 
%             if SocialData.horizon(i) == currenthorizon && SocialData.lapsetime(i) >= 1.9
        SocialData.horizonNow(i) = SocialData.horizonNow(i-1) - 1;
        if SocialData.horizonNow(i) == 0
            SocialData.horizonNow(i) = currenthorizon;
        end
    else 
        SocialData.horizonNow(i) = SocialData.horizon(i);
        currenthorizon = SocialData.horizon(i);
    end
    i = i + 1;
end
%%
order = unique(SocialData.choiceorder);
partner_choice = unique(SocialData.choice);
% horizons = [1 3 5 7]
thres = []; noise = [];
for si = 1:length(subs)
    for i = 1:length(horizons)
        horizonsi = horizons(i);
        for horizonNow = horizonsi:-1:1
            ttab = SocialData(SocialData.horizon == horizonsi & SocialData.horizonNow == horizonNow & SocialData.subjectID == subs(si), :);
            if ttab.choiceorder == 1
                rexploit = ttab.rexploit;
                choice = ttab.choice == 1;
                [thres(si,i,horizonNow), noise(si,i,horizonNow)] = getMLEfit(choice, rexploit);
            end
        end
    end
end

av_thres_partner = squeeze(mean(thres,1));
ste_thres_partner = squeeze(std(thres,1))./sqrt(length(subs));
%%

thres = []; noise = [];
for si = 1:length(subs)
    for i = 1:length(horizons)
        horizonsi = horizons(i);
        for horizonNow = horizonsi:-1:1
            ttab = SocialData(SocialData.horizon == horizonsi & SocialData.horizonNow == horizonNow & SocialData.subjectID == subs(si), :);
            if ttab.choiceorder == 2
                rexploit = ttab.rexploit;
                choice = ttab.choice == 1;
                [thres(si,i,horizonNow), noise(si,i,horizonNow)] = getMLEfit(choice, rexploit);
            end
        end
    end
end

av_thres_partner = squeeze(mean(thres,1));
ste_thres_partner = squeeze(std(thres,1))./sqrt(length(subs));

%%
bin_edges = [0: 10: 100]
subs = unique(SocialData.subjectID);
horizons = [1 3 5 7];

%%
clear pchoice_partner

    for si = 1:length(subs)
        ttab = SocialData(SocialData.subjectID == subs(si),:);
        for hi = 1:length(horizons_sub)
            htab = ttab(ttab.horizonNow == horizons_sub(hi),:);
           for bi = 1:length(bin_edges) -1
               tchoice = htab(htab.rexploit > bin_edges(bi)&htab.rexploit <= bin_edges(bi+1),:).choice;
               tchoice = tchoice(~isnan(tchoice));
               pchoice_partner{hi}(si, bi) = mean(tchoice == 2);
           end
        end
    end

for hi = 1:length(horizons_sub)
    
    ave_choice_partner(hi,:) = nanmean(pchoice_partner{hi});
    sterror_choice_partner(hi,:) = nanstd(pchoice_partner{hi})./sqrt(sum(~isnan(pchoice_partner{hi})));
   
end
%%

clear pchoice_partner

for si = 1:length(subs)
    ttab = SocialData(SocialData.subjectID == subs(si),:);
    for hi = 1:length(horizons)
        htab = ttab(ttab.horizon == horizons(hi),:);
        for ni = 1:length(horizons_sub)
            ntab = htab(htab.horizonNow == horizons_sub(ni),:);
            for bi = 1:length(bin_edges) -1
                tchoice = htab(htab.rexploit > bin_edges(bi)&htab.rexploit <= bin_edges(bi+1),:).choice
                tchoice = tchoice(~isnan(tchoice))
                pchoice_partner{hi}(si, bi) = mean(tchoice == 2)
            end
        end
    end
end

for hi = 1:length(horizons)
    
    ave_choice_partner(hi,:) = nanmean(pchoice_partner{hi});
    sterror_choice_partner(hi,:) = nanstd(pchoice_partner{hi})./sqrt(sum(~isnan(pchoice_partner{hi})));
   
end
%%

for i = 1:length(horizons_sub)
    figure
errorbar(5:10:95, ave_choice_partner(i,:), sterror_choice_partner(i,:))
% hold on
end
legend('horizon 1', 'horizon 3', 'horizon 5', 'horizon 7')
xlabel('Exploit Value'), ylabel('Percentage of Exploration')
title('Partner Condition')





%%
%choice differentiation
clear pchoice_coop

for si = 1:length(subs)
    ttab = SocialData(SocialData.subjectID == subs(si),:);
    for hi = 1:length(horizons)
        htab = ttab(ttab.horizon == horizons(hi),:);
        if htab.choice == 1
            
            for bi = 1:length(bin_edges) -1
                tchoice = htab(htab.rexploit > bin_edges(bi)&htab.rexploit <= bin_edges(bi+1),:).choice;
                tchoice = tchoice(~isnan(tchoice));
                pchoice_coop{hi}(si, bi) = mean(tchoice == 2);
            end
        end
    end
end

    %%
    
for hi = 1:length(horizons)
    
    ave_choice_coop(hi,:) = nanmean(pchoice_coop{hi});
    sterror_choice_coop(hi,:) = nanstd(pchoice_coop{hi})./sqrt(sum(~isnan(pchoice_coop{hi})));
   
end
%%
figure(3)
for i = 1:length(horizons)
errorbar(5:10:95, ave_choice_coop(i,:), sterror_choice_coop(i,:))
hold on
end
legend('horizon 1', 'horizon 3', 'horizon 5', 'horizon 7')
xlabel('Exploit Value'), ylabel('Percentage of Exploration')



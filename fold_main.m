clear
clc
close all

load('D:\lee\(test)올인원미터\학습데이터\allin_total_learning')

Raw=allin_total_learning;

Raw.data(find(Raw.data(:,2000)>10000),2:2240)=Raw.data(find(Raw.data(:,2000)>10000),2:2240)-10000;

shit_id=find(Raw.data(:,2240)==0);
shit_id=[shit_id [7897 13596 29634 31451 31452 34431]];
Raw.data(shit_id,:)=[];
Raw.ysi(shit_id)=[];
Raw.int(shit_id)=[];
Raw.glu(shit_id)=[];
Raw.hct(shit_id)=[];
Raw.ch(shit_id)=[];
%% 
% idx=find(Raw.ysi<140);
% 
% Raw.data=[Raw.data;Raw.data(idx,:);Raw.data(idx,:)];
% Raw.ysi=[Raw.ysi;Raw.ysi(idx);Raw.ysi(idx)];
% Raw.int=[Raw.int;Raw.int(idx);Raw.int(idx)];
% Raw.glu=[Raw.glu;Raw.glu(idx);Raw.glu(idx)];
% Raw.hct=[Raw.hct;Raw.hct(idx);Raw.hct(idx)];
% Raw.ch=[Raw.ch;Raw.ch(idx);Raw.ch(idx)];

tep=Raw.data(:,2586);
%% Fold 나누기, 'kfold_result.mat'로 결과 저장했음
% load('kfold_result')

fold=zeros(length(Raw.ysi),1);

for i=1:max(Raw.int)
    for j=1:10
        idx=find(Raw.int==i&Raw.ch==j);
        
        fold(idx)=j;
    end
end
    

%%
for i=1:length(Raw.ysi)
    X(i,:)=feature_making(Raw.data(i,:)');
end

for i=1:size(X,2)
    x2(:,i)=X(:,i).*tep;
    x3(:,i)=X(:,i).*tep.^2;
    x4(:,i)=X(:,i)./tep;
end

X=[X x2 x3 x4];
fnum=[30:1:240];
for fn=1:length(fnum)
    %% K-fold 시작
    for gg=1:10

        idx=find(fold~=gg);
        idx2=find(fold==gg);
        Xd=X(idx,:);
        y0=Raw.ysi(idx);
        y=Raw.ysi(idx);

        % step 1 - mean centering
        mx=mean(Xd);
        X0=Xd-repmat(mx,size(Xd,1),1);
        XX=X0;
        my=mean(y0);

        for i=1:fnum(fn)
            % step 2 - loading weight
            w=X0'*y0/sqrt((y0'*X0*X0'*y0));

            % step 3 - scoring
            t0=X0*w;

            % step 4 - spectral loading
            p0=(X0'*t0)/(t0'*t0);

            % step 5 - chemical loading
            q0=(y0'*t0)/(t0'*t0);

            % step 6 - updating
            X1=X0-t0*p0';
            y1=y0-t0*q0;

            % step 7 - while
            W(:,i)=w;
            P(:,i)=p0;
            Q(i,:)=q0;

            X0=X1;
            y0=y1;
        end

        % step 8 - 
        b=W*inv(P'*W)*Q;
        b0=my-(mx*b);

        % b=w*inv(p0'*w)*q0;
        % b0=my-(mx*b);

        yfit=b0+X(idx2,:)*b;

        [h,n_perc1, n_perc2, n_perc3(gg), rmsb(gg), m_bias]=ISO_accuracy_test(Raw.ysi(idx2),yfit,0)
        
%         h_b(1,gg)=b;
%         hb0(1,gg)=b0;
    end
    disp(num2str(fn))
%     f_b(fn,:)=h_b;
%     f_b0(fn,:)=hb0;
    m_rmsb(fn)=mean(rmsb);
    m_per(fn)=mean(n_perc3);
    
end

figure
plot(m_rmsb)


figure
plot(m_per)
function [h,n_perc1, n_perc2, n_perc3, rmse, m_bias]=ISO_accuracy_test(ysi,algo,Disp_opt)

biasab=algo-ysi;
biasfer=(algo-ysi)./ysi.*100;

bias=biasab;
bias(find(ysi>100))=biasfer(find(ysi>100));

m_bias=round(mean(abs(bias)).*100)/100;
% rmse=round(rms(biasab)*100)/100;
rmse=round(rms(bias)*100)/100;

total=length(ysi);
count15=length(find(bias<15&bias>-15));
count10=length(find(bias<10&bias>-10));
count5=length(find(bias<5&bias>-5));

n_perc2=count10/total*100;
n_perc3=count15/total*100;
n_perc1=count5/total*100;

if Disp_opt==1
    h=figure; hold on;
    plot([0 700],[0 0],'k--');
    plot([1 100],[15 15],'k');
    plot(100:700,(100:700)*0.15,'k'); %+15% accuracy guide line
    plot([1 100],-[15 15],'k');
    plot(100:700,-(100:700)*0.15,'k'); %-15% accuracy guide line
    plot(ysi,biasab,'ko','markersize',2,'markerfacecolor','k','linewidth',1.5);
    set(gca,'fontweight','bold','FontSize',12,'fontname','Arial');
    xlabel('YSI (mg/dL)'); ylabel('Difference from YSI (mg/dL)');

    textcolor={'r','b'}; % PASS: BLUE, FAIL: RED
    text(30,120,['¡¾ 5%: ' num2str(count5) '/' num2str(total) ' (' num2str(n_perc1,3) ' %)'],'fontweight','bold','FontSize',12,'color',textcolor{(n_perc1>=99)+1});
    text(30,105,['¡¾ 10%: ' num2str(count10) '/' num2str(total) ' (' num2str(n_perc2,3) ' %)'],'fontweight','bold','FontSize',12,'color',textcolor{(n_perc2>=95)+1});
    text(30,90,['¡¾ 15%: ' num2str(count15) '/' num2str(total) ' (' num2str(n_perc3,3) ' %)'],'fontweight','bold','FontSize',12,'color',textcolor{(n_perc3>=95)+1});
    text(30,-75,['RMSB: ' num2str(rmse) ' (mg/dL or %)'],'fontweight','bold','FontSize',12,'color',textcolor{2});
    text(30,-95,['Bias: ' num2str(m_bias) ' (mg/dL or %)'],'fontweight','bold','FontSize',12,'color',textcolor{2});
    ylim([-200 200])


%     toPPT(h)
    %toPPT(h,'Height',315,'Width',404)
else
    h=0;
end


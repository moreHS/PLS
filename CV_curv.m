function curv=CV_curv(data,peak,vally)
        nch = (data(peak-1:2:vally-1,:) + data(peak:2:vally,:))./2;  % µÎ pointÀÇ Æò±Õ°ª
        ns2 = size(nch,1); ns1 = 1;
        CC = ns2 - ns1;
        for i=1:size(nch,2)
            B1(:,i) = nch(ns1:ns2,i) - nch(ns2,i); % 5th °î·ü
        end
        for i=1:size(nch,2)
            B2(:,i) = B1(:,i) ./ (nch(ns1,i) - nch(ns2,i));
        end
        for i=1:size(nch,2)
            B3(:,i) = [CC:-1:0]./CC;
        end
        B4 = abs(B3-B2);
        curv=sum(B4)+1;
end
        
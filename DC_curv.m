function B7=DC_curv(data,peak,adc)
    CC = adc - peak;
    B3 = [CC:-1:0]'/CC;
    for i=1:size(data,2)
        B5(1,i) = sum(B3);
    end
    B6 = (sum(data(peak:adc,:)) - (CC+1).*data(adc,:))./(data(peak,:)-data(adc,:));
    B7 = B5 - B6;
end
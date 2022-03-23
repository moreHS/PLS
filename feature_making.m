function fea=feature_making(data)

[temp,wi]=max(data(1200:1500));
fea(1)=temp(1);

fea(2)=mean(data(1991:2000));

fea(3)=data(2011);
fea(4)=data(2031);
fea(5)=data(2051);
fea(6)=data(2071);
fea(7)=data(2091);
fea(8)=data(2111);
fea(9)=data(2131);
fea(10)=data(2151);
fea(11)=data(2171);
fea(12)=data(2191);
fea(13)=data(2211);
fea(14)=data(2231);
fea(15)=data(2240);

%% 곡률
fea(16)=DC_curv(data,wi(end),2000);

fea(17)=CV_curv(data,2011,2031);
fea(18)=CV_curv(data,2031,2051);
fea(19)=CV_curv(data,2051,2071);
fea(20)=CV_curv(data,2071,2091);
fea(21)=CV_curv(data,2091,2111);
fea(22)=CV_curv(data,2111,2131);
fea(23)=CV_curv(data,2131,2151);
fea(24)=CV_curv(data,2151,2171);
fea(25)=CV_curv(data,2191,2211);
fea(26)=CV_curv(data,2231,2240);

%% 추가 조합 피쳐
% dc피크/5adc
fea(27)=fea(1)/fea(2);
% fea(32)=fea(10)/fea(11);
% cv 꼭지/5adc
fea(28)=fea(3)/fea(2);
fea(29)=fea(4)/fea(2);
fea(30)=fea(5)/fea(2);
fea(31)=fea(6)/fea(2);
fea(32)=fea(7)/fea(2);
fea(33)=fea(8)/fea(2);
fea(34)=fea(9)/fea(2);
fea(35)=fea(10)/fea(2);
fea(36)=fea(11)/fea(2);
fea(37)=fea(12)/fea(2);
fea(38)=fea(13)/fea(2);
fea(39)=fea(14)/fea(2);
fea(40)=fea(15)/fea(2);

% cv 포인트 차이
fea(41)=fea(3)-fea(4);
fea(42)=fea(5)-fea(6);
fea(43)=fea(7)-fea(8);
fea(44)=fea(9)-fea(10);
fea(45)=fea(11)-fea(12);
fea(46)=fea(13)-fea(14);

% 면적
fea(47)=sum(data(1201:2000))/800;

fea(48)=sum(data(2011:2031))/20;
fea(49)=sum(data(2031:2051))/20;
fea(50)=sum(data(2051:2071))/20;
fea(51)=sum(data(2071:2091))/20;
fea(52)=sum(data(2091:2111))/20;
fea(53)=sum(data(2111:2131))/20;
fea(54)=sum(data(2131:2151))/20;
fea(55)=sum(data(2151:2171))/20;
fea(56)=sum(data(2171:2191))/20;
fea(57)=sum(data(2191:2211))/20;
fea(58)=sum(data(2211:2231))/20;
fea(59)=sum(data(2231:2240))/10;
% 면적/5adc

fea(60)=fea(47)/fea(2);
fea(61)=fea(48)/fea(2);
fea(62)=fea(49)/fea(2);
fea(63)=fea(50)/fea(2);
fea(64)=fea(51)/fea(2);
fea(65)=fea(52)/fea(2);
fea(66)=fea(53)/fea(2);
fea(67)=fea(54)/fea(2);
fea(68)=fea(55)/fea(2);
fea(69)=fea(56)/fea(2);
fea(70)=fea(57)/fea(2);
fea(71)=fea(58)/fea(2);
fea(72)=fea(59)/fea(2);

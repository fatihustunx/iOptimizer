function Verileri_Oku( )

global VERI
% VERI.Veri_Seti=[2,4;3,6;3,4;4,10;5,8;6,3;7,9;9,7;11,7;10,2];
% VERI.Veri_Siniflari={'KÖTÜ','ÝYÝ','ÝYÝ','KÖTÜ','KÖTÜ','ÝYÝ','ÝYÝ','KÖTÜ','KÖTÜ','KÖTÜ'};
% VERI.Yeni_Veri=[8,4];

egitim_data=readtable('Data_User_Modeling_Dataset.xls','sheet','Training_Data','range','A:F');

VERI.Veri_Seti=egitim_data(:,1:5);
VERI.Veri_Seti=table2array(VERI.Veri_Seti);
VERI.Veri_Siniflari=egitim_data(:,6);
YourArray = table2array(VERI.Veri_Siniflari);
VERI.Veri_Siniflari = YourArray.';

test_data=readtable('Data_User_Modeling_Dataset.xls','sheet','Test_Data','range','A:F');

VERI.Yeni_Veri=test_data(:,1:5);
VERI.Yeni_Veri=table2array(VERI.Yeni_Veri);
VERI.Yeni_Veri_Siniflari=test_data(:,6);
YourArray = table2array(VERI.Yeni_Veri_Siniflari);
VERI.Yeni_Veri_Siniflari = YourArray.';

%VERI.Yeni_Veri=[0.05,0.05,0.55,0.6,0.14];
%VERI.Yeni_Veri_Label='Low';
end


function[error]=k_nn(weights)

global VERI;
global komsu;

komsu_sayisi=3;
uzaklik_bagintisi_no=1;

Verileri_Oku();

toplam=0;
loss=0;

for i=1:length(VERI.Yeni_Veri)
        uzaklik_dizisi=Uzaklik_Hesapla(uzaklik_bagintisi_no,VERI.Veri_Seti,VERI.Yeni_Veri(i,:),weights);
        [komsu]=Komsu_Bul(komsu_sayisi,uzaklik_dizisi,VERI.Veri_Siniflari);
        [sinif]=Sinif_Bul();
        
        %mesaj='KLASÝK k-NN YÖNTEMÝNE GÖRE SINIF TAHMÝNÝ';
        %Yazdir(mesaj,sinif);

        %[sinif_2]=Sinif_Bul_Agirlikli_Oylama();
        %mesaj='AÐIRLIKLI OYLAMA YÖNTEMÝNE GÖRE SINIF TAHMÝNÝ';
        %Yazdir(mesaj,sinif_2);

        if ~strcmp(sinif.sinif,VERI.Yeni_Veri_Siniflari(i))
            loss=loss+1;
        end
        toplam=toplam+1;
end

error=loss/toplam;
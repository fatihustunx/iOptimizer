
function [komsu]= Komsu_Bul( komsu_sayisi,uzaklik_dizisi,veri_siniflari)

[en_kucukler,indeksleri]=sort(uzaklik_dizisi);

for i=1:komsu_sayisi
    komsu(i).sinif=veri_siniflari(indeksleri(i));
    komsu(i).indeks=indeksleri(i);
    komsu(i).uzaklik=uzaklik_dizisi(indeksleri(i));
    komsu(i).adet=0;   % i. kom�unun s�n�fndan ka� adet var
    komsu(i).ters_uzaklik=0; % a��rl�kl� oylamada ihtiya� duyulan de�er
end

end


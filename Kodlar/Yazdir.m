function Yazdir(mesaj,etiket )
disp(mesaj);
global komsu;
    for i=1:length(komsu)
        fprintf('%d. kom�u bilgileri\n',i);
        komsu_bilgileri=[' s�n�f�: ',komsu(i).sinif,' indeksi: ',komsu(i).indeks,'uzakl���:',komsu(i).uzaklik,'ters uzakl���:',komsu(i).ters_uzaklik];
        disp(komsu_bilgileri);
    end
  
disp('sonu� itibariyle verinin ait oldu�u s�n�f ve di�er bilgiler');
disp(etiket)

end


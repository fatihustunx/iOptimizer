function Yazdir(mesaj,etiket )
disp(mesaj);
global komsu;
    for i=1:length(komsu)
        fprintf('%d. komþu bilgileri\n',i);
        komsu_bilgileri=[' sýnýfý: ',komsu(i).sinif,' indeksi: ',komsu(i).indeks,'uzaklýðý:',komsu(i).uzaklik,'ters uzaklýðý:',komsu(i).ters_uzaklik];
        disp(komsu_bilgileri);
    end
  
disp('sonuç itibariyle verinin ait olduðu sýnýf ve diðer bilgiler');
disp(etiket)

end


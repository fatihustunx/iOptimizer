function [ uzaklik_dizisi ] = Baginti_Oklit( veri_seti,yeni_veri,weights)
[ornek_sayisi,ozellik_sayisi]=size(veri_seti);
%uzaklik_dizisi

for i=1:ornek_sayisi
toplam=0;
    for j=1:ozellik_sayisi
        
        %if weights(j)<0.2
          %    weights(j)=0;
        %end
        
        toplam=toplam + weights(j) * (veri_seti(i,j)-yeni_veri(1,j))^2;

    end
        uzaklik_dizisi(i)=sqrt(toplam);
end

end


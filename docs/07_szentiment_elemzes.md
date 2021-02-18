# Szótáralapú elemzések, érzelem-elemzés

A szótár alapú szentiment elemzés egy egyszerű ötleten alapul. Hogyha tudjuk hogy egyes szavak milyen érzelmeket, érzéseket, információt hordoznak, akkor minél gyakoribb egy-egy érzelem kategóriához tartozó szó, akkor a szentiment annél inkább jellemző lesz a dokumentumra amit vizsgálunk. Természetesen itt is jó pár dolognak kell teljesülnie ahhoz hogy az elemzésünk eredménye megbízható legyen. Mivel a szótár alapú elemzés az adott szentiment kategórián belüli kulcsszavak gyakoriságán alapul, ezért van aki nem tekinti statisztikai elemzésnek (lásd például (@young2012affective ). A tágabb kvantitatív szövegelemzési kontextusban az osztályozáson (classification) belül a felügyelt módszerekhez hasonlóan itt is ismert kategóriákkal dolgozunk (pl.: egy kulcsszó az "öröm" kategóriába tartozik), csak egyszerűbb módszertannal (@grimmer2013text).

A kulcsszavakra építés miatt a módszer a kvalitatív és kvantitatív kutatási vonalak találkozásának is tekinthető, hiszen egy-egy szónak az érzelmi töltete nem mindig ítélhető meg objektíven. Mint minden módszer esetében, amiről ebben a tankönyvben szó van, itt is kiemelten fontos hogy ellenőrízzük hogy a használt szótár kategóriák és kulcsszavak fedik-e a valóságot. Más szavakkal: *validate, validate, validate*. **A módszer előnyei:**

-   Tökéletesen megbízható: nincsen probabilisztikus eleme a számításoknak, mint például a Support Vector alapú osztályozásnál, illetve az emberi szövegkódolásnál előforduló problémákat is elkerüljük így.
-   Képesek vagyunk vele mérni a szöveg látens dimenzióit.
-   Széles körben alkalmazható, egyszerűen számolható. A politikatudományon és számítogépes nyelvtudományokon belül nagyon sok kész szótár elérhető, amik különböző módszerekkel készültek és különböző területet fednek le (pl.: populizmus, pártprogramok policy tartalma, érzelmek, gazdasági tartalom.)[^szentiment_elemzes-1]
-   Relatíve könnyen adaptálható egyik nyelvi környezetből másikba.

[^szentiment_elemzes-1]: A lehetséges, területspecifikus szótáralkotási módszerekről részletesebben ezekben a cikkekben lehet olvasni: @laver2000estimating; @young2012affective; @loughran2011; @máté2021

**A módszer lehetéges hátrányai:**

-   A szótár hatékonysága és validitása azon múlik hogy mennyire egyezik a szótár és a viszgálni kívánt dokumentum területe. Például jellemző hiba, hogy gazdasági bizonytalanságot szeretnék tőzsdei jelentések alapján vizsgálni a kutatók egy általános szentimet szótár használatával.
-   A terület-specifikus szótár építése egy kvalitatív folyamat (lsd. a labjegyzetben), éppen ezért gyakran idő és emberi erőforrás igényes.
-   A szózsák alapú elemzéseknél a kontextus elvész (ez gyakran igaz a bigram és trigramok használatánál is) a kulcsszavak esetében. Erre egy triviális példa a tagadás a mondatban: *"nem vagyok boldog"* esetén egy általános szentiment szótár a tagadás miatt félreosztályozná a mondat érzelmi töltését.

Az elemzés sikere több faktortól is függ. Fontos hogy a korpuszban lévő dokumentumokat körültekintően tisztítsuk meg az elemzés elején (lásd a 3. fejezetet a szövegelőkészítésről). A következő lépésben meg kell bizonyosodnunk arról, hogy a kiválasztott szentiment szótár alkalmazható a korpuszunkra. Amennyiben nem találunk alkalmas szótárat, akkor a saját szótár validálására kell figyelni. A negyedik fejezetben leírtak itt is érvényesek, érdemes a dokumentum-kifejezés mátrixot súlyozni valamilyen módon.

## Szótárak az R-ben

A szótár alapú elemzéshez a `quanteda` csomagot fogjuk használni.[^szentiment_elemzes-2] + tobbi package

[^szentiment_elemzes-2]: A szentiment elemzéshez gyakran használt csomag még a tidytext. Az online is szabadon elérhető @silge2017text 2. fejezetében részletesen is bemutatják a szerzők a tidytext munkafolyamatot (<https://www.tidytextmining.com/sentiment.html>).


```r
library(readr)
library(stringr)
library(dplyr)
library(quanteda)
```

Mielőtt a két esettanulmányt bemutatnánk, vizsgáljuk meg hogy hogyan néz ki egy szentiment szótár az R-ben. A szótárt kézzel úgy tudjuk létrehozni, hogy egy listán belül létrehozzuk karaktervektorként a kategóriákat és a kulcsszavakat és ezt a listát a quanteda dictionary függvényével eltároljuk.


```r
szentiment_szotar <- dictionary(list(
  pozitiv = c("jó", "boldog", "öröm"),
  negativ = c("rossz", "szomorú", "lehangoló")
))

szentiment_szotar
#> Dictionary object with 2 key entries.
#> - [pozitiv]:
#>   - jó, boldog, öröm
#> - [negativ]:
#>   - rossz, szomorú, lehangoló
```

A quanteda, quanteda.corpora és tidytext R csomagok több széles körben használt szentiment szótárat tartalmaznak, így nem kell kézzel replikálni minden egyes szótárat amit használni szeretnénk.

A szentiment elemzési munkafolyamat amit a részfejezetben bemutatunk a következő lépésekből áll:

1.  dokumentumok betöltése
2.  szöveg előkészítése
3.  a korpusz létrehozása
4.  dokumentum-kifejezés mátrix
5.  szótár betöltése
6.  a dokumentum-kifejezés mátrix szűrése a szótárban lévő kulcsszavakkal
7.  az eredmény vizualizálása, további felhasználása

A fejezetben két különböző korpuszt fogunk elemezni: a 2006-os Magyar Nemzet címlapjainak egy 252 cikkből álló mintájának szentimentjét vizsgáljuk egy magyar szentiment szótárral. A második korpusz a Magyar Nemzeti Bank angol nyelvű sajtóközleményeiből áll, amin bemutatjuk egy széles körben használt gazdasági szótár használatát.

### Magyar Nemzet cikkek

A `read_csv()` segítségével beolvassuk a Magyar Nemzet adatbázist, ami a 2006-os cimlapokon szereplő hírek random mintája (napi egy cikk). A glimpse(), ahogy a neve is mutatja, egy gyors áttekinténtést nyújt a betöltött adatbázisról. Látjuk, hogy 252 sorbol (megfigyelés) és 3 oszlopból (változó) áll. Az első ránézésre látszik hogy a text változónk tartalmazza a szövegeket, és hogy tisztításra szorulnak.


```r
mn_minta <- read_csv("data/magyar_nemzet_small.csv")


glimpse(mn_minta)
#> Rows: 252
#> Columns: 3
#> $ doc_id   <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,...
#> $ text     <chr> "Moszkva elzárta a gázcsapot\nNegyedével csökkent a hazánk...
#> $ doc_date <date> 2006-01-02, 2006-01-03, 2006-01-04, 2006-01-05, 2006-01-0...
```

Az első szöveget megnézve látjuk, hogy a standard előkészítési lépések mellett a sortörést (\\n) is ki kell törölnünk.


```r
mn_minta$text[1]
#> [1] "Moszkva elzárta a gázcsapot\nNegyedével csökkent a hazánkba érkezo földgáz mennyisége\nA Gazprom tegnap elzárta az\nUkrajnának szánt gáz csapjait.\nUgyanakkor az ukrán gázszol­\ngáltató vállalat, a Naftogaz je­\nlezte, korlátozások lehetnek az\nEurópába irányuló szállítások­\nban. A Mól tájékoztatása sze­\nrint a hazánkba érkezo gáz\nmennyisége 25 százalékkal\ncsökkent. Az óév utolsó órái­\nban Moszkva még egy, a piaci\nár bevezetésének negyedéves\nhalasztását tartalmazó ajánla­\ntot tett a vita megoldására, Ki-\njev azonban ezt - moszkvai ér­\ntelmezés szerint - elutasította.\nJámbor Gyui.a____________\nM ár ma is elrendelhetik a leg­\nnagyobb, az óránként 2500 \nköbméternél több földgázt fogyasz­\ntó ipari, illetve mezogazdasági ter­\nmelok felhasználásának korlátozá­\nsát - mondta el lapunknak Ferencz\nI. Szabolcs, a Mol-csoport kommu­\nnikációs igazgatója. Lapzártánkkor \nugyanis még nem lehetett tudni, \nhogy átmeneti nyomáscsökkenés­\nrol van-e szó, vagy tartósan fenn­\nmarad az a helyzet, hogy az Orosz­\nországból Ukrajnán keresztül érke­\nzo gázvezetékek 25 százalékkal ke­\nvesebb gázt szállítanak hazánkba, \nmint a szerzodésben eloírt mennyi­\nség. A Mól szakembere azt sem \ntudta megmondani, hogy az orosz\npartner döntése vagy az ukrán fél \ntevékenysége nyomán érkezik ke­\nvesebb gáz hazánkba. A Gazprom \nbejelentette, Ukrajna veszi el jogel­\nlenesen a nyugati országokba, köz­\ntük hazánkba érkezo földgázt.\nÚjév reggelén - miután a szom­\nszéd ország elutasította a drasztikus\náremelési követelést -  a Gazprom \nelzárta a gázcsapokat. Ukrajna ed­\ndig ezer köbméterenként 50 dollá­\nrért kapta az orosz gázt, a drágulás­\nban legfeljebb 80 dollárt tart elfo­\ngadhatónak 2006-ban, még az „eu­\nrópai árképzés” Ukrajnára alkalma­\nzott módszerével is. A Gazprom\ncsaknem ötszörös árat, 230 dollárt \nkövetel. Ukrán részrol tegnap dél­\nután már megerosítették, csökken a \ngáznyomás az ország vezetékrend­\nszerében, hozzátéve, a fogyasztókat \negyelore mindez nem érinti.\n[M o s z k v a . . . ] \nFolytatás és iegyzet a 10. oldalon >\nAz orosz-ukrán árvita zavart okozhat az európai energiapiacon is"
```

Habár a quanteda is lehetőséget ad néhány elékészítő lépésre, érdemes ezt olyan céleszközzel tenni ami nagyobb rugalmasságot ad a kezünkbe. Mi erre a célra a stringr csomagot használjuk. Első lépésben kitöröljük a sortöréseket (\\n), a központozást, számokat, kisbetűsítünk minden szót. Előfordulhat hogy (számunkra nehezen látható) extra szóközök maradnak a szövegben. Ezeket az str_squish()-el tüntetjük el. A szöveg eleji és végi extra szóközöket (ún. leading vagy trailing white space) az str_trim() vágja le.


```r
mn_tiszta <- mn_minta %>%
  mutate(
    text = str_remove_all(string = text, pattern = "\n"),
    text = str_remove_all(string = text, pattern = "[:punct:]"),
    text = str_remove_all(string = text, pattern = "[:digit:]"),
    text = str_to_lower(text),
    text = str_trim(text),
    text = str_squish(text)
    )
```

A szöveg sokkal jobban néz ki, habár észrevehetjük hogy maradtak benne problémás részek, főleg a sortörés miatt, ami sajnos hol egyes szavak közepén van (a jobbik eset), vagy pedig pont szóhatáron, ez esetben a két szó sajnos összevonódik. Az egyszerűség kedvéért feltételezzük hogy ez kellően ritkán fordul elő ahhoz hogy ne befolyásolja az elemzésünk eredményét.


```r
mn_tiszta$text[1]
#> [1] "moszkva elzárta a gázcsapotnegyedével csökkent a hazánkba érkezo földgáz mennyiségea gazprom tegnap elzárta azukrajnának szánt gáz csapjaitugyanakkor az ukrán gázszol­gáltató vállalat a naftogaz je­lezte korlátozások lehetnek azeurópába irányuló szállítások­ban a mól tájékoztatása sze­rint a hazánkba érkezo gázmennyisége százalékkalcsökkent az óév utolsó órái­ban moszkva még egy a piaciár bevezetésének negyedéveshalasztását tartalmazó ajánla­tot tett a vita megoldására kijev azonban ezt moszkvai ér­telmezés szerint elutasítottajámbor gyuiam ár ma is elrendelhetik a leg­nagyobb az óránként köbméternél több földgázt fogyasz­tó ipari illetve mezogazdasági ter­melok felhasználásának korlátozá­sát mondta el lapunknak ferenczi szabolcs a molcsoport kommu­nikációs igazgatója lapzártánkkor ugyanis még nem lehetett tudni hogy átmeneti nyomáscsökkenés­rol vane szó vagy tartósan fenn­marad az a helyzet hogy az orosz­országból ukrajnán keresztül érke­zo gázvezetékek százalékkal ke­vesebb gázt szállítanak hazánkba mint a szerzodésben eloírt mennyi­ség a mól szakembere azt sem tudta megmondani hogy az oroszpartner döntése vagy az ukrán fél tevékenysége nyomán érkezik ke­vesebb gáz hazánkba a gazprom bejelentette ukrajna veszi el jogel­lenesen a nyugati országokba köz­tük hazánkba érkezo földgáztújév reggelén miután a szom­széd ország elutasította a drasztikusáremelési követelést a gazprom elzárta a gázcsapokat ukrajna ed­dig ezer köbméterenként dollá­rért kapta az orosz gázt a drágulás­ban legfeljebb dollárt tart elfo­gadhatónak ban még az eu­rópai árképzés ukrajnára alkalma­zott módszerével is a gazpromcsaknem ötszörös árat dollárt követel ukrán részrol tegnap dél­után már megerosítették csökken a gáznyomás az ország vezetékrend­szerében hozzátéve a fogyasztókat egyelore mindez nem érintim o s z k v a folytatás és iegyzet a oldalon >az oroszukrán árvita zavart okozhat az európai energiapiacon is"
```

Miután kész a tiszta(bb) szövegünk, kreálunk egy korpuszt a quanteda corpus() fuggvenyevel.

docvars a datum


```r
mn_corpus <- corpus(mn_tiszta)

head(docvars(mn_corpus), 5)
#>     doc_date
#> 1 2006-01-02
#> 2 2006-01-03
#> 3 2006-01-04
#> 4 2006-01-05
#> 5 2006-01-06
```


```r
mn_dfm <- mn_corpus %>% 
  tokens(what = "word") %>% 
  dfm() %>% 
  dfm_tfidf()
```

a dictionary




```r
poltext_szotar
#> Dictionary object with 2 key entries.
#> - [positive]:
#>   - abszolút, ad, adaptív, adekvát, adócsökkentés, adókedvezmény, adomány, adományoz, adóreform, adottság, adottságú, áfacsökkentés, agilis, agytröszt, áhított, ajándék, ajándékoz, ajánl, ajánlott, akadálytalan [ ... and 2,279 more ]
#> - [negative]:
#>   - aberrált, abnormális, abnormalitás, abszurd, abszurditás, ádáz, adócsalás, adócsaló, adós, adósság, áfacsalás, áfacsaló, affér, aggasztó, aggodalom, aggódik, aggódás, agresszió, agresszíven, agresszivitás [ ... and 2,568 more ]
```

lookup


```r
mn_szentiment <- dfm_lookup(mn_dfm, dictionary = poltext_szotar)

mn_szentiment
#> Document-feature matrix of: 252 documents, 2 features (34.5% sparse) and 1 docvar.
#>     features
#> docs   positive  negative
#>    1  0.7781513 10.927821
#>    2 12.6302520  2.401401
#>    3  3.1795518  8.526421
#>    4  2.1003705  6.602142
#>    5  4.9466373  4.802801
#>    6  0          2.401401
#> [ reached max_ndoc ... 246 more documents ]
```

add net back to docvars


```r

docvars(mn_corpus, "net_sentiment") <- as.numeric(mn_szentiment[, 1]) - as.numeric(mn_szentiment[, 2])
docvars(mn_corpus, "pos") <- as.numeric(mn_szentiment[, 1])
docvars(mn_corpus, "neg") <- as.numeric(mn_szentiment[, 2])

head(docvars(mn_corpus), 5)
#>     doc_date net_sentiment        pos       neg
#> 1 2006-01-02   -10.1496702  0.7781513 10.927821
#> 2 2006-01-03    10.2288515 12.6302520  2.401401
#> 3 2006-01-04    -5.3468691  3.1795518  8.526421
#> 4 2006-01-05    -4.5017711  2.1003705  6.602142
#> 5 2006-01-06     0.1438362  4.9466373  4.802801
```

do a df and then ggplot


```r
mn_df <- convert(mn_corpus, to = "data.frame")


glimpse(mn_df)
#> Rows: 252
#> Columns: 6
#> $ doc_id        <chr> "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1...
#> $ text          <chr> "moszkva elzárta a gázcsapotnegyedével csökkent a haz...
#> $ doc_date      <date> 2006-01-02, 2006-01-03, 2006-01-04, 2006-01-05, 2006...
#> $ net_sentiment <dbl> -10.1496702, 10.2288515, -5.3468691, -4.5017711, 0.14...
#> $ pos           <dbl> 0.7781513, 12.6302520, 3.1795518, 2.1003705, 4.946637...
#> $ neg           <dbl> 10.927821, 2.401401, 8.526421, 6.602142, 4.802801, 2....
```


```r
library(ggplot2)
```


```r
ggplot(mn_df, aes(doc_date, net_sentiment)) +
  geom_line() +
  labs(
    title = "Magyar Nemzet címlap szentimentje",
    subtitle = "A szentiment érték a pozitív és negatív szentiment pontszámok különbsége a teljes mintára.",
    y = "Szentiment",
    x = NULL,
    caption = "Adatforrás: https://cap.tk.hu/"
  )
```

<img src="07_szentiment_elemzes_files/figure-html/unnamed-chunk-15-1.png" width="90%" style="display: block; margin: auto;" />

kotextualis lookup: kormany, eu, rendorseg


```r
eu <- c("európai unió", "európa*", "unió*", "brüsszel*", "strasbourg*")

mn_eu_tokens <- tokens(mn_corpus) %>% 
  tokens_keep(pattern = phrase(eu), window = 5)


mn_eu_szentiment <- tokens_lookup(mn_eu_tokens, dictionary = poltext_szotar) %>% 
  dfm() %>% 
  dfm_tfidf()


docvars(mn_corpus, "eu_sentiment") <- as.numeric(mn_eu_szentiment[, 1]) - as.numeric(mn_eu_szentiment[, 2])

mn_eu_df <- convert(mn_corpus, to = "data.frame")
```


```r
ggplot(mn_eu_df, aes(doc_date, eu_sentiment)) +
  geom_line() +
  labs(
    title = "Magyar Nemzet címlap EU-hoz kapcsolódó szentimentje",
    subtitle = "A szentiment érték a pozitív és negatív szentiment pontszámok különbsége a teljes mintára.",
    y = "Szentiment",
    x = NULL,
    caption = "Adatforrás: https://cap.tk.hu/"
  ) 
```

<img src="07_szentiment_elemzes_files/figure-html/unnamed-chunk-17-1.png" width="90%" style="display: block; margin: auto;" />

### MNB sajtóközlemények

Angol nyelvu korpusz + specialis dictionary

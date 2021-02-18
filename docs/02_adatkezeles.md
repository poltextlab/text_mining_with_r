# Az adatkezelés R-ben

## Adatok importálása és exportálása


```r
library(readr)
```


Az adatok importálására az R alapfüggvénye mellett több package is megoldást kínál. Ezek közül a könyv írásakor a legnépszerűbbek a `readr` és a `rio` csomagok. A karakter kódolással a legjobban a tapasztalataink szerint a `readr` csomag `read_csv()` megoldása bíkózik meg, ezért ezt fogjuk használni a `.csv` állományok beolvasására. Amennyiben kihasználjuk az RStudio projekt opcióját (lásd a [Függelékben](#projektmunka)) akkor elegendő csak az elérni kívánt adatok relativ elérési útját megadni (relative path). Ideális esetben az adataink egy csv fileban vannak (comma separated values), ahol az egyes értékeket vesszők (vagy egyéb speciális karakter) választják el. Ez esetben a `read_delim()` függvényt használjuk. A beolvasásnál egyből el is tároljuk az adatokat egy objektumban. A `sep =` opcióval tudjuk a szeparátor karaktert beállítani, mert előfordulhat hogy vessző helyett pontosvessző tagolja az adatainkat.


```r
df <- read_csv("data/adatfile.csv")
```

Az R képes linkről letölteni fileokat, elég megadnunk egy működő elérési útvonalat.

**placeholder link, cserelni majd mukodore**


```r
df_online <- read.csv("https://www.qta.tk.mta.hu/adatok/adatfile.csv")
```

Az R package ökoszisztémája kellően változatos ahhoz, hogy gyakorlatilag bármilyen inputtal meg tudjon bírkózni. Az Excel fileokat a `readxl` csomagot használva tudjuk betölteni (a csomagok installálásával kapcsolatban lásd a [Függeléket](#packages)), a `read_excel()`-t használva. A leggyakoribb statisztikai programok formátumait pedig a `haven` csomag tudja kezelni (például Stata, Spss, SAS). A szintaxis itt is hasonló: `read_stata`, `read_spss`, `read_sas`.

### Szöveges dokumentumok importálása

A nagy mennyiségű szöveges dokumentum (a legyakrabban előforduló kiterjesztések: `.txt`, `.doc`, `.pdf`, `.json`, `.csv`, `.xml`, `.rtf`, `.odt`) betöltésére a legalkalmasabb a `readtext` package. Az alábbi példa azt mutatja be, hogy hogyan tudunk beolvasni egy adott mappából az összes .txt kiterjesztésű file-t, anélkül hogy bármilyen loop-ot kellene írnunk, vagy egyenként megadni a file-ok neveit. A `*` karakter az azt jelenti ebben a környezetben, hogy bármilyen fájl, ami .txt-re végződik. Amennyiben a fájlok nevei tartalmaznak valamilyen meta adatot tartalmaznak, akkor ezt be tudjuk allítani a betöltés során. Ilyen meta adat lehet például egy parlamenti felszólalásnál a felszólaló neve és a beszéd ideje és párttagsága (például: `kovacsjanos_1994_fkgp.txt`).


```r
df_text <- readtext(
  "data/*.txt", 
  docvarsfrom = "filenames", 
  dvsep = "_",
  docvarnames = c("nev", "ev", "part")
  )
```

## Adatok exportálása

Az adatainkat R-ből a `write.csv()`-vel exportálhatjuk a kívánt helyre, `.csv` formátumban. Az R rendelkezik saját, .Rds és .Rda kiterjesztésű, tömörített fájlformátummal. Mivel ezeket csak az R-ben nyithatjuk meg, érdemes a köztes, hosszadalmas számítást igénylő lépések elmentésére használni, a `saveRDS()` és a `save()` parancsokkal. Az `openxlsx` csomaggal `.xls` és `.xlsx` Excel formátumokba is tudunk exportálni, hogyha szükséges.

## A pipe operátor

Az úgynevezett *pipe* operátor alapjaiban határozta meg a modern R fejlődését és a népszerű package ökoszisztéma, a *tidyverse*, egyik alapköve. Úgy gondoljuk, hogy a *tidyverse* és a *pipe* egyszerűbbé teszi elsajátítani az R használatát, ezért mi is erre helyezzük a hangsúlyt.[^adatkezeles-1] Vizuálisan a pipe operátor így néz ki: `%>%` és arra szolgál hogy a kódban több egymáshoz kapcsolódó műveletet egybefűzzűnk.[^adatkezeles-2] Technikailag a pipe a bal oldali elemet adja meg a jobb oldali függvény első argumentumának. A lenti példa ugyanazt a folyamatot írja le, az alap R (*base R*) illetve a pipe használatával.[^adatkezeles-3] Miközben a kódot olvassuk érdemes a pipe-ot "*és aztán*"-nak fordítani.

[^adatkezeles-1]: A *tidyverse* megközelítés miatt a kötetben szereplő R kód követi a "The tidyverse style guide" dokumentációt (<https://style.tidyverse.org/>)

[^adatkezeles-2]: Az RStudio-ban a pipe operátor billentyű kombinációja a `Ctrl + Shift + M`

[^adatkezeles-3]: Köszönjük Andrew Heissnek a kitűnő példát.


```r
reggeli(oltozkodes(felkeles(ebredes(en, idopont = "8:00"), oldal = "jobb"), nadrag = TRUE, ing = TRUE))

en %>% 
  ebredes(idopont = "8:00") %>% 
  felkeles(oldal = "jobb") %>% 
  oltozkodes(nadrag = TRUE, ing = TRUE) %>% 
  reggeli()
```

A fenti példa is jól mutatja, hogy a pipe a bal oldali elemet fogja a jobb oldali függvény első elemének berakni. A fejezet további részeiben még bőven fogunk gyakorlati példát találni a használatára. A fejezetben bemutatott példák az alkalmazásoknak csak egy relatíve szűk körét mutatják be, ezért érdemes átolvasni a csomagokhoz tartozó dokumentációt, illetve ha van, akkor a működést demonstráló bemutató oldalakat is.

## Muveletek a date framekkel

A data frame az egyik leghasznosabb és leggyakrabban használt adat tárolási mód az R-ben (a részletesebb leírás a [Függelékben](#data-frame) található) és ebben az alfejezetben azt mutatjuk be a `dplyr` és `gapminder` csomagok segíségével, hogy hogyan lehet hatékonyan dolgozni velük. A `dplyr` az egyik legnépszerűbb R csomag, a *tidyverse* része. A `gapminder` csomag pedig a példa adatbázisunkat tartalmazza, amiben a világ országainak különböző gazdasági és társadalmi mutatói vannak.


```r
library(dplyr)
library(gapminder)
```

### Megfigyelések szűrése: `filter()`

A sorok (megfigyelések) szűréséhez a `dplyr` csomag `filter()` parancsát használva lehetőségünk van arra hogy egy vagy több kritérium alapján szűkítsük az adatbázisunkat. A lenti példában azokat megfigyeléseket tartjuk meg, ahol az év 1962 és a várható élettartam nagyobb mint 72 év.


```r
gapminder %>%
  filter(year == 1962, lifeExp > 72)
#> # A tibble: 5 x 6
#>   country     continent  year lifeExp      pop gdpPercap
#>   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
#> 1 Denmark     Europe     1962    72.4  4646899    13583.
#> 2 Iceland     Europe     1962    73.7   182053    10350.
#> 3 Netherlands Europe     1962    73.2 11805689    12791.
#> 4 Norway      Europe     1962    73.5  3638919    13450.
#> 5 Sweden      Europe     1962    73.4  7561588    12329.
```

De ugyanígy leválogathatjuk a data frame-ből az adatokat akkor is hogyha egy karakter változó alapján szeretnénk szűrni.


```r
gapminder %>%
  filter(country == "Sweden", year > 1990)
#> # A tibble: 4 x 6
#>   country continent  year lifeExp     pop gdpPercap
#>   <fct>   <fct>     <int>   <dbl>   <int>     <dbl>
#> 1 Sweden  Europe     1992    78.2 8718867    23880.
#> 2 Sweden  Europe     1997    79.4 8897619    25267.
#> 3 Sweden  Europe     2002    80.0 8954175    29342.
#> 4 Sweden  Europe     2007    80.9 9031088    33860.
```

Itt tehát a data frame azon sorait szeretnénk látni, ahol az ország megegyezik a „Sweden" karakterlánccal az év pedig nagyobb, mint 1990.

### Változók kiválogatása: `select()`

A `select()` függvény segítségével válogathatunk oszlopokat a data frame-ből. A változók kiválasztására több megoldás is van. A `dplyr` csomag tartalmaz apróbb kisegítő függvényeket, amik megkönnyítik a nagy adatbázisok esetén a változók kiválogatását a nevük alapján. Ezek a függvények a `contains()`, `starts_with()`, `ends_with()`, `matches()` és beszédesen arra szolgálnak hogy bizonyos nevű változókat ne kelljen egyenként felsorolni. A `select()`-en belüli változó sorrend egyben az eredmény data frame változó sorrendjet is megadja. A negatív kiválasztás is lehetséges, ebben az esetben egy `-` kell tennünk a nemkívánt változó(k) elé (pl.: `select(df, year, country, -continent`).


```r
gapminder %>% 
  select(contains("ea"), starts_with("co"), pop)
#> # A tibble: 1,704 x 4
#>     year country     continent      pop
#>    <int> <fct>       <fct>        <int>
#>  1  1952 Afghanistan Asia       8425333
#>  2  1957 Afghanistan Asia       9240934
#>  3  1962 Afghanistan Asia      10267083
#>  4  1967 Afghanistan Asia      11537966
#>  5  1972 Afghanistan Asia      13079460
#>  6  1977 Afghanistan Asia      14880372
#>  7  1982 Afghanistan Asia      12881816
#>  8  1987 Afghanistan Asia      13867957
#>  9  1992 Afghanistan Asia      16317921
#> 10  1997 Afghanistan Asia      22227415
#> # ... with 1,694 more rows
```

### Új változók létrehozása: `mutate()`

Az elemzési munkafolyamat elkerülhetetlen része hogy új változókat hozzunk létre, vagy a meglévőket módosítsuk. Ezt a `mutate()`-el tehetjuk meg, ahol a szintaxis a következő: `mutate(data frame, uj valtozo = ertekek)`. Példaként kiszámoljuk a Svéd GDP-t (milliárd dollárban) 1992-től kezdve. A `mutate()` alkalmazásával részletesebben is foglalkozunk a szövegek előkészítésével foglalkozó fejezetben.


```r
gapminder %>% 
  filter(country == "Sweden", year >= 1992) %>% 
  mutate(gdp = (gdpPercap * pop) / 10^9)
#> # A tibble: 4 x 7
#>   country continent  year lifeExp     pop gdpPercap   gdp
#>   <fct>   <fct>     <int>   <dbl>   <int>     <dbl> <dbl>
#> 1 Sweden  Europe     1992    78.2 8718867    23880.  208.
#> 2 Sweden  Europe     1997    79.4 8897619    25267.  225.
#> 3 Sweden  Europe     2002    80.0 8954175    29342.  263.
#> 4 Sweden  Europe     2007    80.9 9031088    33860.  306.
```

### Csoportonkénti statisztikák: `group_by()` és `summarize()`

Az adataink részletesebb és alaposabb megismerésében segítenek a különböző szintű leíró statisztikai adatok. A szintek megadására a `group_by()` használható, a csoportokon belüli számításokhoz pedig a `summarize()`. A lenti példa azt illusztrálja, hogyha kontinensenként csoportosítjuk a `gapminder` data framet, akkor a `summarise()` használatával megkaphatjuk a megfigyelések számát, illetve az átlagos per capita GDP-t. A `summarise()` a `mutate()` közeli rokona, hasonló szintaxissal és logikával használható. Ezt a függvény párost fogjuk majd használni a szöveges adataink leíró statisztikáinál is a 4. fejezetben.


```r
gapminder %>% 
  group_by(continent) %>% 
  summarise(megfigyelesek = n(), atlag_gdp = mean(gdpPercap))
#> # A tibble: 5 x 3
#>   continent megfigyelesek atlag_gdp
#>   <fct>             <int>     <dbl>
#> 1 Africa              624     2194.
#> 2 Americas            300     7136.
#> 3 Asia                396     7902.
#> 4 Europe              360    14469.
#> 5 Oceania              24    18622.
```

## Munka karakter vektorokkal[^adatkezeles-4]

[^adatkezeles-4]: A könyv terjedelme miatt ezt a témát itt csak bemutatni tudjuk, de minden részletre kiterjedően nem tudunk elmélyülni benne. Kíváló online anyagok találhatóak az RStudio GitHub tárhelyén (<https://github.com/rstudio/cheatsheets/raw/master/strings.pdf>), illetve @wickham2016r 14. fejezetében.

A szöveges adatokkal (karakter stringekkel) való munka elkerülhetetlen velejárója hogy a felesleges szövegelemeket, karaktereket el kell távolítanunk ahhoz hogy az elemzésünk hatásfoka javuljon (erről részletesebben a 3. fejezetben lesz szó). Erre a célra a `stringr` csomagot fogjuk használni, kombinálva a korábban bemutatott `mutate()`-el. A `stringr` függvények az `str_` előtaggal kezdődnek és eléggé beszédes nevekkel rendelkeznek. Egy gyakran előforduló probléma, hogy extra szóközök maradnak a szövegben, vagy bizonyos szavakról, karakterkombinációkról tudjuk hogy nem kellenek az elemzésünkhoz. Ebben az esetben egy vagy több *regular expression* (regex) használatával tudjuk pontosan kijelölni hogy a karakter sornak melyik részét akarjuk módosítani. A legegyszerűbb formája a regexeknek, hogyha pontosan tudjuk milyen szöveget akarunk megtalálni. A kísérletezésre az `str_view()`-t használjuk, ami megjeleníti hogy a megadott regex mintánk pontosan mit jelöl.


```r
library(stringr)
```


```r
szoveg <- c('gitar', 'ukulele', 'nagybogo')

str_view(szoveg, pattern = "ar")
```

Az *anchor*-okkal azt lehet megadni, hogy a karakter string elején vagy végén szeretnénk egyezést találni. A string eleji anchor a `^`, a string végi pedig a `$`.


```r
str_view("Dr. Doktor Dr.", pattern = "^Dr.")

str_view("Dr. Doktor Dr.", pattern = "Dr.$")
```

Egy másik jellemző probléma, hogy olyan speciális karaktert akarunk leírni a regex kifejezésünkkel, ami amúgy a regex szintaxisban használt. Ilyen eset például a `.`, ami mint írásjel sokszor csak zaj, ám a regex kotextusban a "bármilyen karakter" megfelelője.


```r
str_view("Dr. Doktor Dr.", pattern = ".k.")
```

Ahhoz hogy magát az írásjelet jelöljük, a `\\` -t kell elé rakni.


```r
str_view("Dr. Doktor Dr.", pattern = "\\.")
```

Néhány hasznos regex kifejezés:

-   `[:digit:]` - számok (123)
-   `[:alpha:]` - betűk (abc ABC)
-   `[:lower:]` - kisbetűk (abc)
-   `[:upper:]` - nagybetűk (ABC)
-   `[:alnum:]` - betűk és számok (123 abc ABC)
-   `[:punct:]` - központozás (`.!?\(){}`)
-   `[:graph:]` - betűk, számok és központozás (123 abc ABC `.!?\(){}`)
-   `[:space:]` - szóköz ( )
-   `[:blank:]` - szóköz és tabulálás
-   `*` - bármi

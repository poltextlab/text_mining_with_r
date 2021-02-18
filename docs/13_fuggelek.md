# Függelék

## Az R és az RStudio használata

Az R egy programozási nyelv, amely alkalmas statisztikai számítások elvégzésére és ezek eredményeinek grafikus megjelenítésére. Az R ingyenes, nyílt forráskódú szoftver, mely telepíthető mind Windows, mind Linux, mind MacOS operációs rendszerek alatt, az alábbi oldalról: <https://cran.r-project.org/> Az RStudio az R integrált fejlesztői környezete (*integrated development environment, IDE*), mely egy olyan felhasználóbarát felületet biztosít, ami egyszerűbb és átláthatóbb munkát tesz lehetővé. Az RStudio az alábbi oldalról tölthető le: <https://rstudio.com/products/rstudio/download/>

A „point and click" szoftverekkel szemben az R használata során kódot kell írni, ami bizonyos programozási jártasságot feltételez, de a későbbiekben lehetővé teszi azt adott kutatási kérdéshez maximálisan illeszkedő kódok összeállítását, melyek segítségével az elemzések mások számára is megbízhatóan reprodukálhatóak lesznek. Ugyancsak az R használata mellett szól, hogy komoly fejlesztői és felhasználói közösséggel rendelkezik, így a használat során felmerülő problémákra általában gyorsan megoldást találhatunk.

### Az RStudio kezdőfelülete

Az RStudio kezdőfelülete négy panelből, eszközsorból és menüsorból áll:

<div class="figure" style="text-align: center">
<img src="figures/13-01_layout.png" alt="RStudio felhasználói felület" width="90%" />
<p class="caption">RStudio felhasználói felület</p>
</div>


Az ***(1) editor*** ablak  szolgál a kód beírására, futtatására és mentésére. A ***(2) console*** ablakban jelenik meg a lefuttatott kód és az eredmények. A jobb felső ablak ***(3) environment*** fülén láthatóak a memóriában tárolt adatállományok, változók és felhasználói függvények. A ***history*** fül mutatja a korábban lefuttatott utasításokat. A jobb alsó ablak ***(4) files*** fülén az aktuális munkakönyvtárban levő mappákat és fájlok találjuk, míg a ***plot*** fülön az elemzéseink során elkészített ábrák jelennek meg. A ***packages*** fülön frissíthetjük a meglévő r csomagokat és telepíthetünk újakat. A ***help*** fülön a különböző függvények, parancsok leírását, és használatát találjuk meg. A `Tools -> Global Options` menüpont végezhetjük el az RStudio testreszabását. Így például beállíthatjuk az ablaktér elrendezését (*Pane layout*), vagy a színvilágot (*Appearance*), illetve azt hogy a kódok ne fussanak ki az ablakból (`Code -> Editing -> Soft wrap R source files`)





### Projekt alapú munka {#projektmunka}


Bár nem kötelező, de javasolt, hogy az RStudio-ban projekt alapon dolgozzunk, mivel így az összes – az adott projekttel kapcsolatos fájlt – egy mappában tárolhatjuk. Új projekt beállítását a `File->New Project` menüben tehetjük meg, ahol a saját gépünk egy könyvtárát kell kiválasztani, ahová az R scripteket, az adat- és előzményfájlokat menti. Ezenkívül a `Tools->Global Options->General` menüpont alatt le kell tiltani a *„Restore most recently opened project at startup”* és a *„Restore .RData ino workspace at startup”* beállítást, valamint *„Save workspace to .RData on exit”* értékre be kell állítani a *„Never”*  értéket. 



<div class="figure" style="text-align: center">
<img src="figures/13-02_project_options.png" alt="RStudio projekt beállítások" width="90%" />
<p class="caption">RStudio projekt beállítások</p>
</div>

A szükséges beállítások után a `File -> New Project` menüben hozhatjuk létre a projektet. Itt arra is lehetőségünk van, hogy kiválasszuk, hogy a projektünket egy teljesen új könyvtárba, vagy egy meglévőbe kívánjuk menteni, esetleg egy meglévő projekt új verzióját szeretnénk létrehozni. Ha sikeresen létrehoztuk a projektet, az RStudio jobb felső sarkában látnunk kell annak nevét. 



### Scriptek szerkesztése, függvények használata

Új script a `File -> New -> File -> R` Script menüpontban hozható létre, mentésére a File->Save menüpontban egy korábbi script megnyitására `File -> Open` menüpontban van lehetőségünk. Script bármilyen szövegszerkesztővel írható és beilleszthető az editor ablakba. A scripteket érdemes magyarázatokkal (kommentekkel) ellátni, hogy a későbbiekben pontosan követhető legyen, hogy melyik parancs segítségével pontosan milyen lépéseket hajtottunk végre. A magyarázatokat vagy más néven kommenteket kettőskereszt (`#`) karakterrel vezetjük be. 
A scriptbeli utasítások az azokat tartalmazó sorokra állva vagy több sort kijelölve a Run feliratra kattintva vagy a `Ctrl+Enter` billentyűparanccsal futtathatók le. A lefuttatott parancsok és azok eredményei ezután a bal alsó sarokban lévő console ablakban jelennek meg és ugyanitt kapunk hibaüzenetet is, ha valamilyen hibát vétettünk a scriptben.

A munkafolyamat során létrehozott állományok (ábrák, fájlok) ebbe az ún. munkakönyvtárba (*working directory*) mentődnek. Az aktuális munkakönyvtár neve, elérési útja a `getwd()` utasítással jeleníthető meg. A könyvtárban található állományok listázására a `list.files()` utasítással van lehetőségünk. Ha a korábbiaktól eltérő munkakönyvtárat akarunk megadni, azt a `setwd()` függvénnyel tehetjük meg, ahol a ()-ben az adott mappa elérési útját kell megadnunk. Az elérési útban a meghajtó azonosítóját, majd a mappák, almappák nevét vagy egy normál irányú perjel (`/`), vagy két fordított perjel (`\\`) választja el, mivel az elérési út karakterlánc, ezért azt idézőjelek vagy aposztrófok közé kell tennünk. 
Az aktuális munkakönyvtárba beléphetünk a jobb alsó ablak file lapján a `„More -> Go To Working Directory”` segítségével. Ugyanitt a `„Set Working Directory”`-val munkakönyvtárnak állíthatjuk be az a mappát, amelyben épp benne vagyunk.




<div class="figure" style="text-align: center">
<img src="figures/13-03_working_directory.png" alt="Working directory beállítások" width="90%" />
<p class="caption">Working directory beállítások</p>
</div>



A munkafolyamat befejezésére a `q()` vagy `quit()` függvényel van lehetőségünk. A munkafolyamat során különböző objektumokat hozunk létre, melyek az RStudio jobb felső ablakának environment fülén jelennek meg, a mentett objektumokat a fent látható seprű ikonra kattintva törölhetjük a memóriából. Az environment ablakra érdemes úgy gondolni hogy ott jelennek meg a memóriában tárolt értékek. Az R-ben objektumokkal dolgozunk, amik a teljesség igénye nélkül lehetnek egyszerű szám vektortok, vagy akár komplex listák, illetve függvények, ábrák. 

Az RStudio jobb alsó ablakának plots fülén láthatjuk azon parancsok eredményét, melyek kimenete valamilyen ábra. A packages fülnél a már telepített és a letölthető kiegészítő csomagokat jeleníthetjük meg. A help fülön a korábban említettek szerint a súgó érhető el. Az RStudio-ban használható billentyűparancsok teljes listáját Alt+Shift+K billentyűkombinációval tekinthetjük meg. Néhány gyakrabban használt, hasznos billentyűparancs:

- `Ctrl+Enter`: futtassa a kódot az aktuális sorban
- `Ctrl+Alt+B`: futtassa a kódot az elejétől az aktuális sorig
- `Ctrl+Alt+E`: futtassa a kódot az aktuális sortól a forrásfájl végéig
- `Ctrl+D`: törölje az aktuális sort

Az R-ben beépített **függvények (function)** állnak rendelkezésünkre a számítások végrehajtására, emellett több **csomag (package)** is letölthető, amelyek különböző függvényeket tartalmaznak. A függvények a következőképpen épülnek fel: `függvénynév(paraméter)`. Például tartalom képernyőre való kiíratását a `print()` függvénnyel tehetjük, amelynek gömbölyű zárójelekkel határolt részébe írhatjuk a megjelenítendő szöveget. A `citation()` függvénnyel lekérdezhetjük az egyes beépített csomagokra való hivatkozást is: a `citation(quanteda)` függvény a quanteda csomag hivatkozását adja meg. 
Az R súgórendszere a `help.start()` utasítással indítható el. Egy adott függvényre vonatkozó súgórészlet a függvények neve elé kérdőjel írásával, vagy a `help()` argumentumába a kérdéses függvény nevének beírásával jeleníthető meg (pl.: `help(sum)`).


### R csomagok {#packages}
Az R-ben telepíthetők kiegészítő csomagok (packages), amelyek alapértelmezetten el nem érhető algoritmusokat, függvényeket tartalmaznak. A csomagok saját dokumentációval rendelkeznek, amelyeket fel kell tüntetni a használatukkal készült publikációink hivatkozáslistájában. A csomagok telepítésre több lehetőségünk is van: használhatjuk a menüsor `Tools -> Install Packages` menüpontját, vagy a jobb alsó ablak *Packages* fül Install menüpontját, illetve az editor ablakban az `install.packages()` parancsot futtatva, ahol a ()-be a telepíteni kívánt csomag nevét kell beírnunk (pl.: `install.packages(dplyr)`).


<div class="figure" style="text-align: center">
<img src="figures/13-04_packages.png" alt="Packages fül" width="90%" />
<p class="caption">Packages fül</p>
</div>



### Objektumok tárolása, értékadás 

Az objektumok lehetnek például *vektorok*, *mátrixok* (matrix), *tömbök* (array), *adat táblák* (data frame). Értékadás nélkül az R csak megjeleníti a műveletek eredményét, de nem tárolja el azokat. Az eredmények eltárolásához azokat egy objektumba kell elmentenünk. Ehhez meg kell adnunk az objektum nevét majd az `<-` után adjuk meg annak értékét: `a <- 12 + 3`.Futtatás után az environments fülön megjelenik az a objektum, melynek értéke `15`. Az objektumok elnevezésénél figyelnünk kell arra, hogy az R különbséget tesz a kis és nagybetűk között, valamint, hogy az ugyanolyan nevű objektumokat kérdés nélkül felülírja és ezt a felülírást nem lehet visszavonni.




### Vektorok

Az R-ben kétféle típusú vektort különböztetünk meg:

- egyedüli vektor (atomic vector)
- lista (list)

Az egyedüli vektornak hat típusa van, **logikai** (logical), **egész szám** (integer), **természetes szám** (double), **karakter** (character), **komplex szám** (complex) és **nyers adat** (raw). A leggyakrabban valamilyen numerikus, logikai vagy karakter vektorral használjuk. Az egyedüli vektorok onnan kapták a nevüket hogy csak egy féle adattípust tudnak tárolni. A listák ezzel szemben gyakorlatilag bármit tudnak tárolni, akár több listát is egybeágyazhatunk.

A vektorok és listák azok az építőelemek amikből felépülnek az R objektumaink. Több érték vagy azonos típusú objektum összefűzését a `c()` függvénnyel végezhetjük el. A lenti példában három különböző objektumot kreálunk, egy numerikusat, egy karaktert és egy logikait. A karakter vektorban az elemeket időzőjellel és vesszővel szeparáljuk. A logikai vektor csak `TRUE`, illetve `FALSE` értékeket tartalmazhat.


```r
numerikus <- c(1,2,3,4,5)

karakter <- c("kutya","macska","ló")

logikai <- c(TRUE, TRUE, FALSE)
```



A létrehozott vektorokkal különböző műveleteket végezhetünk el, például összeadhatjuk numerikus vektorainkat. Ebben az esetben az első vektor első eleme a második vektor első eleméhez adódik.



```r
c(1:4) + c(10,20,30,40)
#> [1] 11 22 33 44
```


A karaktervektorokat összefűzhetjük egymással. Itt egy új objektumot is létrehoztunk, a jobb felső ablakban, az environment fülön láthatjuk, hogy a létrejött karakter_kombinalt objektum egy négy elemű (hosszúságú) karaktervektor (`chr [1:4]`), melynek elemei a `"kutya","macska","ló","nyúl"`. Az objektumként tárolt vektorok tartalmát a lefuttatva írathatjuk ki a console ablakba. Habár van `print()` függvény az R-ben, azt ilyenkor nem szükséges használni.


```r
karakter1 <- c("kutya","macska","ló")
karakter2 <-c("nyúl")

karakter_kombinalt <-c(karakter1, karakter2)

karakter_kombinalt
#> [1] "kutya"  "macska" "ló"     "nyúl"
```


Ha egy vektorról szeretnénk megtudni, hogy milyen típusú azt a `typeof()` vagy a `class()` paranccsal tehetjük meg, ahol ()-ben az adott objektumként tárolt vektor nevét kell megadnunk: `typeof(karakter1)`. A vektor hosszúságát (benne tárolt elemek száma vektorok esetén) a `lenght()` függvénnyel tudhatjuk meg.


```r
typeof(karakter1)
#> [1] "character"

length(karakter1)
#> [1] 3
```


### Faktorok

A faktorok a kategórikus adatok tárolására szolgálnak. Faktor típusú változó a `factor()` függvénnyel hozható létre. A faktor szintjeit (igen, semleges, nem), a `levels()` függvénnyel kaphatjuk meg míg az adatok címkéit (tehát a kapott válaszok száma), a `labels()` paranccsal érhetjük el.



```r
survey_response <- factor(c("igen", "semleges", "nem", "semleges", "nem", "nem", "igen"), ordered = TRUE)


levels(survey_response)
#> [1] "igen"     "nem"      "semleges"

labels(survey_response)
#> [1] "1" "2" "3" "4" "5" "6" "7"
```




### Data frame {#data-frame}
Az adat táblák (data frame) a statisztikai és adatelemzési folyamatok egyik leggyakrabban használt adattárolási formája. Amikor lehetséges akkor a 'hosszú' formátumban használjuk (az R közösség a 'tidy' jelzővel illeti), aholtéglalap alakú adatszerkezetek, ahol minden sor egy megfigyelés és minden oszlop egy változó [TIDY CITATION]. Egy data frame többféle típusú adatot tartalmazhat. A data frame-k különféle oszlopokból állhatnak, amelyek különféle típusú adatokat tartalmazhatnak, de egy oszlop csak egy típusú adatból állhat. A lent bemutatott data frame 7 megfigyelést és 4 féle változót tartalmaz (id, country, pop, continent). 





```
#>   id      orszag nepesseg     kontinens
#> 1  1    Thailand     68.7          Asia
#> 2  2      Norway      5.2        Europe
#> 3  3 North Korea     24.0          Asia
#> 4  4      Canada     47.8 North America
#> 5  5    Slovenia      2.0        Europe
#> 6  6      France     63.6        Europe
#> 7  7   Venezuela     31.6 South America
```

A data frame-be rendezett adatokhoz különböző módon férhetünk hozzá, például a data frame nevének majd []-ben a kívánt sor megadásával, kiírathatjuk a console ablakba annak tetszőleges sorát ás oszlopát: `orszag_adatok[1, 1]`. Az R több különböző módot kínál a data frame sorainak és oszlopainak eléréséhez. A `[` általános használata: `data_frame[sor, oszlop]`. Egy másik megoldás a `$` haszálata: `data_frame$oszlop`.


```r
orszag_adatok[1, 4]
#> [1] Asia
#> Levels: Asia Europe North America South America

orszag_adatok$orszag
#> [1] "Thailand"    "Norway"      "North Korea" "Canada"      "Slovenia"   
#> [6] "France"      "Venezuela"
```


## Vizualizáció


```r
library(ggplot2)
library(gapminder)
```


Az elemzéseinkhez használt data frame adatainak alapján a `ggplot2` csomag segítségével lehetőségünk van különböző vizualizációk készítésére is. 


A `ggplot2` használata során különböző témákat alkalmazhatunk, melyek részletes leírása megtalálható: https://ggplot2.tidyverse.org/reference/ggtheme.html

Abban az esetben, ha nem választunk témát, a `ggplot2` a következő ábrán is látható alaptémát használja. Ha például a szürke helyett fehér hátteret szeretnénk, alkalmazhatjuk a `theme_minmal()`parancsot. Szintén gyakran alkalmazott ábra alap a `thema_bw()`, ami az előzőtől az ábra keretezésében különbözik. Ha fehér alapon, de a beosztások vonalait feketén szeretnénk megjeleníteni, alkalmazhatjuk a `theme_linedraw()` függvényt, a `theme_void()` segítségével pedig egy fehér alapon, beosztásoktól mentes alapot kapunk, a `theme_dark()` pedig sötét hátteret eredményez.  A `theme_classic()` segítségével az x és y tengelyt jeleníthetjük meg fehér alapon. 

Egy ábra készítésének alapja mindig a használni kívánt adatkészlet beolvasása, illetve az ábrázolni kiíván változtót vagy változók megadása.

Ezt követi a megfelelő alakzat kiválasztása, attól függően például, hogy eloszlást, változást, adatok közötti kapcsolatot, vagy elétéseket akarunk ábrázolni. A ` geom` az a geometriai objektum, a mit a diagram az adatok megjelenítésére használ. A`gglpot2` több mint 40 féle alakzat alkalmazására ad lehetőséget, ezek közül néhány gyakoribbat mutatunk be az alábbiakban. Az alakzatokról részletes leírása található például az alábbi linken:
https://r4ds.had.co.nz/data-visualisation.html

A következőkben a már korábban is használt `gapminder` adatok segítségével, személetetjük az adatok vizualizálásának alapjait. 
Először egyszerű alapbeállítások mellett egy histogram típusú vizualizációt készítünk.


```r
ggplot(
  data = gapminder, 
  mapping = aes(x = gdpPercap)
) + 
  geom_histogram() 
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-14-1.png" width="90%" style="display: block; margin: auto;" />

Lehetőségünk van arra, hogy az alakzat színét megváltoztatássuk. A használható színek és színkódok megtalálhatóak a `ggplot2` leírásában: https://ggplot2-book.org/scale-colour.html


```r
ggplot(
  data = gapminder,
  mapping = aes(x = gdpPercap)
) +
  geom_histogram(fill = "yellow", colour = "green") 
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-15-1.png" width="90%" style="display: block; margin: auto;" />

Meghatározhatjuk külön-külön a histogram x és y tengelyén ábrázolni kívánt adatokat és választhatjuk azok pontszerű ábrázolását is.


```r
ggplot(
  data = gapminder,
  mapping = aes(
    x = gdpPercap,
    y = lifeExp
  )
) +
  geom_point() 
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-16-1.png" width="90%" style="display: block; margin: auto;" />

Ahogy az előzőekben, itt is megváltoztathatjuk az ábra színét.


```r
ggplot(
  data = gapminder,
  mapping = aes(
    x = gdpPercap,
    y = lifeExp
  )
) +
  geom_point(colour = "blue")
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-17-1.png" width="90%" style="display: block; margin: auto;" />

Az fenti script kibővítésével az egyes kontinensek adatait különböző színnel ábrázolhatjuk, az x és y tengelyt elnevezhetjük, a histogramnak címet és alcímet adhatunk, illetve az adataink forrását is feltüntethetjük az alábbi módon:


```r
ggplot(
  data = gapminder,
  mapping = aes(
    x = gdpPercap,
    y = lifeExp,
    color = continent
  )
) + 
  geom_point() +
  labs(
    x = "GDP per capita (log $)", 
    y = "Life expectancy",
    title = "Connection between GDP and Life expectancy",
    subtitle = "Points are country-years",
    caption = "Source: Gapminder dataset"
  )
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-18-1.png" width="90%" style="display: block; margin: auto;" />

Az ábrán található feliratok méretének, betűtípusának és betűszínének megválasztásra is lehetőségünk van.


```r
ggplot(
  data = gapminder,
  mapping = aes(
    x = gdpPercap,
    y = lifeExp,
    color = continent
  )
) + 
  geom_point() +
  labs(
    x = "GDP per capita (log $)", 
    y = "Life expectancy",
    title = "Connection between GDP and Life expectancy",
    subtitle = "Points are country-years",
    caption = "Source: Gapminder dataset"
  ) +
  theme(plot.title = element_text(
    size = 12, 
    colour = "red"
  ))
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-19-1.png" width="90%" style="display: block; margin: auto;" />

Készíthetünk oszlopdiagramot is, amit a `ggplot2` diamonds adatkészletén személtetünk
 

```r
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-20-1.png" width="90%" style="display: block; margin: auto;" />

Itt is lehetőségünk van arra, hogy a diagram színét megváltoztassuk.


```r
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut), fill = "darkgreen")
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-21-1.png" width="90%" style="display: block; margin: auto;" />

De arra is lehetőségünk van, hogy az egyes oszlopok eltérő színűek legyenek.


```r
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-22-1.png" width="90%" style="display: block; margin: auto;" />
 Arra is van lehetőségünk, hogy egyszerre több változót is ábrázoljunk.
 

```r
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))
```

<img src="13_fuggelek_files/figure-html/unnamed-chunk-23-1.png" width="90%" style="display: block; margin: auto;" />

Arra ggplot2 segítségével arra is lehetőségünk van, hogy csv-ből beolvasott adatainkat vizualizáljuk.


```r
plot_cap_1 <- read.csv("data/plot_cap_1.csv", head = TRUE, sep = ";") 
ggplot(plot_cap_1, aes(Year, fill = Subtopic)) + 
  scale_x_discrete(limits = c(1957, 1958, 1959, 1960, 1961, 1962, 1963)) +
  geom_bar(position = "dodge") + 
  labs(
    x = NULL, y = NULL, 
    title = "A Magyar Közlönyben kihirdetett agrárpolitikai jogszabályok", 
    subtitle = "N=445"
  ) + 
  coord_flip() + # az ábra tipusa
  theme_minimal() +
  theme(plot.title = element_text(size = 12)) 
```

A csv-ből belolvasott adatainból kördiagramot is készíthetünk


```r
pie <- read.csv("data/pie.csv", head = TRUE, sep = ";")

ggplot(pie, aes(x = "", y = value, fill = Type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_brewer(palette = "GnBu") +
  labs(
    title = "A Magyar Közlönyben megjelent jogszabályok típusai",
    subtitle = "N = 445"
  ) +
  theme_void()
```

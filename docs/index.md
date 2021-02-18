---
title: "Szövegbányászat és mesterséges intelligencia R-ben"
author: "Sebők Miklós, Ring Orsolya"
date: "2021-02-17"
site: bookdown::bookdown_site
documentclass: book
link-citations: true
always_allow_html: true
bibliography: references.bib
output:
  bookdown::gitbook: default
  latex_document: default
---

# Bevezetés



Jelen kötet a Kvantitatív szövegelemzés és szövegbányászat a politikatudományban (L'Harmattan, 2016) című könyv folytatásaként és egyben kiegészítéseként a szövegbányászat és a mesterséges intelligencia társadalomtudományi alkalmazásának gyakorlatába nyújt bevezetést. A szövegek kvantitatív elemzése (quantitative text analysis -- QTA) a nemzetközi társadalomtudomány egyik leggyorsabban fejlődő irányzata. A szövegek és más minőségi adatok (filmek, képek) elemzése annyiban különbözik a mennyiségi (kvantitatív) adatokétól, hogy nyers formájukban még nem alkalmasak arra, hogy statisztikai, illetve ökonometriai elemzés alá vessük őket, s így további módszertani problémákat vetnek fel, melyek speciális tárgyalása szükséges. A tervezett kötetben bemutatott példák többsége a politikatudományhoz kapcsolódik, de más alkalmazási területekre is kitér.

Míg az előző kötet az egyes kódolási eljárásokat, illetve ezek kutatás-módszertani előnyeit és hátrányait ismertette, itt a társadalomtudományi elemzésének során használható kvantitatív szövegelemzés legfontosabb gyakorlati feladatait vesszük sorra. A kézirat a magyar tankönyvpiacon az elsőnek számít a tekintetben, hogy a társadalomtudományban használatos kvantitatív szövegelemzési eljárásokat részletesen, lépésről-lépésre ismerteti, kezdve a megfelelő korpusz kialakításához szükséges ismeretektől, a különböző szövegbányászati módszerek (szózsák, dokumentum-kifejezés mátrix, a névelem-felismerés, az osztályozás, illetve a csoportosítás feladataira), illetve az egyszerűbb szövegösszehasonlítási-feladatok áttekintésén át, egészen a felügyelt és felügyelet nélküli gépi tanulásig, a politikatudományi vizsgálatok során leggyakrabban használatos R programnyelven készült programok segítségével.

Az olvasó a két kötet együttes használatával olyan ismeretek birtokába kerül, melyek révén képes lesz alkalmazni a kvantitatív szövegelemzés és szövegbányászat legalapvetőbb eljárásait saját kutatására. Deduktív vagy induktív felfedező logikája fényében dönthet az adatelemzés módjáról, és a felkínált menüből kiválaszthatja a kutatási tervéhez legjobban illeszkedő megoldásokat. A kötetet végigkísérő konkrét példák segítségével pedig akár reprodukálhatja is ezen eljárásokat saját kutatásában. Mindezt a kötet függelékében helyet kapó R-scriptek részletes leírása is segíti majd. A kötet két fő célcsoportjaként így a társadalomtudományi kutatói és felsőoktatási közösséget határozzuk meg, valamint rögzítjük, hogy a kvantitatív szövegelemzés területén belül elsődlegesen a dokumentum- és tartalomelemzési módszertanhoz kapcsolódunk.

A könyvben ugyancsak helyet kap a fontosabb fogalmak magyar és angol nyelvű szószedete, valamint a további olvasásra ajánlott szakirodalom szerepeltetése. Az oktatásban való közvetlen alkalmazást segíthetik továbbá a fejezetek végén megadott vizsgakérdések, illetve a kötet honlapján (qta.tk.mta.hu) szereplő további információk: gyakorlófeladatok (megoldásokkal), az egyes feladatokra alkalmazható scriptek és kereskedelmi programok bemutatása, a témával kapcsolatos prezentációk és további ajánlott irodalmak.

# grid.app — lista rzeczy do zrobienia

Stan na 2026-11-06. Pozycje wynikają z przeglądu kodu i pomiarów,
nie z przypuszczeń — liczby są zmierzone.

## Ryzyka (najpierw)

- [x] **Testy.** `tests/matrix.html` — otwierane w przeglądarce, bez narzędzi
      budowania. 77 sprawdzeń: niezmienniki geometrii we wszystkich trzech
      trybach pierwszej wysokości oraz wzorcowy skrót 128 eksportów SVG.
      Sprawdzone, że potrafią paść: wstrzyknięcie błędu 0,05% w interlinii
      zapala 25 testów na czerwono.
- [ ] **Sześć `catch {}` połyka błędy.** Najgroźniejszy: zapis do IndexedDB.
      W oknie prywatnym lub przy braku miejsca zapis nie przechodzi, a status
      dalej pokazuje „zapisano".
- [x] **Marginesy większe od strony.** Pasek ostrzeżenia nad wynikami plus
      obrys pól, które go powodują. Osobne komunikaty dla szerokości,
      wysokości i obu naraz.

## Optymalizacje

- [x] **Przerysowanie przy każdym znaku.** Wywołania zbierane w jedną klatkę
      animacji; `recalcAndDrawNow` zostaje tam, gdzie wynik jest potrzebny
      natychmiast. Zmierzone: trzy wywołania pod rząd dają jedno przerysowanie.
      Tabela przez `innerHTML` załatwiona osobno (niżej).
- [x] **Tabela wyników przez `innerHTML`.** Budowana raz, potem podmieniane są
      same teksty; przebudowa tylko gdy zmieni się układ wierszy (język,
      rozkładówka). Jeden nasłuch kopiowania na tabeli zamiast jednego
      na wierszu przy każdym przeliczeniu.
- [x] **Przeliczniki jednostek.** 0,3528 i 1,3333 zastąpione wartościami
      z definicji (25,4/72, 96/72, 96/25,4). Błąd wynosił +63, −25 i −88 ppm;
      A4 w pikselach pokazywało 793,63 zamiast 793,70.
- [ ] **Podgląd tekstu.** Łamanie woła `measureText` dla każdego wiersza w każdej
      kolumnie — przy 104 wierszach i 5 kolumnach tysiące pomiarów na jedno
      przerysowanie. Szerokości znaków da się policzyć raz na krój i stopień.
- [ ] **Dwa renderery tej samej geometrii.** `drawPageGrid` (canvas) i
      `svgPageGrid` (SVG) rysują to samo osobnym kodem. `computeGrid` ujednolicił
      liczby, ale nie rysowanie — tam zostaje ryzyko rozjazdu podglądu z eksportem.
- [ ] **Jeden plik, 3630 linii, 144 KB.** Działa i nie wymaga budowania; rozbicie
      to decyzja produktowa, nie techniczna.

## Typografia (odłożone świadomie)

- [ ] **Rytm pionowy.** Dziesięć elementów ma interlinię `normal` zamiast
      odziedziczonej (przyciski, listy i pola nie dziedziczą `line-height`).
      Nagłówek rozdziału ma 41,55 px — wartość z przypadku. Odstęp 14 px wypada
      z ciągu 4/8/16/20. Próba cofnięta w 2026.11.06.18.
- [ ] **Skala.** 13 px i 12 px różnią się o piksel i nie tworzą hierarchii —
      niosą ją kolor i grubość. Pięć stopni (9/11/12/13/20) robi robotę trzech.

## Repozytorium

- [ ] **OCR-X zostaje w historii gita** mimo usunięcia z katalogu.
- [ ] **`archive/` jest publiczne** — stare wersje aplikacji widoczne dla wszystkich.
- [ ] **Brak README.**

## Integracja z narzędziami DTP (do przemyślenia)

- [ ] **InDesign / Illustrator / Figma.** Dziś wyjściem jest SVG w milimetrach,
      który da się umieścić jako warstwę odniesienia. Możliwe kierunki,
      od najtańszego: (a) opis siatki do wklejenia ręcznie — wartości już są
      w panelu wyników i da się je kopiować; (b) skrypt .jsx dla InDesigna
      generowany z aktualnych parametrów, ustawiający marginesy, łamy
      i siatkę bazową dokumentu; (c) wtyczka Figmy czytająca ten sam JSON
      projektu, który już eksportujemy. Wariant (b) wygląda na najlepszy
      stosunek wartości do pracy — InDesign czyta ExtendScript bez instalacji
      czegokolwiek, a siatka bazowa to tam dokładnie te same wielkości,
      które aplikacja liczy.

## Dostępność i UX

- [ ] **Canvas bez tekstowego odpowiednika** — dla czytnika ekranu podgląd jest
      pusty, choć wszystkie liczby są obok w tabeli.
- [ ] **Linie pomocnicze różni od baseline'ów tylko kolor.**
- [ ] **Link nie przenosi wgranego kroju** (i nie może — plik nie opuszcza
      urządzenia). Warto to powiedzieć w interfejsie, bo odbiorca zobaczy inne
      wysokości X.
- [ ] **Rozkładówki w powiększeniu nie da się przeciągać myszą.**

website: http://car-hire.herokuapp.com/


Zadanie do wykonania:

Przykładowa aplikacja wspomagająca zarządzanie wypożyczalnią samochodów


Opis projektu z punktu widzenia klienta:

Jako właściciel wypożyczalni chciałbym mieć narzędzie do zarządzania moimi samochodami. W mojej wypożyczalni dysponuję samochodami o różnej klasie komfortu,odpowiednio A, B i C. Minimalny okres na jaki mogę wypożyczyć danej osobie auto to jeden dzień. Cena za pożyczenie auta jest zależna od klasy komfortu, odpowiednio A- 100 zł/dzień, B - 75 zł/dzień, C - 50zł/dzień.

W moim systemie chciałbym mieć możliwość dodania auta do bazy danych. Każde auto posiada nazwę, opis oraz jest przypisane do odpowiedniej klasy komfortu.

Dodatkowo kiedy klient przyjdzie do mojej wypożyczalni chciałbym mieć możliwość wypożyczenia auta poprzez wybór daty początkowej i końcowej.

Mogę z wyprzedzeniem pożyczyć auto kilku osobom o ile nie jest już zajęty dany termin.

System powinien nie pozwalać wypożyczyć auta, jeżeli jest ono już pożyczone. Dlatego powinna być też opcja podglądu/sprawdzenia w jakich dniach dane auto zostało lub będzie zajęte.


Kolejne etapy do wykonania:
1. stworzenie struktury modeli i bazy danych
2. stworzenie odpowiednich widoków i formularza rejestracji
3. dodanie odpowiednich walidacji
4. ewentualne dodatkowe rzeczy


Dodatkowe wymagania/uwagi techniczne:

Nie jest wymagany ładny wygląd tej aplikacji, chodzi wyłącznie o funkcjonalność. Dodatkowym atutem będzie integracja z TwitterBootstrap. Logowanie również nie jest wymagane, integracja z Devise będzie dodatkowym atutem.

Testowy projekt powinien być wykonany w technologi Rails 4.x przy użyciu Ruby 1.9  lub 2.x

Idealnie aby rezultat był dostępny publicznie na github a deploy i podgląd działania aplikacji wrzucony na heroku.com

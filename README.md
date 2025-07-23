# shiftenapp-svelte

Joepie een nieuwe versie van een nieuwe versie van een oud project!

## Setup

### Benodigdheden

Zorg ervoor dat je Docker en Docker Compose geïnstalleerd hebt. Volg hiervoor de instructies voor je besturingssysteem. Bovendien heb je een JavaScript-runtime en -package manager nodig, zoals Node/NPM of Bun. Ik vind zelf Bun het fijnste en gebruik dat dus in alle voorbeelden, maar je kunt normaal gezien overal `bun` door `npm` en `bunx` door `npx` vervangen als je liever NPM gebruikt.

### Installatie

1. Clone de repository.
2. Installeer de requirements met `bun i`.
3. Genereer de Prismaclient; dit doe je met `bunx prisma generate`.
4. Voer de commando's `docker compose create` en `docker compose start` uit om de database en webserver te starten.  
   Nota bene: als je nu navigeert naar de webserver, zul je een error krijgen over niet-bestaande tabellen. Dit fixen we in de volgende stap:
5. We moeten nu het databaseschema toepassen op de zojuist gemaakte database; dit doe je met `docker compose --profile tools run --rm migrate`.

Joepie! De webserver draait nu op poort 5173 (dus als je in een browser naar [http://localhost:5173](http://localhost:5173) navigeert, krijg je de homepage te zien.) Omdat de hele werkmap als een volume gemount is in de `app`-container, kun je gebruik maken van HMR (hot module reloading): probeer bijvoorbeeld eens wat tekst in `src/routes/+page.svelte` aan te passen en het bestand op te slaan, je veranderingen zullen onmiddellijk zichtbaar zijn op de live webserver!

6. (Optioneel.) Als je alvast wat voorbeelddata in de database wil steken, kun je het _seed-script_ uitvoeren met `docker compose exec app bunx prisma db seed`. Dat haalt de voorbeelddata uit `prisma/voorbeeldData.json`. Eens dit script uitgevoerd is kun je de homepage reloaden om de nieuwe data te zien.
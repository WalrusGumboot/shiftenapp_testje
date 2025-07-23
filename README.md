# shiftenapp-svelte

Joepie een nieuwe versie van een nieuwe versie van een oud project!

## Setup

1. Zorg ervoor dat je Docker en Docker Compose geïnstalleerd hebt. Volg hiervoor de instructies voor je besturingssysteem.
2. Clone de repository.
3. Voer het commando `docker compose start` uit in de repository.
4. Joepie! De webserver draait nu op poort 5173 (dus als je in een browser naar [http://localhost:5173](http://localhost:5173) navigeert, krijg je de homepage te zien.)
5. (Optioneel.) Als je alvast wat voorbeelddata in de database wil steken, kun je het _seed-script_ uitvoeren met `docker compose exec app bunx prisma db seed`.
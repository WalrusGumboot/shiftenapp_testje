<script lang="ts">
    import { goto } from "$app/navigation";
    import { Vereniging, type Gebruiker, type Shiftenlijst } from "$lib";
    import { Button } from "$lib/components/base";
    import { ShiftenGantt } from "$lib/components/composite";

    const huidigeGebruiker: Gebruiker = {
		voornaam: "Simeon",
		achternaam: "Duwel",
		email: "simeon@wina.be",
		vereniging: Vereniging.Wina
	}
    
    const huidigeShiftenlijst: Shiftenlijst = {
		vereniging: Vereniging.Wina,
		naam: "Lenteconcert",
		begin: new Date(2025, 3, 15, 14),
		eind: new Date(2025, 3, 17, 23),
		shiften: 40,
		onopgevuld: 12,
		beheerders: []
	}
</script>

<div class="w-screen h-screen p-16 flex flex-col gap-8">
    <div class="flex flex-row justify-between items-stretch">
		<div class="*:leading-none">
            <p class="text-neutral-700">{Vereniging[huidigeShiftenlijst.vereniging]}</p>
            <h1 class="text-4xl font-bold">{huidigeShiftenlijst.naam}</h1>
        </div>
		<div class="flex flex-row gap-4 items-center">
			<Button click={() => {goto("nieuweShiftenlijst")}}>
				Exporteer PDF-overzicht
			</Button>
			<div class="text-sm text-right">
				<p>Ingelogd als <b>{huidigeGebruiker.voornaam} {huidigeGebruiker.achternaam}</b></p>
				<p>voor vereniging <b>{Vereniging[huidigeGebruiker.vereniging]}</b></p>
			</div>
		</div>
	</div>

    <ShiftenGantt hShiften={[]} />
</div>
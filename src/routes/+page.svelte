<script lang="ts">
	import { Vereniging, type Shift, type Shiftenlijst, type Gebruiker } from "$lib";
    import { Button, ShiftCard, ShiftenlijstCard } from "$lib/components";
    import { goto } from "$app/navigation";
    import ProfielWidget from "$lib/components/ProfielComponent.svelte";
    import Scaffold from "$lib/components/Scaffold.svelte";

	const huidigeGebruiker: Gebruiker = {
		voornaam: "Simeon",
		achternaam: "Duwel",
		email: "simeon@wina.be",
		vereniging: Vereniging.Wina
	}

	const voorbeeldShiftenlijst1: Shiftenlijst = {
		vereniging: Vereniging.Wina,
		naam: "Lenteconcert",
		begin: new Date(2025, 3, 15, 14),
		eind: new Date(2025, 3, 17, 23),
		shiften: 40,
		onopgevuld: 12,
		beheerders: []
	}

	const voorbeeldShiftenlijst2: Shiftenlijst = {
		vereniging: Vereniging.LOKO,
		naam: "International Party",
		begin: new Date(2025, 4, 22, 14),
		eind: new Date(2025, 4, 22, 23),
		shiften: 20,
		onopgevuld: 3,
		beheerders: []
	}

	const voorbeeldShift1: Shift = {
		shiftenlijst: voorbeeldShiftenlijst1,
		naam: "Afwasshift",
		beschrijving: "Let extra goed op de cavaglazen!",
		locatie: "Winagang",
		begin: new Date(2025, 3, 17, 21),
		duur: 120,
		maxShifters: 3,
		combineerbaar: false,
		ingevuldDoor: []
	}
</script>

{#snippet titel()}
	Welkom, <span class="text-primary-600 font-semibold">{huidigeGebruiker.voornaam}</span>.
{/snippet}

<Scaffold {titel}>
	<div class="grow self-stretch grid grid-cols-2 gap-8 *:bg-primary-100 *:rounded-sm *:p-8 *:flex *:flex-col *:gap-4">
		<!-- Beschikbare (openstaande) shiftenlijsten. -->
		<div>
			<h2 class="text-2xl">Openstaande shiftenlijsten</h2>
			<div class="grid grid-cols-2 gap-4">
				<ShiftenlijstCard item={voorbeeldShiftenlijst1} />
				<ShiftenlijstCard item={voorbeeldShiftenlijst2} />
			</div>
		</div>

		<!-- Dringende oningevulde shiften. -->
		<div>
			<h2 class="text-2xl">Dringende shiften (komende <span>
				<select class="border-b-2 border-primary-500 field-sizing-content">
					<option>week</option>
					<option>twee weken</option>
					<option>maand</option>
				</select>
			</span>)</h2>
			<ShiftCard toonShiftenlijst item={voorbeeldShift1} />
		</div>
	</div>
</Scaffold>
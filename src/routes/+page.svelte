<script lang="ts">
    import { ShiftCard, ShiftenlijstCard } from "$lib/components";
    import Scaffold from "$lib/components/Scaffold.svelte";
    import type { PageData } from "./$types";

	export let data: PageData;
</script>

{#snippet titel()}
	Welkom, <span class="text-primary-600 font-semibold">Simeon</span>.
{/snippet}

<Scaffold {titel}>
	<div class="grow self-stretch grid grid-cols-2 gap-8 *:bg-primary-100 *:rounded-sm *:p-8 *:flex *:flex-col *:gap-4">
		<!-- Beschikbare (openstaande) shiftenlijsten. -->
		<div>
			<h2 class="text-2xl">Openstaande shiftenlijsten</h2>
			<div class="grid grid-cols-2 gap-4">
				{#each data.shiftenlijsten as item}				
					<ShiftenlijstCard {item} />
				{/each}
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

			{#each data.shiftenlijsten.flatMap(s => s.shiften) as item}
				<ShiftCard toonShiftenlijst {item} />
			{/each}
		</div>
	</div>
</Scaffold>
<script lang="ts">
    import type { GebruikerModel as Gebruiker } from "$lib/prisma-client/models/Gebruiker";
    import type { Snippet } from "svelte";
    import NavLink from "./NavLink.svelte";
    // import { ProfielWidget } from ".";

    let { titel, huidigeGebruiker, children }: {titel: Snippet, huidigeGebruiker?: Gebruiker, children: Snippet} = $props();
</script>

<div class="w-screen h-screen p-16 flex flex-col gap-8">
	<!-- Hoofding. -->
	<div class="flex flex-row justify-between items-stretch">
		<h1 class="text-4xl">{@render titel()}</h1>
		<div class="flex flex-row gap-4 items-center">
            <NavLink href="/" tekst="Home" />
            <NavLink href="/lijst" tekst="Shiftenlijsten" />
            <NavLink href="/shift" tekst="Shiften" />
			<!-- <ProfielWidget gebruiker={huidigeGebruiker} /> -->
		</div>
	</div>

    {@render children()}
</div>
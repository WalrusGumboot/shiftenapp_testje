<script lang="ts">
    import type { Gebruiker } from "$lib";
    import avatar from "$lib/assets/avatar.svg";
    import { slide } from "svelte/transition";

    let { gebruiker }: { gebruiker?: Gebruiker } = $props();
    let toonMenu = $state(false);
</script>

<div class="flex flex-row items-center">
    {#if toonMenu}
        <div transition:slide={{axis: "x"}} class="px-4 py-2 bg-primary-100 rounded-md shadow-sm flex flex-row gap-4 *:underline *:whitespace-nowrap -mr-8">
            {#if gebruiker === undefined}
                <p>Log in</p>
                <p>Registreer</p>
            {:else}    
                <p>Log uit</p>
                <p>Statistieken</p>
            {/if}
            <div class="w-4"></div>
        </div>
    {/if}
    
    <button class="rounded-full z-50 aspect-square p-2 size-12 shadow-sm bg-primary-300 flex items-center justify-center hover:cursor-pointer" onclick={() => toonMenu = !toonMenu}>
        {#if gebruiker === undefined}
            <img src={avatar} alt="Profielfoto" class="object-cover size-12" />
        {:else}
            <p>{gebruiker.voornaam.charAt(0)}{gebruiker.achternaam.charAt(0)}</p>
        {/if}
    </button>

</div>
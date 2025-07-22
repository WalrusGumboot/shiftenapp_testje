<script lang="ts">
    import Card from "./Card.svelte";
    import FlatButton from "./FlatButton.svelte";
    import { Vereniging, type HerhaaldeShift } from "$lib";

    import { formatteerBeginEind, vindEindtijd } from "$lib/utils";
    import { slide } from "svelte/transition";

    let { item = $bindable(), toonVereniging = false, bewerkCallback, verwijderCallback }: { 
        item: HerhaaldeShift, 
        toonVereniging?: boolean, 
        bewerkCallback: () => void,
        verwijderCallback: () => void } = $props();
</script>

{#snippet acties()}
    <div class="flex flex-row gap-2">
        <FlatButton click={() => {item.herhalingen += 1;}}>
            Herhaal
        </FlatButton>

        <FlatButton click={bewerkCallback}>
            Bewerk
        </FlatButton>

        <FlatButton click={verwijderCallback}>
            Verwijder
        </FlatButton>
    </div>
{/snippet}


<Card actie={acties}>
    {#if toonVereniging}
        <p class="text-sm text-neutral-700">{Vereniging[item.shift.vereniging!]}</p>
    {/if}
    <p class="text-xl mt-1">{item.shift.naam}</p>
    {#if item.shift.beschrijving != undefined}
        <p class="text-sm -mt-1 mb-1 text-neutral-700">{item.shift.beschrijving}</p>
    {/if}
    <p>{item.shift.locatie} / {formatteerBeginEind(item.shift.begin, vindEindtijd(item.shift.begin, item.shift.duur))}</p>

    {#if item.herhalingen > 1}
        <div transition:slide={{axis: "y"}} class="bg-primary-800 p-4 rounded-b-sm -m-4 mt-2 text-white flex flex-row items-center gap-2">
            <button 
                onclick={() => {item.herhalingen += 1;}} 
                class="bg-primary-500 w-6 aspect-square rounded-full hover:cursor-pointer hover:shadow-md hover:scale-105 transition-all">+
            </button>
            <button 
                onclick={() => {item.herhalingen -= 1;}} 
                class="bg-primary-500 w-6 aspect-square rounded-full hover:cursor-pointer hover:shadow-md hover:scale-105 transition-all">-
            </button>
            <p>
                Herhaal shift {item.herhalingen} keer ({formatteerBeginEind(item.shift.begin, vindEindtijd(item.shift.begin, item.shift.duur * item.herhalingen))})
            </p>
        </div>
    {/if}
</Card>
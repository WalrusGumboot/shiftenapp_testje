<script lang="ts">
    import Card from "./Card.svelte";
    import { Vereniging, type Shift } from "$lib";

    import { formatteerBeginEind, vindEindtijd } from "$lib/utils";

    let { item, toonShiftenlijst = false}: { item: Shift, toonShiftenlijst?: boolean } = $props();
</script>

<Card>
    {#if toonShiftenlijst}
        <p class="text-sm text-neutral-700 font-light">{Vereniging[item.shiftenlijst!.vereniging]} ❭ <a class="text-black underline font-normal" href="/">{item.shiftenlijst!.naam}</a></p>
    {/if}
    <p class="text-xl mt-1">{item.naam}</p>
    {#if item.beschrijving != undefined}
        <p class="text-sm -mt-1 mb-1 text-neutral-700">{item.beschrijving}</p>
    {/if}
    <p>{item.locatie} / {formatteerBeginEind(item.begin, vindEindtijd(item.begin, item.duur))}</p>
</Card>
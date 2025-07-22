<script lang="ts">
    import Card from "./Card.svelte";
    import { type ShiftModel as Shift } from "$lib/prisma-client/models/Shift"
    import { type ShiftenlijstModel as Shiftenlijst } from "$lib/prisma-client/models/Shiftenlijst"

    import { formatteerBeginEind, vindEindtijd } from "$lib/utils";

    let { item, toonShiftenlijst = false}: { item: Shift & { lijst: Shiftenlijst }, toonShiftenlijst?: boolean } = $props();
</script>

<Card>
    {#if toonShiftenlijst}
        <p class="text-sm text-neutral-700 font-light">{item.vereniging ?? item.lijst.vereniging} ❭ <a class="text-black underline font-normal" href="/">{item.lijst.naam}</a></p>
    {/if}
    <p class="text-xl mt-1">{item.naam}</p>
    {#if item.beschrijving != undefined}
        <p class="text-sm -mt-1 mb-1 text-neutral-700">{item.beschrijving}</p>
    {/if}
    <p>{item.locatie} / {formatteerBeginEind(item.begin, vindEindtijd(item.begin, item.duur))}</p>
</Card>
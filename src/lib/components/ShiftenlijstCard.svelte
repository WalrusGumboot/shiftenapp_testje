<script lang="ts">
    import { type ShiftModel as Shift } from "$lib/prisma-client/models/Shift"
    import { type ShiftenlijstModel as Shiftenlijst } from "$lib/prisma-client/models/Shiftenlijst"
    import Card from "./Card.svelte";
    import { formatteerBeginEind, vindEindtijd } from "$lib/utils";
    
    let { item }: { item: Shiftenlijst & { shiften: Shift[] } } = $props();
</script>

<Card>
    <p class="text-sm font-light">{item.vereniging}</p>
    <p class="font-bold text-xl">{item.naam}</p>
    <!-- <p class="text-neutral-700 text-sm">
        {formatteerBeginEind(item.shiften.map(s => s.begin).toSorted().at(0)!, item.shiften.map(s => vindEindtijd(s.begin, s.duur)).toSorted().at(-1)!)}
    </p> -->
    <!-- <p>
        <span class="text-green-500">{item.shiften - item.onopgevuld}</span> opgevuld / 
        <span class="text-red-500">{item.onopgevuld}</span> onopgevuld
    </p> -->
</Card>
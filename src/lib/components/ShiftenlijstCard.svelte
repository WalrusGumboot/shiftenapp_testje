<script lang="ts">
    import { Vereniging, type Shiftenlijst } from "$lib";
    import Card from "./Card.svelte";
    import { formatteerBeginEind } from "$lib/utils";
    
    let { item }: { item: Shiftenlijst } = $props();
</script>

<Card>
    <p class="text-sm font-light">{Vereniging[item.vereniging]}</p>
    <p class="font-bold text-xl">{item.naam}</p>
    <p class="text-neutral-700 text-sm">
        {formatteerBeginEind(item.begin, item.eind)}
    </p>
    <p>
        <span class="text-green-500">{item.shiften - item.onopgevuld}</span> opgevuld / 
        <span class="text-red-500">{item.onopgevuld}</span> onopgevuld
    </p>
</Card>
<script lang="ts">
    import type { OngepubliceerdeShift } from "$lib/types";
    import { fade } from "svelte/transition"; 
    import FlatButton from "./FlatButton.svelte";
    import Button from "./Button.svelte";
    import { DateInput } from "date-picker-svelte";
    import TijdPicker from "./TijdPicker.svelte";

    let { item = $bindable(), okCallback, annuleerCallback }: 
        { item: OngepubliceerdeShift, okCallback: () => void, annuleerCallback: () => void } = $props();
    
    $inspect(item)
</script>

<div transition:fade={{duration: 75}} class="z-10 p-32 fixed inset-0 bg-black/50 flex justify-center items-center">
    <div class="bg-primary-100 rounded-md p-4 flex flex-col gap-2 w-1/2 [&_p]:text-sm [&_p]:text-neutral-700 [&_p]:-mb-1 [&_input]:bg-white [&_input]:px-4 [&_input]:py-2 [&_input]:rounded-sm ">
        <h2 class="text-2xl font-bold">Bewerk shift</h2>
        <p>Naam</p>
        <input bind:value={item.naam}>

        <p>Beschrijving</p>
        <input bind:value={item.beschrijving}>

        <p>Locatie</p>
        <input bind:value={item.locatie}>
        
        <div class="*:inline">
            <p>Begintijd</p>
            <DateInput timePrecision="minute" bind:value={item.begin} />
            
            <p>Lengte (uren:minuten)</p>
            <TijdPicker bind:minuten={item.duur} />
        </div>

        <p>Maximum aantal shifters</p>
        <input type="number" min={1} bind:value={item.maxShifters} onchange={() => {item.maxVrijwilligers = Math.min(item.maxShifters ?? 0, item.maxVrijwilligers ?? 0)}}>

        <p>Maximum aantal vrijwilligers</p>
        <input type="number" min={0} max={item.maxShifters} bind:value={item.maxVrijwilligers}>

        <p>Combineerbaar?
            <input type="checkbox" bind:checked={item.combineerbaar}>
        </p>

        <div class="self-end flex flex-row gap-2">
            <FlatButton click={annuleerCallback}>Annuleer</FlatButton>
            <Button click={okCallback}>OK</Button>
        </div>
    </div>
</div>
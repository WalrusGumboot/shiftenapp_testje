<script lang="ts">
    let { minuten = $bindable() }: {minuten: number} = $props()
    let u = $state(0);
    let m = $state(0);
    
    $effect(() => {
        minuten = 60 * u + m;
    })
</script>

<div>
    <input type="number" min={0} bind:value={u}>
    <input type="number" min={0} max={59} bind:value={m}>

</div>
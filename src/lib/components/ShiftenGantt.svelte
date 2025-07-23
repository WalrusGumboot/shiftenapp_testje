<script lang="ts">
    import type { OngepubliceerdeShift } from "$lib/types";
    import { onMount } from "svelte";
    import { SvelteGantt, SvelteGanttTable } from "svelte-gantt";
    let { shiften }: { shiften: OngepubliceerdeShift[] } = $props();

    let fixedGanttOptions = {
        tableHeaders: [ { title: "Shift", property: "shiftNaam", type: "tree" } ],
        fitWidth: true,
        minWidth: 800,
        ganttTableModules: [SvelteGanttTable],
    }

    let rows = $derived(shiften.map((shift, id) => { return {id, shiftNaam: shift.naam} }));
    let taskIdOffsets = $derived.by(() => {
        const iter = Array(shiften.length).keys().map(i => {
            const upTo = shiften.slice(0, i);
            return upTo.map(s => s.herhalingen).reduce((acc, curr) => acc + curr, 0);
        });

        return Array.from(iter);
    });

    let tasks = $derived(shiften.flatMap((shift, resourceId) => {
        let tasksForShift = []
        for (let i = 0; i < shift.herhalingen; i++) {
            tasksForShift.push({
                id: taskIdOffsets[resourceId] + i,
                resourceId,
                label: `${shift.naam} ${i + 1}`,
                from: shift.begin.getTime() + i * (shift.duur * 60 * 1000),
                to: shift.begin.getTime() + (i + 1) * (shift.duur * 60 * 1000),
                resizable: false,
                draggable: false,
                classes: "bg-primary-500 hover:bg-primary-600 border-primary-200 border-2 text-white transition-colors"
            })
        }
        return tasksForShift;
    }));


    let ganttOptions = $derived({
        rows,
        tasks,
        from: Math.min(...tasks.map(t => t.from)),
        to: Math.max(...tasks.map(t => t.to)),
        rowPadding: 0,
        ...fixedGanttOptions
    });

    let div = $state<HTMLElement | undefined>();
    let gantt: any = $state(); // de svelte-gantt bibliotheek biedt geen type hints >:(

    onMount(() => {
        gantt = new SvelteGantt({
            props: ganttOptions,
            target: div
        });
    })

    $effect(() => {
        gantt.$set(ganttOptions);
    })
</script>

{#if shiften.length > 0}
    <div class="bg-white p-3 rounded-sm" bind:this={div}></div>
{/if}
<script lang="ts">
    import type { HerhaaldeShift } from "$lib";
    import { onMount } from "svelte";
    import { SvelteGantt, SvelteGanttTable } from "svelte-gantt";
    let { hShiften }: { hShiften: HerhaaldeShift[] } = $props();

    let fixedGanttOptions = {
        tableHeaders: [ { title: "Shift", property: "shiftNaam", type: "tree" } ],
        fitWidth: true,
        minWidth: 800,
        ganttTableModules: [SvelteGanttTable],
    }

    let rows = $derived(hShiften.map((hShift, id) => { return {id, shiftNaam: hShift.shift.naam} }));
    let taskIdOffsets = $derived.by(() => {
        const iter = Array(hShiften.length).keys().map(i => {
            const upTo = hShiften.slice(0, i);
            return upTo.map(hS => hS.herhalingen).reduce((acc, curr) => acc + curr, 0);
        });

        return Array.from(iter);
    });

    let tasks = $derived(hShiften.flatMap((hShift, resourceId) => {
        let tasksForHShift = []
        for (let i = 0; i < hShift.herhalingen; i++) {
            tasksForHShift.push({
                id: taskIdOffsets[resourceId] + i,
                resourceId,
                label: `${hShift.shift.naam} ${i + 1}`,
                from: hShift.shift.begin.getTime() + i * (hShift.shift.duur * 60 * 1000),
                to: hShift.shift.begin.getTime() + (i + 1) * (hShift.shift.duur * 60 * 1000),
                resizable: false,
                draggable: false,
                classes: "bg-primary-500 hover:bg-primary-600 border-primary-200 border-2 text-white transition-colors"
            })
        }
        return tasksForHShift;
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

{#if hShiften.length > 0}
    <div class="bg-white p-3 rounded-sm" bind:this={div}></div>
{/if}
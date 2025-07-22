<script lang="ts">
    import type { Snippet } from "svelte";

    let { click, children }: { click: () => void, children: Snippet } = $props();
</script>

<button onclick={click} class="px-4 py-2 shadow-sm rounded-sm bg-primary-500 text-white hover:bg-primary-600 active:bg-primary-800 active:shadow-none transition-all hover:cursor-pointer">
    {@render children?.()}
</button>
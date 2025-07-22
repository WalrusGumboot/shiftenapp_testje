<script lang="ts">
    import type { Snippet } from "svelte";

    let { click, children }: { click: () => void, children: Snippet } = $props();
</script>

<button onclick={click} class="px-2 py-2 rounded-sm bg-primary-100 text-primary-800 hover:bg-primary-200 active:bg-primary-800 active:text-white transition-all hover:cursor-pointer">
    {@render children()}
</button>
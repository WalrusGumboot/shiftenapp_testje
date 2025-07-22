<script lang="ts">
    import type { Snippet } from "svelte";

    let { children, actie }: { children?: Snippet, actie?: Snippet } = $props();
</script>

<div class="relative p-4 rounded-sm shadow-sm bg-white flex flex-col gap-2 *:leading-none hover:scale-[1.01] hover:shadow-md transition-all">
    {@render children?.()}
    <div class="absolute top-4 right-4">
        {@render actie?.()}
    </div>
</div>
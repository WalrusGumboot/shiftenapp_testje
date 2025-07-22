<script lang="ts">
    import { goto } from "$app/navigation";
    import { page } from "$app/state";

    let { href, tekst }: { href: string, tekst: string } = $props();
</script>

<button onclick={() => goto(href)} class="hover:cursor-pointer hover:underline">
    <p class={page.url.pathname == href ? "font-bold" : ""}>{tekst}</p>
</button>
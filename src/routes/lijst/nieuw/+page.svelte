<script lang="ts">
    import { type Shift, type HerhaaldeShift } from "$lib";
    import { AdminShiftCard, Button, FlatButton, ShiftEditorPopup, ShiftenGantt } from "$lib/components";

    let naam = $state("");
    let beschrijving = $state("");
    let shiften = $state<HerhaaldeShift[]>([]);

    let bewerkteShift = $state<Shift | undefined>();
    let isNieuweShift = $state<boolean | undefined>();
    
    function okCallback() {
        if (isNieuweShift!) {
            shiften.push({shift: bewerkteShift!, herhalingen: 1});
        }
        bewerkteShift = undefined;
        isNieuweShift = undefined;
    }

    function annuleerCallback() {
        bewerkteShift = undefined;
        isNieuweShift = undefined;
    }
</script>

{#if bewerkteShift !== undefined}
    <ShiftEditorPopup item={bewerkteShift} {okCallback} {annuleerCallback} />
{/if}

<div class="w-screen min-h-screen bg-primary-100 p-16 flex flex-col gap-8">
    <h1 class="text-4xl font-bold">Nieuwe shiftenlijst</h1>
    <p>Je bent ingelogd als <b>Simeon Duwel</b>, als lid van de vereniging <b>Wina</b>. Deze shiftenlijst zal dus beschikbaar zijn voor: <b>presidiumleden van Wina</b>.</p>
    <div class="grid grid-cols-[1fr_2fr] gap-8">
        <div class="row-span-2">
            <p class="text-xl font-bold text-primary-950">Algemene info</p>
            <p>Geef hier de algemene informatie over deze shiftenlijst in. Je kunt deze later nog bewerken.</p>
        </div>

        <div class="flex flex-col gap-2">
            <label for="naam">Naam</label>
            <input required id="naam" type="text" class="bg-white px-4 py-2 rounded-sm ring-primary-500 active:border-primary-500" placeholder="Lenteconcert" bind:value={naam}>
        </div>

        <div class="flex flex-col gap-2">
            <label for="beschrijving">Beschrijving</label>
            <input id="beschrijving" type="text" class="bg-white px-4 py-2 rounded-sm ring-primary-500 active:border-primary-500" placeholder="Een concert gegeven door Winezen in de PDS." bind:value={beschrijving}>
        </div>

        
        <div>
            <p class="text-xl font-bold text-primary-950">Shiften</p>
            <p>Welke shiften moeten deel uitmaken van deze shiftenlijst?</p>
        </div>

        <div class="flex flex-col gap-2">
            {#each shiften as item, index}
                <AdminShiftCard 
                    {item} 
                    bewerkCallback={() => {isNieuweShift = false; bewerkteShift = item.shift;}}
                    verwijderCallback={() => {shiften = shiften.toSpliced(index, 1)}} />
            {:else}
                <div class="p-4 bg-primary-50 rounded-sm">
                    <p>Er zijn nog geen shiften in deze lijst.</p>
                </div>
            {/each}
            <FlatButton click={() => {isNieuweShift = true; bewerkteShift = {
                naam: "",
                beschrijving: "",
                locatie: "",
                ingevuldDoor: [],
                begin: new Date(),
                duur: 0,
                combineerbaar: false
            }}}>
                Voeg nieuwe shift toe
            </FlatButton>
        </div>

        <div>
            <p class="text-xl font-bold text-primary-950">Tijdlijn</p>
            <p>Een snel overzicht van alle shiften.</p>
        </div>
        <ShiftenGantt hShiften={shiften}/>
    </div>

    <div class="flex flex-row justify-end gap-4">
        <FlatButton click={() => {}}>Opslaan in Concepten</FlatButton>
        <Button click={() => {}}>Maak een nieuwe shiftenlijst</Button>
    </div>
</div>
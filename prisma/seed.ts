import { PrismaClient, Vereniging } from "../src/lib/prisma-client/client"
import voorbeeldData from "./voorbeeldData.json" assert { type: "json" }

const prisma = new PrismaClient();

async function main() {
    console.log("Seedproces gestart.")

    console.log("  VerenigingHiërarchie:")
    for (const h of voorbeeldData.VerenigingHiërarchie) {
        const hiërarchie = await prisma.verenigingHiërarchie.create({
            data: {
                head: Vereniging[h.head],
                body: h.body.map(b => Vereniging[b])
            }
        });
        console.log(`    VerenigingHiërarchie [${h.head}] met id ${hiërarchie.id} gemaakt.`)
    }

    console.log("  Gebruiker:")
    for (const g of voorbeeldData.Gebruiker) {
        const gebruiker = await prisma.gebruiker.create({
            data: {
                id: g.id,
                email: g.email,
                voornaam: g.voornaam,
                achternaam: g.achternaam,
                vereniging: Vereniging[g.vereniging]
            }
        });
        console.log(`    Gebruiker [${g.voornaam} ${g.achternaam}] met id ${gebruiker.id} gemaakt.`);
    }

    console.log("  Shiftenlijst:")
    for (const s of voorbeeldData.Shiftenlijst) {
        const shiftenlijst = await prisma.shiftenlijst.create({
            data: {
                id: s.id,
                vereniging: Vereniging[s.vereniging],
                naam: s.naam,
                beschrijving: s.beschrijving,
                beheerders: { connect: s.beheerders.map(id => ({ id })) }
            }
        });
        console.log(`    Shiftenlijst [${s.naam}] met id ${shiftenlijst.id} gemaakt.`);
    }

    console.log("  Shift:")
    for (const s of voorbeeldData.Shift) {
        const shift = await prisma.shift.create({
            data: {
                lijstId: s.lijstId,
                naam: s.naam,
                beschrijving: s.beschrijving,
                locatie: s.locatie,
                begin: s.begin,
                duur: s.duur,
                herhalingen: s.herhalingen,
                maxShifters: s.maxShifters,
                combineerbaar: s.combineerbaar,
            }
        });

        console.log(`    Shiftenlijst [${s.naam}] met id ${shift.id} gemaakt.`);
    }

    console.log("Seedproces vervolledigd.")
}

main()
    .then(async () => {
        await prisma.$disconnect();
    })
    .catch(async (e) => {
        console.error(e);
        await prisma.$disconnect();
    });
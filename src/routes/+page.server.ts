import prisma from "$lib/server/prisma";
import type { PageServerLoad } from "./$types";

export const load: PageServerLoad = async () => {
    const shiftenlijsten = await prisma.shiftenlijst.findMany({include: { shiften: {include: {lijst: true}} }});

    return { shiftenlijsten }
}
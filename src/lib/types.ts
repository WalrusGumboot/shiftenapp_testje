import { type ShiftModel as Shift } from "$lib/prisma-client/models/Shift"
export type OngepubliceerdeShift = Omit<Shift, "id" | "lijst" | "lijstId">

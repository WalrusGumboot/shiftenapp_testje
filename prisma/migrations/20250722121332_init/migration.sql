-- CreateEnum
CREATE TYPE "Vereniging" AS ENUM ('Apolloon', 'LBK', 'Ekonomika', 'Farmaceutica', 'Canonica', 'Apollonia', 'Eros', 'KLA', 'Medica', 'Medisoc', 'Industria', 'VTK', 'Alfa', 'Babylon', 'Eoos', 'Historia', 'Mecenas', 'Musicologica', 'Pedagogische_Kring', 'Psychologische_Kring', 'Crimen', 'VRG', 'Politika', 'Katechetika', 'Atlas', 'BIOS', 'Chemika', 'Wina', 'NFK', 'Cluster', 'De_Kelten', 'Diana', 'Docentica', 'Soca', 'StEIL', 'LOKO', 'KOCO_Letteren', 'Scientica');

-- CreateTable
CREATE TABLE "VerenigingHiërarchie" (
    "id" SERIAL NOT NULL,
    "head" "Vereniging" NOT NULL,
    "body" "Vereniging"[],

    CONSTRAINT "VerenigingHiërarchie_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Gebruiker" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "voornaam" TEXT NOT NULL,
    "achternaam" TEXT NOT NULL,
    "vereniging" "Vereniging" NOT NULL,

    CONSTRAINT "Gebruiker_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shiftenlijst" (
    "id" TEXT NOT NULL,
    "vereniging" "Vereniging" NOT NULL,
    "naam" TEXT NOT NULL,
    "beschrijving" TEXT,

    CONSTRAINT "Shiftenlijst_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shift" (
    "id" SERIAL NOT NULL,
    "lijstId" TEXT NOT NULL,
    "vereniging" "Vereniging",
    "naam" TEXT NOT NULL,
    "beschrijving" TEXT,
    "locatie" TEXT NOT NULL,
    "begin" TIMESTAMP(3) NOT NULL,
    "duur" INTEGER NOT NULL,
    "herhalingen" INTEGER NOT NULL DEFAULT 1,
    "maxShifters" INTEGER,
    "maxVrijwilligers" INTEGER,
    "combineerbaar" BOOLEAN NOT NULL,

    CONSTRAINT "Shift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_GebruikerToShiftenlijst" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_GebruikerToShiftenlijst_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_GebruikerToShift" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_GebruikerToShift_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "Gebruiker_email_key" ON "Gebruiker"("email");

-- CreateIndex
CREATE INDEX "_GebruikerToShiftenlijst_B_index" ON "_GebruikerToShiftenlijst"("B");

-- CreateIndex
CREATE INDEX "_GebruikerToShift_B_index" ON "_GebruikerToShift"("B");

-- AddForeignKey
ALTER TABLE "Shift" ADD CONSTRAINT "Shift_lijstId_fkey" FOREIGN KEY ("lijstId") REFERENCES "Shiftenlijst"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GebruikerToShiftenlijst" ADD CONSTRAINT "_GebruikerToShiftenlijst_A_fkey" FOREIGN KEY ("A") REFERENCES "Gebruiker"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GebruikerToShiftenlijst" ADD CONSTRAINT "_GebruikerToShiftenlijst_B_fkey" FOREIGN KEY ("B") REFERENCES "Shiftenlijst"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GebruikerToShift" ADD CONSTRAINT "_GebruikerToShift_A_fkey" FOREIGN KEY ("A") REFERENCES "Gebruiker"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GebruikerToShift" ADD CONSTRAINT "_GebruikerToShift_B_fkey" FOREIGN KEY ("B") REFERENCES "Shift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

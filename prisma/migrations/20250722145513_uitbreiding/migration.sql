/*
  Warnings:

  - The primary key for the `Shiftenlijst` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Shiftenlijst` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `_GebruikerToShiftenlijst` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `_GebruikerToShift` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `lijstId` on the `Shift` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `B` on the `_GebruikerToShiftenlijst` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "Shift" DROP CONSTRAINT "Shift_lijstId_fkey";

-- DropForeignKey
ALTER TABLE "_GebruikerToShift" DROP CONSTRAINT "_GebruikerToShift_A_fkey";

-- DropForeignKey
ALTER TABLE "_GebruikerToShift" DROP CONSTRAINT "_GebruikerToShift_B_fkey";

-- DropForeignKey
ALTER TABLE "_GebruikerToShiftenlijst" DROP CONSTRAINT "_GebruikerToShiftenlijst_B_fkey";

-- AlterTable
ALTER TABLE "Shift" DROP COLUMN "lijstId",
ADD COLUMN     "lijstId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Shiftenlijst" DROP CONSTRAINT "Shiftenlijst_pkey",
ADD COLUMN     "intern" BOOLEAN NOT NULL DEFAULT false,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Shiftenlijst_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "_GebruikerToShiftenlijst" DROP CONSTRAINT "_GebruikerToShiftenlijst_AB_pkey",
DROP COLUMN "B",
ADD COLUMN     "B" INTEGER NOT NULL,
ADD CONSTRAINT "_GebruikerToShiftenlijst_AB_pkey" PRIMARY KEY ("A", "B");

-- DropTable
DROP TABLE "_GebruikerToShift";

-- CreateTable
CREATE TABLE "ShiftToekenning" (
    "id" SERIAL NOT NULL,
    "shiftId" INTEGER NOT NULL,
    "gebruikerId" INTEGER NOT NULL,
    "indices" INTEGER[] DEFAULT ARRAY[0]::INTEGER[],

    CONSTRAINT "ShiftToekenning_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Opmerking" (
    "id" SERIAL NOT NULL,
    "shiftId" INTEGER NOT NULL,
    "inhoud" TEXT NOT NULL,
    "afzender" TEXT NOT NULL DEFAULT 'SYSTEEM',
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Opmerking_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "_GebruikerToShiftenlijst_B_index" ON "_GebruikerToShiftenlijst"("B");

-- AddForeignKey
ALTER TABLE "Shift" ADD CONSTRAINT "Shift_lijstId_fkey" FOREIGN KEY ("lijstId") REFERENCES "Shiftenlijst"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShiftToekenning" ADD CONSTRAINT "ShiftToekenning_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "Shift"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShiftToekenning" ADD CONSTRAINT "ShiftToekenning_gebruikerId_fkey" FOREIGN KEY ("gebruikerId") REFERENCES "Gebruiker"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Opmerking" ADD CONSTRAINT "Opmerking_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "Shift"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GebruikerToShiftenlijst" ADD CONSTRAINT "_GebruikerToShiftenlijst_B_fkey" FOREIGN KEY ("B") REFERENCES "Shiftenlijst"("id") ON DELETE CASCADE ON UPDATE CASCADE;

/*
  Warnings:

  - You are about to alter the column `membresia` on the `trabajador` table. The data in that column could be lost. The data in that column will be cast from `DateTime(0)` to `DateTime`.
  - Added the required column `idTrabajador` to the `HistorialTrabajos` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `historialtrabajos` ADD COLUMN `idTrabajador` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `trabajador` MODIFY `membresia` DATETIME NOT NULL;

-- AddForeignKey
ALTER TABLE `HistorialTrabajos` ADD CONSTRAINT `HistorialTrabajos_idTrabajador_fkey` FOREIGN KEY (`idTrabajador`) REFERENCES `Trabajador`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

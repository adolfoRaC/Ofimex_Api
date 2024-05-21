/*
  Warnings:

  - You are about to alter the column `membresia` on the `trabajador` table. The data in that column could be lost. The data in that column will be cast from `DateTime(0)` to `DateTime`.
  - You are about to drop the column `disponible` on the `usuario` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[usuario]` on the table `Usuario` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `disponible` to the `Trabajador` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `trabajador` ADD COLUMN `disponible` BIT(1) NOT NULL,
    MODIFY `membresia` DATETIME NOT NULL;

-- AlterTable
ALTER TABLE `usuario` DROP COLUMN `disponible`;

-- CreateIndex
CREATE UNIQUE INDEX `Usuario_usuario_key` ON `Usuario`(`usuario`);

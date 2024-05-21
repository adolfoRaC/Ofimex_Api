/*
  Warnings:

  - You are about to alter the column `latitud` on the `direccion` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,0)` to `Decimal(9,6)`.
  - You are about to alter the column `longitud` on the `direccion` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,0)` to `Decimal(9,6)`.
  - You are about to alter the column `membresia` on the `trabajador` table. The data in that column could be lost. The data in that column will be cast from `DateTime(0)` to `DateTime`.

*/
-- AlterTable
ALTER TABLE `direccion` MODIFY `latitud` DECIMAL(9, 6) NOT NULL,
    MODIFY `longitud` DECIMAL(9, 6) NOT NULL;

-- AlterTable
ALTER TABLE `trabajador` MODIFY `membresia` DATETIME NOT NULL;

/*
  Warnings:

  - You are about to alter the column `membresia` on the `trabajador` table. The data in that column could be lost. The data in that column will be cast from `DateTime(0)` to `DateTime`.

*/
-- AlterTable
ALTER TABLE `trabajador` MODIFY `membresia` DATETIME NOT NULL;

-- CreateTable
CREATE TABLE `Direccion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `latitud` DECIMAL NOT NULL,
    `longitud` DECIMAL NOT NULL,
    `municipio` VARCHAR(35) NOT NULL,
    `colonia` VARCHAR(35) NOT NULL,
    `calle` VARCHAR(50) NOT NULL,
    `cp` INTEGER NOT NULL,
    `numeroExt` SMALLINT NOT NULL,
    `descripcion` VARCHAR(150) NOT NULL,
    `idTrabajo` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Direccion` ADD CONSTRAINT `Direccion_idTrabajo_fkey` FOREIGN KEY (`idTrabajo`) REFERENCES `HistorialTrabajos`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

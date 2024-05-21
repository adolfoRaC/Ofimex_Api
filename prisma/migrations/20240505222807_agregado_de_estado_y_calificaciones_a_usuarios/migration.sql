/*
  Warnings:

  - You are about to alter the column `membresia` on the `trabajador` table. The data in that column could be lost. The data in that column will be cast from `DateTime(0)` to `DateTime`.
  - Added the required column `idEstado` to the `HistorialTrabajos` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `historialtrabajos` ADD COLUMN `idEstado` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `trabajador` MODIFY `membresia` DATETIME NOT NULL;

-- CreateTable
CREATE TABLE `Estado` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Calificaciones` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `calificacion` TINYINT NOT NULL,
    `idUsuario` INTEGER NOT NULL,
    `idTrabajador` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `HistorialTrabajos` ADD CONSTRAINT `HistorialTrabajos_idEstado_fkey` FOREIGN KEY (`idEstado`) REFERENCES `Estado`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Calificaciones` ADD CONSTRAINT `Calificaciones_idUsuario_fkey` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Calificaciones` ADD CONSTRAINT `Calificaciones_idTrabajador_fkey` FOREIGN KEY (`idTrabajador`) REFERENCES `Trabajador`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

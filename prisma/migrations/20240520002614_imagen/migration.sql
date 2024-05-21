/*
  Warnings:

  - You are about to alter the column `latitud` on the `direccion` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,0)` to `Decimal`.
  - You are about to alter the column `longitud` on the `direccion` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,0)` to `Decimal`.
  - You are about to alter the column `descripcion` on the `direccion` table. The data in that column could be lost. The data in that column will be cast from `VarChar(150)` to `VarChar(50)`.
  - You are about to drop the column `idUsuario` on the `oficiotrabajado` table. All the data in the column will be lost.
  - You are about to alter the column `membresia` on the `trabajador` table. The data in that column could be lost. The data in that column will be cast from `DateTime(0)` to `DateTime`.
  - Added the required column `idTrabajador` to the `OficioTrabajado` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imagen` to the `Usuario` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `oficiotrabajado` DROP FOREIGN KEY `OficioTrabajado_idUsuario_fkey`;

-- AlterTable
ALTER TABLE `direccion` MODIFY `latitud` DECIMAL NOT NULL,
    MODIFY `longitud` DECIMAL NOT NULL,
    MODIFY `descripcion` VARCHAR(50) NOT NULL;

-- AlterTable
ALTER TABLE `evidenciatrabajos` MODIFY `idImagen` VARCHAR(500) NOT NULL;

-- AlterTable
ALTER TABLE `historialtrabajos` MODIFY `descripcion` VARCHAR(250) NOT NULL;

-- AlterTable
ALTER TABLE `imagencomentarios` MODIFY `idImagen` VARCHAR(500) NOT NULL;

-- AlterTable
ALTER TABLE `oficiotrabajado` DROP COLUMN `idUsuario`,
    ADD COLUMN `idTrabajador` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `trabajador` MODIFY `membresia` DATETIME NOT NULL;

-- AlterTable
ALTER TABLE `usuario` ADD COLUMN `imagen` VARCHAR(500) NOT NULL;

-- AddForeignKey
ALTER TABLE `OficioTrabajado` ADD CONSTRAINT `OficioTrabajado_idTrabajador_fkey` FOREIGN KEY (`idTrabajador`) REFERENCES `Usuario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

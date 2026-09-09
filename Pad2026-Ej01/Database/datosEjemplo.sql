ALTER TABLE dbo.Cliente ADD Domicilio NVARCHAR(200) NULL;

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO dbo.Cliente
        (dni, mail, nombre, apellido, telefono, Domicilio)
    VALUES
        (
            '99000001',
            N'ana.prueba@example.com',
            N'Ana',
            N'Pérez',
            '3810000001',
            N'Calle de Prueba 123, San Miguel de Tucumán'
        );

    DECLARE @IdAna INT = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO dbo.Cliente
        (dni, mail, nombre, apellido, telefono, Domicilio)
    VALUES
        (
            '99000002',
            N'lucas.prueba@example.com',
            N'Lucas',
            N'Gómez',
            '3810000002',
            N'Pasaje de Ejemplo 456, Yerba Buena'
        );

    DECLARE @IdLucas INT = CONVERT(INT, SCOPE_IDENTITY());


    INSERT INTO dbo.Producto (Descripcion, Precio)
    VALUES (N'Mouse inalámbrico USB', 15000.00);

    DECLARE @IdMouse INT = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO dbo.Producto (Descripcion, Precio)
    VALUES (N'Teclado mecánico USB', 45000.00);

    DECLARE @IdTeclado INT = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO dbo.Producto (Descripcion, Precio)
    VALUES (N'Auriculares con micrófono', 35000.00);

    DECLARE @IdAuriculares INT = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO dbo.Producto (Descripcion, Precio)
    VALUES (N'Monitor LED de 24 pulgadas', 180000.00);

    DECLARE @IdMonitor INT = CONVERT(INT, SCOPE_IDENTITY());


    IF NOT EXISTS (
        SELECT 1
        FROM dbo.Estado
        WHERE Descripcion = N'Pendiente'
    )
    BEGIN
        INSERT INTO dbo.Estado (Descripcion)
        VALUES (N'Pendiente');
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.Estado
        WHERE Descripcion = N'Confirmado'
    )
    BEGIN
        INSERT INTO dbo.Estado (Descripcion)
        VALUES (N'Confirmado');
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM dbo.Estado
        WHERE Descripcion = N'Entregado'
    )
    BEGIN
        INSERT INTO dbo.Estado (Descripcion)
        VALUES (N'Entregado');
    END;

    DECLARE @EstadoPendiente INT = (
        SELECT CodEstado
        FROM dbo.Estado
        WHERE Descripcion = N'Pendiente'
    );

    DECLARE @EstadoConfirmado INT = (
        SELECT CodEstado
        FROM dbo.Estado
        WHERE Descripcion = N'Confirmado'
    );

    DECLARE @EstadoEntregado INT = (
        SELECT CodEstado
        FROM dbo.Estado
        WHERE Descripcion = N'Entregado'
    );


    INSERT INTO dbo.Pedido
        (IdCliente, CodEstado, Observacion, MedioPago)
    VALUES
        (
            @IdAna,
            @EstadoPendiente,
            N'Retirar por el local durante la mañana.',
            N'Efectivo'
        );

    DECLARE @IdPedido1 INT = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO dbo.DetallePedido
        (IdPedido, IdProd, Cantidad, PrecioUnitario)
    SELECT @IdPedido1, IdProd, 2, Precio
    FROM dbo.Producto
    WHERE IdProd = @IdMouse;

    INSERT INTO dbo.DetallePedido
        (IdPedido, IdProd, Cantidad, PrecioUnitario)
    SELECT @IdPedido1, IdProd, 1, Precio
    FROM dbo.Producto
    WHERE IdProd = @IdTeclado;


    INSERT INTO dbo.Pedido
        (IdCliente, CodEstado, Observacion, MedioPago)
    VALUES
        (
            @IdLucas,
            @EstadoConfirmado,
            N'Coordinar la entrega por teléfono.',
            N'Transferencia'
        );

    DECLARE @IdPedido2 INT = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO dbo.DetallePedido
        (IdPedido, IdProd, Cantidad, PrecioUnitario)
    SELECT @IdPedido2, IdProd, 1, Precio
    FROM dbo.Producto
    WHERE IdProd = @IdMonitor;

    INSERT INTO dbo.DetallePedido
        (IdPedido, IdProd, Cantidad, PrecioUnitario)
    SELECT @IdPedido2, IdProd, 1, Precio
    FROM dbo.Producto
    WHERE IdProd = @IdAuriculares;


    INSERT INTO dbo.Pedido
        (IdCliente, CodEstado, Observacion, MedioPago)
    VALUES
        (
            @IdAna,
            @EstadoEntregado,
            N'Pedido retirado por la clienta.',
            N'Tarjeta de débito'
        );

    DECLARE @IdPedido3 INT = CONVERT(INT, SCOPE_IDENTITY());

    INSERT INTO dbo.DetallePedido
        (IdPedido, IdProd, Cantidad, PrecioUnitario)
    SELECT @IdPedido3, IdProd, 2, Precio
    FROM dbo.Producto
    WHERE IdProd = @IdAuriculares;


    COMMIT TRANSACTION;

    SELECT N'Datos de ejemplo cargados correctamente.' AS Resultado;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
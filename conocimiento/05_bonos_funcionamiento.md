# Bonos: funcionamiento

Un bono es un instrumento de deuda: el emisor se compromete a pagar una serie de flujos futuros (cupones y nominal) en fechas fijadas de antemano. Para quien lo compra es una inversión de contado; el pacto fija tasa, monto, moneda y precio.

## Tipos según la tasa

| Tipo | Cómo paga | Comportamiento |
| --- | --- | --- |
| Tasa fija | Cupón conocido desde la emisión (ej. TES 10%) | Es el más sensible a cambios de tasa de mercado |
| Indexado | Cupón = índice + spread (*contexto general:* IPC/UVR, IBR, DTF) | El cupón se ajusta con el índice; el precio varía menos por tasa |
| Cero cupón | No paga cupones; se compra con descuento y paga el nominal al vencimiento | Toda la rentabilidad es la diferencia entre precio de compra y nominal |

## Precio

**Frente al nominal (Excel del video 03, nominal 100):** prima = 105 (sobre la par), a la par = 100, descuento = 90.

**Limpio vs. sucio:** el precio limpio no incluye los intereses causados del cupón vigente; el precio sucio sí. El mercado cotiza limpio, pero se paga sucio.

Monto bruto = Nominal × (Precio limpio + Interés causado) / 100

## Fechas y liquidación

En el Bond Deal de Kondor+ se elige la liquidación D+1, D+3 FR, D+3 EU, D+N o Primary (mercado primario). Trade Date = fecha de negociación; Value Date = fecha de entrada en valor; Payment y Settlement Date = cuándo se paga y se entrega el título. Al vencimiento se paga el último cupón más el nominal (o el saldo, si el bono amortiza antes).

## Ejemplos reales en Kondor+

| Campo | TES Colombia (video 03) | Soberano Perú (videos 04 y 05) |
| --- | --- | --- |
| Quick input | BUY TE10.00%0724 10000.00 105.00 DIRECTO COP DCV | D_FIXIN SB12AGO24 10741447 1000000.00 103.3654 DIRECTO PEN CAVALI |
| Bono | TES B 10% vence 24/07/2024 | SB12AGO24 (vence 12/08/2024) |
| Operación | Compra, mercado primario | Compra, D+N, folder TRAD_FIXIN (Trading Fixed Income) |
| Negociación y valor | 03/10/2022 | 15/12/2021 |
| Nominal | COP 10.000 | PEN 1.000.000 (cantidad 1.000) |
| Precio limpio | 105,0000 | 103,3654 |
| Rendimiento (yield) | 6,9274% | 4,3300% |
| Interés causado | 1,9452 | 1,936141304 |
| Monto bruto | ≈ COP 10.694,52 (calculado) | PEN 1.053.015,41 |
| Depósito / contraparte | DCV | CAVALI / Banco Central de Reserva del Perú |

Causado del TES: el cupón anual del 10% se pagó el 24/07/2022; al 03/10/2022 van 71 días, y 10 × 71/365 = 1,945. En el bono peruano, el causado coincide con un cupón semestral de 5,70% durante 125 de 184 días (inferido; la tasa del cupón no aparece en pantalla).

## Comportamiento (*contexto general* que explica los ejemplos)

- **Precio y tasa van en sentido contrario.** Si suben las tasas de mercado, el precio cae; si bajan, sube.
- **Prima o descuento según cupón vs. mercado.** Con cupón por encima de la tasa de mercado el bono cotiza con prima, por eso el TES de 10% a 105 rinde 6,93%. Con cupón por debajo, cotiza con descuento.
- **Convergencia a la par.** Al acercarse el vencimiento, el precio tiende a 100.
- **Sensibilidad al plazo.** A mayor plazo (duración), mayor variación del precio ante un cambio de tasa.
- **Ciclo del causado.** El interés causado crece cada día y vuelve a cero en cada fecha de pago de cupón.
